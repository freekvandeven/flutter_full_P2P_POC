import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:distributed/src/models/player.dart';
import 'package:distributed/src/service/game.dart';
import 'package:flutter/material.dart';

abstract class ServerSocketService implements ChangeNotifier {
  ServerSocketService._();
  Future<void> startServer();
  ServerSocket? getSocket();
}

class ChipsServerSocketService extends ChangeNotifier
    implements ServerSocketService {
  ChipsServerSocketService({required this.gameService});

  final GameService gameService;
  ServerSocket? _socket;
  final List<Socket> _connectedClients = [];

  @override
  Future<void> startServer() async {
    debugPrint('starting server');
    if (_socket != null) {
      debugPrint('server already started');
    } else {
      _socket = await ServerSocket.bind(
        InternetAddress.anyIPv4,
        0,
      );
      _socket?.listen(
        handleConnection,
      );
    }
    notifyListeners();
  }

  void handleConnection(Socket client) {
    debugPrint(
      'Connection from'
      ' ${client.remoteAddress.address}:${client.remotePort}',
    );
    _connectedClients.add(client);
    // listen for events from the client
    client.listen(
      // handle data from the client
      (Uint8List data) async {
        debugPrint('received data');
        var message = String.fromCharCodes(data);
        if (message.contains('Player connect:')) {
          debugPrint('player trying to connect');
          var playerInfo = message.split(':')[1];
          var playerName = playerInfo.split(',')[0];
          var playerIp = playerInfo.split(',')[1];
          var playerPort = playerInfo.split(',')[2];
          gameService.addNewPlayer(
            PlayerInformation(
              playerName: playerName,
              ip: playerIp,
              port: playerPort,
            ),
          );
          client.write('You are connected');
          // if host tell all the client information
        } else {
          client.write('Message received.');
          unawaited(client.close());
        }
      },

      // handle errors
      onError: (error) {
        debugPrint(error);
        _connectedClients.remove(client);
        client.close();
      },

      // handle the client closing the connection
      onDone: () {
        debugPrint('Client left');
        _connectedClients.remove(client);
        client.close();
      },
    );
  }

  @override
  ServerSocket? getSocket() {
    return _socket;
  }
}
