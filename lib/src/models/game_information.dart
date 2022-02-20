import 'package:distributed/src/models/player.dart';

class GameInformation {
  List<PlayerInformation> players = [];
  String gameName = '';
  int totalTurns = 52;
  int currentTurn = 0;
  int secondPerTurn = 10;
}
