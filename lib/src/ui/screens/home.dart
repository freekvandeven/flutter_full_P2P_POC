import 'package:distributed/src/routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Play the Beer Game'),
        Text('Learn supply-chain principles through a visual simulation'),
        GestureDetector(
          onTap: () {
            // create your own lobby and go to the lobby screen
            Navigator.pushNamed(context, ChipsRoute.lobbyScreen.route);
          },
          child: Text('Start a new game'),
        ),
        GestureDetector(
          onTap: (){
            // look for existing lobbies on the network and join them
            Navigator.pushNamed(context, ChipsRoute.gameBrowserScreen.route);
          },
          child: Text('Join an existing game'),
        ),
        SizedBox(height: 10,),
        GestureDetector(
          onTap: (){
            // change your app settings
            Navigator.pushNamed(context, ChipsRoute.settingsScreen.route);
          },
          child: Text('Change settings'),
        ),
        SizedBox(height: 20,),
        Text('Explination of the game'),
      ],
    );
  }
}
