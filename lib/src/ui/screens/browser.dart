import 'package:distributed/src/routes.dart';
import 'package:flutter/material.dart';

class GameBrowserScreen extends StatelessWidget {
  const GameBrowserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('All active Games:'),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                title: Text('Game $index'),
                onTap: () {
                  Navigator.pushNamed(context, ChipsRoute.gameScreen.route);
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text('Go back'),
          )
        ],
      ),
    );
  }
}
