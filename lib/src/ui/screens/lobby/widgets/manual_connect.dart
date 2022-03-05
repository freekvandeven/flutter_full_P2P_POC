import 'package:distributed/src/routes.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:distributed/src/ui/widgets/dialogs/join_lobby.dart';
import 'package:flutter/material.dart';

class ManualConnectWidget extends StatefulWidget {
  const ManualConnectWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualConnectWidget> createState() => _ManualConnectWidgetState();
}

class _ManualConnectWidgetState extends State<ManualConnectWidget> {
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Manual connect:',
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
            height: 300,
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
                Text(
                  'Type port and IP to connect',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _ipController,
                      decoration: InputDecoration(
                        hintText: 'Ip',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _portController,
                    decoration: InputDecoration(
                      hintText: 'Port',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                PrimaryButton(
                  onPressed: () async {
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.connect_without_contact),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Connect',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
