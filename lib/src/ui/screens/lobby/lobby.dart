import 'package:distributed/src/models/player.dart';
import 'package:distributed/src/routes.dart';
import 'package:distributed/src/service/game.dart';
import 'package:distributed/src/service/ip.dart';
import 'package:distributed/src/service/server.dart';
import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:distributed/src/ui/widgets/dialogs/exit_lobby.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({
    required this.ipService,
    required this.socketService,
    required this.gameService,
    Key? key,
  }) : super(key: key);
  final IpService ipService;
  final ServerSocketService socketService;
  final GameService gameService;
  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  String ipv6 = '';
  String ipv4 = '';
  String port = '';
  List<PlayerInformation> players = [];

  @override
  void initState() {
    super.initState();
    debugPrint('LobbyScreen initState');
    // players = widget.gameService.getGame()!.gameInformation.players;
    // // add postframe callback to get ip
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   widget.ipService.addListener(updateIp);
    //   widget.ipService.getIpAddress();
    //   widget.socketService.addListener(updatePort);
    //   widget.socketService.startServer();
    //   widget.gameService.addListener(updateGameInformation);
    // });
  }

  void updateGameInformation() {
    setState(() {
      if (widget.gameService.getGame() != null) {
        players = widget.gameService.getGame()!.gameInformation.players;
      }
    });
  }

  void updatePort() {
    if (mounted) {
      setState(() {
        port = widget.socketService.getSocket()!.port.toString();
      });
    }
    if (widget.gameService.getGame() != null) {
      widget.gameService.addNewPlayer(
        PlayerInformation(
          playerName: 'host',
          ip: ipv6,
          port: port,
        ),
      );
    }
  }

  void updateIp() {
    if (mounted) {
      setState(() {
        ipv4 = widget.ipService.ipInformation!['ipv4'] ?? 'error';
        ipv6 = widget.ipService.ipInformation!['ipv6'] ?? 'error';
      });
    }
  }

  @override
  void dispose() {
    widget.ipService.removeListener(updateIp);
    widget.socketService.removeListener(updatePort);
    widget.gameService.removeListener(updateGameInformation);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      escapeTrigger: () async {
        var navigator = Navigator.of(context);
        var code = await showDialog(
          context: context,
          builder: (BuildContext context) => ExitLobbyDialog(),
        );
        if (code == 'Exit') {
          navigator.pop();
        }
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 120, 185, 238),
                  Color.fromARGB(255, 149, 179, 230),
                ],
              ),
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Lobby Screen',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Lobby information:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'Your Server IPv4: $ipv4',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'Your Server IPv6: $ipv6',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'Your Server Port: $port',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Column(
                  children: [
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Lobby name',
                      ),
                    ),
                    Text(
                      'Connected players: ${players.length}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: players.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                          'Player $index: ${players[index].playerName}',
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ChipsRoute.gameScreen.route,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ChipsRoute.gameScreen.route);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_outline_outlined,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Start Game'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Go Back'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
