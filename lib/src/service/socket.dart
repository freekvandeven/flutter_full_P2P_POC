import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

abstract class SocketService {
  Future<ServerSocket> startServer();
  ServerSocket? getSocket();
  Future<Socket> connectSocket(String socket);
  void close();
}

class ChipsSocketService implements SocketService {
  ServerSocket? _socket;
  Socket? _clientSocket;

  @override
  Future<ServerSocket> startServer() async {
    debugPrint('starting server');
    if (_socket != null) {
      debugPrint('server already started');
      return _socket!;
    }
    _socket = await ServerSocket.bind(
      InternetAddress.anyIPv4,
      0,
    );
    _socket?.listen(
      handleConnection,
    );
    return _socket!;
  }

  void handleConnection(Socket client) {
    debugPrint(
      'Connection from'
      ' ${client.remoteAddress.address}:${client.remotePort}',
    );

    // listen for events from the client
    client.listen(
      // handle data from the client
      (Uint8List data) async {
        debugPrint('received data');
        await Future.delayed(Duration(seconds: 1));
        var message = String.fromCharCodes(data);
        if (message == 'Knock, knock.') {
          client.write('Who is there?');
        } else if (message.length < 10) {
          client.write('$message who?');
        } else {
          client.write('Very funny.');
          unawaited(client.close());
        }
      },

      // handle errors
      onError: (error) {
        debugPrint(error);
        client.close();
      },

      // handle the client closing the connection
      onDone: () {
        debugPrint('Client left');
        client.close();
      },
    );
  }

  @override
  ServerSocket? getSocket() {
    return _socket;
  }

  @override
  void close() {
    _socket?.close();
  }

  @override
  Future<Socket> connectSocket(String port) async {
    debugPrint('connecting socket');
    _clientSocket = await Socket.connect('192.168.188.27', int.parse(port));
    debugPrint(
      'Connected to: ${_clientSocket!.remoteAddress.address}:'
      '${_clientSocket!.remotePort}',
    );

    _clientSocket?.listen(
      // handle data from the server
      (Uint8List data) {
        var serverResponse = String.fromCharCodes(data);
        debugPrint('Server: $serverResponse');
      },

      // handle errors
      onError: (error) {
        debugPrint(error);
        _clientSocket?.destroy();
      },

      // handle server ending connection
      onDone: () {
        debugPrint('Server left.');
        _clientSocket?.destroy();
      },
    );

    // send some messages to the server
    await sendMessage(_clientSocket!, 'Knock, knock.');
    await sendMessage(_clientSocket!, 'Banana');
    await sendMessage(_clientSocket!, 'Banana');
    await sendMessage(_clientSocket!, 'Banana');
    await sendMessage(_clientSocket!, 'Banana');
    await sendMessage(_clientSocket!, 'Banana');
    await sendMessage(_clientSocket!, 'Orange');
    await sendMessage(
      _clientSocket!,
      "Orange you glad I didn't say banana again?",
    );

    return _clientSocket!;
  }

  Future<void> sendMessage(Socket socket, String message) async {
    debugPrint('Client: $message');
    socket.write(message);
    await Future.delayed(Duration(seconds: 2));
  }
}
