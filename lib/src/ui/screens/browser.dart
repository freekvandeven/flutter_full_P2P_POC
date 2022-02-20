import 'package:distributed/src/service/socket.dart';
import 'package:distributed/src/ui/screens/base.dart';
import 'package:flutter/material.dart';

class GameBrowserScreen extends StatefulWidget {
  const GameBrowserScreen({required this.socketService, Key? key})
      : super(key: key);

  final SocketService socketService;

  @override
  State<GameBrowserScreen> createState() => _GameBrowserScreenState();
}

class _GameBrowserScreenState extends State<GameBrowserScreen> {
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'All active Games:',
                  style: Theme.of(context).textTheme.headline1,
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: 10,
                //     itemBuilder: (context, index) => ListTile(
                //       title: Text('Game $index'),
                //       onTap: () {
                //         Navigator.
                //pushNamed(context, ChipsRoute.gameScreen.route);
                //       },
                //     ),
                //   ),
                // ),
                SizedBox(height: 10),
                Text(
                  'Type port and IP to connect:',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _ipController,
                    decoration: InputDecoration(
                      hintText: 'Ip',
                      border: OutlineInputBorder(),
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
                GestureDetector(
                  onTap: () {
                    if (_portController.text.isNotEmpty &&
                        _ipController.text.isNotEmpty &&
                        int.tryParse(_portController.text) != null) {
                      widget.socketService.connectSocket(
                        _ipController.text,
                        int.parse(_portController.text),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.connect_without_contact),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Connect'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Go Back'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
