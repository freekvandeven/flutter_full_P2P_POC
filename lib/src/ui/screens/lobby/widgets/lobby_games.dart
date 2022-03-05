import 'package:distributed/src/routes.dart';
import 'package:distributed/src/ui/widgets/dialogs/join_lobby.dart';
import 'package:flutter/material.dart';

class BrowserGameslistWidget extends StatelessWidget {
  const BrowserGameslistWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'All Active Games:',
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
                  'Game $index: (Lobby name, number players)',
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
                onTap: () async {
                  debugPrint('Tapped on game $index');
                  var navigator = Navigator.of(context);

                  var code = await showDialog(
                    context: context,
                    builder: (BuildContext context) => JoinLobbyDialog(),
                  );
                  if (code == 'Join') {
                    // make connection to the selected lobby
                    await navigator.pushNamed(
                      ChipsRoute.lobbyScreen.route,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
