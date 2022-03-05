import 'package:distributed/src/service/ip.dart';
import 'package:distributed/src/service/server.dart';
import 'package:distributed/src/ui/screens/base/pagenotfound.dart';
import 'package:distributed/src/ui/screens/game/end.dart';
import 'package:distributed/src/ui/screens/game/game.dart';
import 'package:distributed/src/ui/screens/game/replay.dart';
import 'package:distributed/src/ui/screens/home/home.dart';
import 'package:distributed/src/ui/screens/lobby/browser.dart';
import 'package:distributed/src/ui/screens/lobby/lobby.dart';
import 'package:distributed/src/ui/screens/settings/credits.dart';
import 'package:distributed/src/ui/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChipsRoute {
  const ChipsRoute(this.route);

  //global
  static const homeScreen = ChipsRoute('home-screen');
  static const settingsScreen = ChipsRoute('settings-screen');
  static const gameBrowserScreen = ChipsRoute('game-browser-screen');
  static const lobbyScreen = ChipsRoute('lobby-screen');
  static const gameScreen = ChipsRoute('game-screen');
  static const endScreen = ChipsRoute('end-screen');
  static const creditScreen = ChipsRoute('credit-screen');
  static const replayScreen = ChipsRoute('replay-screen');
  static const pageNotExist = ChipsRoute('page-not-exist');

  final String route;

  @override
  String toString() {
    return route;
  }

  // NavigateAction root([NavigateAction? parent]) =>
  //     _asCallBack(root: true, parent: parent);
  // NavigateAction replacement([
  //   NavigateAction? parent,
  // ]) =>
  //     _asCallBack(parent: parent);
  // NavigateAction push([NavigateAction? parent]) =>
  //     _asCallBack(nested: true, parent: parent);

  // NavigateAction _asCallBack({
  //   bool root = false,
  //   bool nested = false,
  //   NavigateAction? parent,
  // }) {
  //   return (context) {
  //     parent?.call(context);
  //     if (root) {
  //       context.navRoot(this);
  //     } else if (nested) {
  //       context.navPush(this);
  //     } else {
  //       context.navReplace(this);
  //     }
  //   };
  // }

  // static NavigateAction back() {
  //   return (context) {
  //     context.pop();
  //   };
  // }
}

typedef NavigateAction = void Function(
  BuildContext,
  Animation<double>,
  Animation<double>,
);

typedef AnimatedWidgetBuilder = Widget Function(
  BuildContext,
  Animation<double>,
  Animation<double>,
);
Map<String, WidgetBuilder> getRoutes() {
  return <
      ChipsRoute,
      Widget Function(
    BuildContext,
  )>{
    ChipsRoute.homeScreen: (context) => HomeScreen(
          gameService: context.read(),
        ),
    ChipsRoute.gameBrowserScreen: (context) => GameBrowserScreen(
          serverSocketService: context.read(),
          clientSocketService: context.read(),
          gameService: context.read(),
        ),
    ChipsRoute.lobbyScreen: (context) => LobbyScreen(
          socketService: context.read<ServerSocketService>(),
          ipService: context.read<IpService>(),
          gameService: context.read(),
        ),
    ChipsRoute.gameScreen: (context) => GameScreen(),
    ChipsRoute.endScreen: (context) => GameEndScreen(),
    ChipsRoute.replayScreen: (context) => ReplayScreen(),
    ChipsRoute.settingsScreen: (context) => SettingsScreen(),
    ChipsRoute.creditScreen: (context) => CreditsScreen(),
    ChipsRoute.pageNotExist: (context) => PageNotFound(),
  }.map((key, value) => MapEntry(key.toString(), value));
}

Map<String, AnimatedWidgetBuilder> getAnimatedRoutes() {
  return <
      ChipsRoute,
      Widget Function(
    BuildContext,
    Animation<double>,
    Animation<double>,
  )>{
    ChipsRoute.homeScreen: (context, _, __) => HomeScreen(
          gameService: context.read(),
        ),
    ChipsRoute.gameBrowserScreen: (context, _, __) => GameBrowserScreen(
          serverSocketService: context.read(),
          clientSocketService: context.read(),
          gameService: context.read(),
        ),
    ChipsRoute.lobbyScreen: (context, _, __) => LobbyScreen(
          socketService: context.read<ServerSocketService>(),
          ipService: context.read<IpService>(),
          gameService: context.read(),
        ),
    ChipsRoute.gameScreen: (context, _, __) => GameScreen(),
    ChipsRoute.endScreen: (context, _, __) => GameEndScreen(),
    ChipsRoute.replayScreen: (context, _, __) => ReplayScreen(),
    ChipsRoute.settingsScreen: (context, _, __) => SettingsScreen(),
    ChipsRoute.creditScreen: (context, _, __) => CreditsScreen(),
    ChipsRoute.pageNotExist: (context, _, __) => PageNotFound(),
  }.map((key, value) => MapEntry(key.toString(), value));
}
