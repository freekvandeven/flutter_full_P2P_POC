import 'package:distributed/src/routes.dart';
import 'package:distributed/src/service/game.dart';
import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:distributed/src/ui/widgets/dialogs/quit_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                    'Learn supply-chain principles through a visual simulation',
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
                      // look for existing lobbies on the network and join them
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
            // second half of the page
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 200.0,
                  vertical: 50.0,
                ),
                child: Column(
                  children: [
                    Text(
                      'What is the beer game ? ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User interface',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                Text(
                                  'No need for a long story or '
                                  'deep mechanics,we chose to keep '
                                  'the game plain & simple.\nThe '
                                  'design is inspired by the original '
                                  'board game, where information & '
                                  'material flows are\nclearly '
                                  'represented.\nEach player has '
                                  'its own view, a messaging service '
                                  'is integrated if you allow it.',
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              'assets/images/board-inclined.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SvgPicture.asset(
                              'assets/images/main-graphs.svg',
                            ),
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Analytics & Debriefing material',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                Text(
                                  'Follow your current & past performance data '
                                  'during the game.\nAt the end, get visual '
                                  'insights on the supply-chain behavior.\n '
                                  'Compare the results of each player, compare '
                                  'with another game.\nFind material to '
                                  'stimulate a discussion about supply-chain '
                                  'reform & optimization.',
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}