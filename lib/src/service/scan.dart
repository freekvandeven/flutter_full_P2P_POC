import 'dart:convert';
import 'dart:io';

import 'package:distributed/src/models/responses/scan_information.dart';
import 'package:distributed/src/service/ip.dart';
import 'package:flutter/material.dart';

abstract class NetworkScanService implements ChangeNotifier {
  NetworkScanService._();

  Future<void> scanLocalNetwork();
}

class ChipsNetworkScanService extends ChangeNotifier
    implements NetworkScanService {
  ChipsNetworkScanService({
    required this.ipService,
  });
  final IpService ipService;
  List<ScanInformation> lobbies = [];

  @override
  Future<void> scanLocalNetwork() async {
    lobbies = [];
    var network = await ipService.getIpAddress();
    if (network.wifiIPv4 != null) {
      debugPrint('wifi ipv4: ${network.wifiIPv4}');
      const port = 42069;
      var subnet =
          network.wifiIPv4!.substring(0, network.wifiIPv4!.lastIndexOf('.'));
      for (var i = 0; i < 256; i++) {
        var ip = '$subnet.$i';
        await Socket.connect(
          ip,
          port,
          timeout: Duration(
            milliseconds: 50,
          ),
        ).then((socket) async {
          debugPrint('contacted: $ip');
          listenForLobbyInformation(socket);
          await InternetAddress(socket.address.address).reverse().then((value) {
            debugPrint(value.host);
            debugPrint(socket.address.address);
          }).catchError((error) {
            debugPrint(socket.address.address);
            debugPrint('Error: $error');
          });
          socket.destroy();
        }).catchError((error) => null);
      }
    }
    notifyListeners();
  }

  void listenForLobbyInformation(Socket socket) {
    socket
      ..write('Whats up?')
      ..listen((event) {
        var message = String.fromCharCodes(event);
        var lobby = ScanInformation.fromJson(jsonDecode(message));
        lobbies.add(lobby);
        debugPrint('received: $lobby');
      });
  }
}
