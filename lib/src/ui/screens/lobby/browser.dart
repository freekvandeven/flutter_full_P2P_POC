import 'package:distributed/src/models/player.dart';
import 'package:distributed/src/routes.dart';
import 'package:distributed/src/service/client.dart';
import 'package:distributed/src/service/game.dart';
import 'package:distributed/src/service/server.dart';
import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:flutter/material.dart';

class GameBrowserScreen extends StatefulWidget {
  const GameBrowserScreen({
    required this.serverSocketService,
    required this.clientSocketService,
    required this.gameService,
    Key? key,
  }) : super(key: key);

  final ServerSocketService serverSocketService;
  final ClientSocketService clientSocketService;
  final GameService gameService;

  @override
  State<GameBrowserScreen> createState() => _GameBrowserScreenState();
}

class _GameBrowserScreenState extends State<GameBrowserScreen> {
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
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
        playerName: _nameController.text,
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
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              //lineargradient
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFe8e9eb),
                  Color(0xFFc5cad6),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'All active Games:',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 10),
                Text(
                  'Type port and IP to connect:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _ipController,
                    decoration: InputDecoration(
                      hintText: 'Ip',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _portController,
                    decoration: InputDecoration(
                      hintText: 'Port',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Playername',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_portController.text.isNotEmpty &&
                        _ipController.text.isNotEmpty &&
                        int.tryParse(_portController.text) != null) {
                      widget.serverSocketService.startServer();
                      widget.clientSocketService.addListener(onConnected);
                      widget.clientSocketService.connectSocket(
                        _ipController.text,
                        int.parse(_portController.text),
                      );
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.connect_without_contact),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Connect'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
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
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
