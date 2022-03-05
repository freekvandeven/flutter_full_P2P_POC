import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GameExplainerWidget extends StatefulWidget {
  const GameExplainerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GameExplainerWidget> createState() => _GameExplainerWidgetState();
}

class _GameExplainerWidgetState extends State<GameExplainerWidget> {
  bool infoWidget = false;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFFf7f7f7),
                borderRadius: BorderRadius.circular(1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          infoWidget = !infoWidget;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            'What is the beer game ? ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Icon(
                            infoWidget
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                          ),
                        ],
                      ),
                    ),
                    if (infoWidget) ...[
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'In this game you play as an actor of the'
                        ' distribution network of a beer company.\n'
                        'It lets you experience the classical '
                        'coordination problems met by industrials.\n'
                        'Weather played in a scholar or managerial context, it'
                        ' is a good introduction towards supply-chain reform &'
                        ' innovation.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ],
                ),
              ),
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
    );
  }
}
