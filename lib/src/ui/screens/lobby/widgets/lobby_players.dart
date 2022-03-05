import 'package:distributed/src/models/player.dart';
import 'package:distributed/src/ui/widgets/dialogs/player_info.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 200.0,
            vertical: 20.0,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  'Player $index: (name, role)',
                  textAlign: TextAlign.center,
                ),
                selected: true,
                tileColor: Colors.amberAccent,
                selectedTileColor: Colors.green,
                textColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                iconColor: Colors.green,
                onTap: () {
                  debugPrint('Tapped on player $index');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => PlayerInfoDialog(),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
