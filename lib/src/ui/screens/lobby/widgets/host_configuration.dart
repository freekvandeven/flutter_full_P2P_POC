import 'package:distributed/src/models/game_information.dart';
import 'package:distributed/src/models/network_information.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class HostConfigurationWidget extends StatefulWidget {
  const HostConfigurationWidget({
    required this.ipInformation,
    required this.isHost,
    required this.lobbyStarted,
    required this.gameInformation,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  final bool isHost;
  final bool lobbyStarted;
  final NetworkInformation ipInformation;
  final GameInformation gameInformation;
  final Function(GameInformation) onSave;

  @override
  State<HostConfigurationWidget> createState() =>
      _HostConfigurationWidgetState();
}

class _HostConfigurationWidgetState extends State<HostConfigurationWidget> {
  final TextEditingController _lobbyNameController = TextEditingController();
  final TextEditingController _playerLimitController = TextEditingController();
  final TextEditingController _turnLimitController = TextEditingController();
  final TextEditingController _turnDurationController = TextEditingController();
  bool textUpdated = false;

  @override
  void initState() {
    _lobbyNameController.text = widget.gameInformation.gameName;
    _playerLimitController.text = widget.gameInformation.playerLimit.toString();
    _turnLimitController.text = widget.gameInformation.totalTurns.toString();
    _turnDurationController.text =
        widget.gameInformation.secondPerTurn.toString();
    super.initState();
  }

  bool checkTextUpdated() {
    if (_lobbyNameController.text != widget.gameInformation.gameName ||
        int.parse(_playerLimitController.text) !=
            widget.gameInformation.playerLimit ||
        int.parse(_turnLimitController.text) !=
            widget.gameInformation.totalTurns ||
        int.parse(_turnDurationController.text) !=
            widget.gameInformation.secondPerTurn) {
      return textUpdated = true;
    } else {
      return textUpdated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkTextUpdated();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Host configuration:',
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 200.0,
            vertical: 15.0,
          ),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Lobby information:',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                TextField(
                                  controller: _lobbyNameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Lobby Name',
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      textUpdated = checkTextUpdated();
                                    });
                                  },
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _playerLimitController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Player limit',
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      textUpdated = checkTextUpdated();
                                    });
                                  },
                                ),
                                TextField(
                                  controller: _turnLimitController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Number of Turns',
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      textUpdated = checkTextUpdated();
                                    });
                                  },
                                ),
                                TextField(
                                  controller: _turnDurationController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Turn duration(in seconds)',
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      textUpdated = checkTextUpdated();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Server information:',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  'Server IPv4:'
                                  '${widget.ipInformation.wifiIPv4}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  'Server IPv6:'
                                  '${widget.ipInformation.wifiIPv6}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  'Server Port:42069',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    if (textUpdated) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: PrimaryButton(
                          onPressed: () {
                            widget.onSave(
                              GameInformation(
                                gameName: _lobbyNameController.text,
                                playerLimit:
                                    int.parse(_playerLimitController.text),
                                totalTurns:
                                    int.parse(_turnLimitController.text),
                                secondPerTurn:
                                    int.parse(_turnDurationController.text),
                              ),
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
                                'Save',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              if (!widget.isHost || widget.lobbyStarted) ...[
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    // transparent darkcolor
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      widget.isHost
                          ? 'You started the lobby already'
                          : 'You are no host!',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
