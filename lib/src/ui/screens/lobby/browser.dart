import 'package:distributed/src/models/player.dart';
import 'package:distributed/src/routes.dart';
import 'package:distributed/src/service/client.dart';
import 'package:distributed/src/service/game.dart';
import 'package:distributed/src/service/scan.dart';
import 'package:distributed/src/service/server.dart';
import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:distributed/src/ui/screens/lobby/widgets/lobby_games.dart';
import 'package:distributed/src/ui/screens/lobby/widgets/manual_connect.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class GameBrowserScreen extends StatefulWidget {
  const GameBrowserScreen({
    required this.serverSocketService,
    required this.clientSocketService,
    required this.gameService,
    required this.networkScanService,
    Key? key,
  }) : super(key: key);

  final ServerSocketService serverSocketService;
  final ClientSocketService clientSocketService;
  final NetworkScanService networkScanService;
  final GameService gameService;

  @override
  State<GameBrowserScreen> createState() => _GameBrowserScreenState();
}

class _GameBrowserScreenState extends State<GameBrowserScreen> {
  bool routed = false;
  @override
  void dispose() {
    widget.clientSocketService.removeListener(onConnected);
    widget.gameService.removeListener(onJoined);
    super.dispose();
  }

  void onConnected() {
    debugPrint('connected to the server');
    debugPrint('time to provide our own name, ip and port');
    widget.clientSocketService.sendPlayerInfo(
      PlayerInformation(
        playerName: 'Freek',
        ip: 'test',
        port: '1000',
      ),
    );
    // Navigator.pushNamed(context, ChipsRoute.lobbyScreen.route);
  }

  void onJoined() {
    if (mounted && !routed) {
      routed = true;
      debugPrint('routing to next screen');
      Navigator.pushNamed(context, ChipsRoute.lobbyScreen.route);
    }
  }

  @override
  void initState() {
    widget.gameService.addListener(onJoined);
    widget.networkScanService.scanLocalNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      escapeTrigger: () {
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 120, 185, 238),
                  Color.fromARGB(255, 149, 179, 230),
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Browser Screen',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: BrowserGameslistWidget(),
                    ),
                    Flexible(
                      child: Center(
                        child: ManualConnectWidget(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Go Back',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
