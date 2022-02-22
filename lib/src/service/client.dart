import 'dart:io';
import 'dart:typed_data';

import 'package:distributed/src/models/player.dart';
import 'package:distributed/src/service/game.dart';
import 'package:flutter/material.dart';

abstract class ClientSocketService implements ChangeNotifier {
  ClientSocketService._();
  List<Socket> getClients();
  Future<void> connectSocket(String ip, int port);

  void sendPlayerInfo(PlayerInformation playerInformation);
}

class ChipsClientSocketService extends ChangeNotifier
    implements ClientSocketService {
  ChipsClientSocketService({required this.gameService});
  final GameService gameService;
  final List<Socket> _connectedClients = [];

  @override
  Future<void> connectSocket(String ip, int port) async {
    debugPrint('connecting to other socket');
    // check if the socket is already connected
    if (_connectedClients.any(
      (element) =>
          element.remoteAddress.address == ip && element.remotePort == port,
    )) {
      debugPrint('socket already connected');
      return;
    }
    var socket = await Socket.connect(
      InternetAddress(
        // check if platform is android
        Platform.isAndroid
            ? '$ip%wlan0'
            : ip, //'linux: wlp3s0', android '%wlan'
        type: InternetAddressType.any,
      ),
      port,
    );
    debugPrint(
      'Connected to: ${socket.remoteAddress.address}:'
      '${socket.remotePort}',
    );

    socket.listen(
      // handle data from the server
      (Uint8List data) {
        var serverResponse = String.fromCharCodes(data);
        debugPrint('Server: $serverResponse');
        if (serverResponse == 'You are connected') {
          debugPrint('connected to the host');
          gameService.joinGame();
        }
      },

      // handle errors
      onError: (error) {
        debugPrint(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        debugPrint('Server left.');
        socket.destroy();
      },
    );
    _connectedClients.add(socket);

    notifyListeners();
  }

  // sends message to all clients
  Future<void> sendMessage(String message) async {
    debugPrint('Message: $message');
    for (var client in _connectedClients) {
      client.write(message);
    }
  }

  @override
  List<Socket> getClients() {
    return _connectedClients;
  }

  @override
  void sendPlayerInfo(PlayerInformation playerInformation) {
    if (_connectedClients.isNotEmpty) {
      var message = 'Player connect:${playerInformation.playerName},'
          '${playerInformation.ip},'
          '${playerInformation.port}';
      _connectedClients.first.write(message);
    }
  }
}
