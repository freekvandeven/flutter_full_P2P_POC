import 'package:distributed/src/routes.dart';
import 'package:distributed/src/service/socket.dart';
import 'package:distributed/src/ui/screens/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  String ip = '';
  List<String> players = [];

  @override
  void initState() {
    debugPrint('LobbyScreen initState');
    context.read<SocketService>().startServer().then(
          (value) => setState(() {
            ip = '${value.address} port: ${value.port.toString()}';
          }),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
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
                  'Your Server IP: $ip',
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
                          'Player $index: ${players[index]}',
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
