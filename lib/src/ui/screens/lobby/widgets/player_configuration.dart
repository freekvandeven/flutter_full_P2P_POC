import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class PlayerConfigurationWidget extends StatefulWidget {
  const PlayerConfigurationWidget({
    required this.playerName,
    required this.playerRole,
    required this.playerAgentCode,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  final Function(String, String, String) onSave;
  final String playerName;
  final String playerRole;
  final String playerAgentCode;

  @override
  State<PlayerConfigurationWidget> createState() =>
      _PlayerConfigurationWidgetState();
}

class _PlayerConfigurationWidgetState extends State<PlayerConfigurationWidget> {
  final TextEditingController _playerNameController = TextEditingController();
  final TextEditingController _playerRoleController = TextEditingController();
  final TextEditingController _playerAgentController = TextEditingController();
  bool textUpdated = false;

  @override
  void initState() {
    _playerNameController.text = widget.playerName;
    _playerRoleController.text = widget.playerRole;
    _playerAgentController.text = widget.playerAgentCode;
    super.initState();
  }

  bool checkTextUpdated() {
    if (_playerNameController.text != widget.playerName ||
        _playerRoleController.text != widget.playerRole ||
        _playerAgentController.text != widget.playerAgentCode) {
      return textUpdated = true;
    } else {
      return textUpdated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkTextUpdated();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Player configuration:',
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 200.0,
            vertical: 15.0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
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
                TextField(
                  controller: _playerNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Player name',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                  onChanged: (text) {
                    setState(() {
                      textUpdated = checkTextUpdated();
                    });
                  },
                ),
                TextField(
                  controller: _playerRoleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Player role',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                  onChanged: (text) {
                    setState(() {
                      textUpdated = checkTextUpdated();
                    });
                  },
                ),
                TextField(
                  controller: _playerAgentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Player agent code',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                  onChanged: (text) {
                    setState(() {
                      textUpdated = checkTextUpdated();
                    });
                  },
                ),
                if (textUpdated) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: PrimaryButton(
                      onPressed: () {
                        widget.onSave(
                          _playerNameController.text,
                          _playerRoleController.text,
                          _playerAgentController.text,
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
                ],
              ],
            ),
          ),
        )
      ],
    );
  }
}
