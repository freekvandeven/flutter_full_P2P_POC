import 'dart:io';

class PlayerInformation {
  PlayerInformation(this.playerName, this.socket);

  String? playerName;
  Socket? socket;


  void closeSocket(){
    socket?.close();
  }
}
