import 'package:distributed/src/models/game_information.dart';
import 'package:distributed/src/models/player.dart';
import 'package:distributed/src/routes.dart';
import 'package:distributed/src/service/game.dart';
import 'package:distributed/src/service/ip.dart';
import 'package:distributed/src/service/server.dart';
import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:distributed/src/ui/screens/lobby/widgets/host_configuration.dart';
import 'package:distributed/src/ui/screens/lobby/widgets/lobby_players.dart';
import 'package:distributed/src/ui/screens/lobby/widgets/player_configuration.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:distributed/src/ui/widgets/chat.dart';
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
  bool lobbyStarted = false;
  String ipv6 = '';
  String ipv4 = '';
  String port = '';
  List<PlayerInformation> players = [];
  Map<String, String> ipInformation = {};
  String playerName = '';
  String playerRole = '';
  String playerAgent = '';
  GameInformation gameInformation = GameInformation();

  @override
  void initState() {
    super.initState();
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
        ipInformation = widget.ipService.ipInformation!;
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

  Future<void> exitLobby() async {
    var navigator = Navigator.of(context);
    var code = await showDialog(
      context: context,
      builder: (BuildContext context) => ExitLobbyDialog(),
    );
    if (code == 'Exit') {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      escapeTrigger: () async {
        await exitLobby();
      },
      child: SingleChildScrollView(
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
                      'Lobby Screen',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: LobbyPlayerlistWidget(
                          players: players,
                        ),
                      ),
                      Flexible(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: HostConfigurationWidget(
                                  lobbyStarted: lobbyStarted,
                                  gameInformation: gameInformation,
                                  onSave: (game) {
                                    debugPrint('update game information');
                                    setState(() {
                                      gameInformation = game;
                                    });
                                  },
                                  isHost: true,
                                  ipInformation: ipInformation,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PlayerConfigurationWidget(
                                  playerName: playerName,
                                  playerRole: playerRole,
                                  playerAgentCode: playerAgent,
                                  onSave: (name, role, agent) {
                                    // resend the playerinformation
                                    setState(() {
                                      playerName = name;
                                      playerRole = role;
                                      playerAgent = agent;
                                    });
                                    debugPrint('playerinformation updated');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (lobbyStarted) {
                        Navigator.of(context)
                            .pushNamed(ChipsRoute.gameScreen.route);
                      } else {
                        setState(() {
                          lobbyStarted = true;
                        });
                      }
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
                        children: [
                          Icon(
                            Icons.play_circle_outline_outlined,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Start ${lobbyStarted ? 'Game' : 'Lobby'}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  PrimaryButton(
                    onPressed: () async {
                      await exitLobby();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Exit Lobby',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            ChatWindow(),
          ],
        ),
      ),
    );
  }
}
