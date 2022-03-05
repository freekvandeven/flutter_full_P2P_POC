import 'package:distributed/src/models/player.dart';

class GameInformation {
  GameInformation({
    this.gameName = '',
    this.totalTurns = 52,
    this.secondPerTurn = 10,
    this.playerLimit = 4,
  });
  List<PlayerInformation> players = [];
  String gameName = '';
  int totalTurns = 52;
  int currentTurn = 0;
  int secondPerTurn = 10;
  int playerLimit = 4;
}
