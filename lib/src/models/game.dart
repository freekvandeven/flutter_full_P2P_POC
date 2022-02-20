import 'package:distributed/src/models/game_data.dart';
import 'package:distributed/src/models/game_information.dart';
import 'package:flutter/widgets.dart';

class Game extends ChangeNotifier{
  Game({
    required this.isHost,
  });
  bool isHost = false;
  GameInformation gameInformation = GameInformation();
  GameData gameData = GameData();

  void setGameInformation(GameInformation gameInformation){
    this.gameInformation = gameInformation;
    notifyListeners();
  }
}
