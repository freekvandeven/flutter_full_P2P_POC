import 'package:distributed/src/models/game.dart';
import 'package:distributed/src/models/player.dart';
import 'package:distributed/src/models/responses/scan_information.dart';
import 'package:distributed/src/service/services.dart';
import 'package:flutter/material.dart';

abstract class GameService implements ChangeNotifier {
  GameService._();

  void hostGame();
  void joinGame();
  Game? getGame();
  void addNewPlayer(PlayerInformation player);
  ScanInformation getGameInformation();
}

class ChipsGameService extends ChangeNotifier implements GameService {
  ChipsGameService({required this.ipService});
  final IpService ipService;
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

  @override
  ScanInformation getGameInformation() {
    return ScanInformation(
      lobbyName: 'test',
      connectedPlayers: 1,
      maxPlayers: 4,
      entryIP: ipService.ipInformation!.wifiIPv4!,
      started: false,
    );
  }
}
