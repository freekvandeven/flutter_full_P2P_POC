import 'package:distributed/src/routes.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Lobby Screen'),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ChipsRoute.gameScreen.route);
          },
          child: Text('Go to game'),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Text('Go Back'),
        ),
      ],
    );
  }
}
