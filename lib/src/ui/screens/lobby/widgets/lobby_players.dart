import 'package:distributed/src/models/player.dart';
import 'package:flutter/material.dart';

class LobbyPlayerlistWidget extends StatelessWidget {
  const LobbyPlayerlistWidget({
    required this.players,
    Key? key,
  }) : super(key: key);

  final List<PlayerInformation> players;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Lobby players:',
          style: Theme.of(context).textTheme.headline2,
        ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                'Player $index: ',
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
