import 'package:flutter/material.dart';

class ChipsBaseScreen extends StatelessWidget {
  const ChipsBaseScreen({required this.child, Key? key}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beer Game Simulation',
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}
