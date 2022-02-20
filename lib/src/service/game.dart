import 'package:distributed/src/models/game.dart';
import 'package:distributed/src/models/player.dart';
import 'package:flutter/material.dart';

abstract class GameService implements ChangeNotifier {
  GameService._();

  void hostGame();
  void joinGame();
  Game? getGame();
  void addNewPlayer(PlayerInformation player);
}

class ChipsGameService extends ChangeNotifier implements GameService {
  ChipsGameService();
  Game? game;

  @override
  void hostGame() {
    debugPrint('hosting game');
    game = Game(isHost: true);
  }

  @override
  void joinGame() {
    debugPrint('joining game');
    game = Game(isHost: false);
    notifyListeners();
  }

  @override
  Game? getGame() {
    return game;
  }

  @override
  void addNewPlayer(PlayerInformation player) {
    if (game != null) {
      if (!game!.gameInformation.players.contains(player)) {
        game!.gameInformation.players.add(player);
      }
      notifyListeners();
    }
  }
}
