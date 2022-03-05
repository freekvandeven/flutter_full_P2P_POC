import 'package:distributed/src/routes.dart';
import 'package:distributed/src/service/game.dart';
import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:distributed/src/ui/widgets/dialogs/quit_app.dart';
import 'package:distributed/src/ui/widgets/game_explainer.dart';
import 'package:distributed/src/ui/widgets/painters/graph_painter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.gameService, Key? key}) : super(key: key);
  final GameService gameService;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      escapeTrigger: () {
        debugPrint('opening exit dialog');
        showDialog(
          context: context,
          builder: (BuildContext context) => QuitAppDialog(),
        );
      },
      child: SingleChildScrollView(
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
              child: DecoratedBox(
                decoration: GraphPainter(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0, bottom: 10),
                      child: Text(
                        'Play the Beer Game',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Text(
                      'Learn supply-chain principles '
                      'through a visual simulation',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 50),
                    PrimaryButton(
                      onPressed: () {
                        // widget.gameService.hostGame();
                        // create your own lobby and go to the lobby screen
                        Navigator.pushNamed(
                          context,
                          ChipsRoute.lobbyScreen.route,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_box_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Start a new game',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        // look for existing lobbies on the network
                        Navigator.pushNamed(
                          context,
                          ChipsRoute.gameBrowserScreen.route,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.exit_to_app_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Join an existing game',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        // look for previous games
                        Navigator.pushNamed(
                          context,
                          ChipsRoute.replayScreen.route,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.replay),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Watch a replay',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        // change your app settings
                        Navigator.pushNamed(
                          context,
                          ChipsRoute.settingsScreen.route,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.settings),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Change settings',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        // change your app settings
                        Navigator.pushNamed(
                          context,
                          ChipsRoute.creditScreen.route,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.info_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Credits',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
            // second half of the page
            GameExplainerWidget(),
          ],
        ),
      ),
    );
  }
}
