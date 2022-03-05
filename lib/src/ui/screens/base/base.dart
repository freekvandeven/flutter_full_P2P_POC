import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChipsBaseScreen extends StatefulWidget {
  const ChipsBaseScreen({required this.child, this.escapeTrigger, Key? key})
      : super(key: key);

  final Widget child;
  final void Function()? escapeTrigger;

  @override
  State<ChipsBaseScreen> createState() => _ChipsBaseScreenState();
}

class _ChipsBaseScreenState extends State<ChipsBaseScreen> {
  bool _isTriggered = true;
  Timer? timer;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        _isTriggered = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKey: (event) {
        if (_focusNode.hasFocus && event is RawKeyDownEvent) {
          debugPrint('_isTriggered: $_isTriggered');
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            debugPrint('escape pressed');
            if (!_isTriggered) {
              widget.escapeTrigger?.call();
              setState(() {
                _isTriggered = true;
                // trigger only once per second
                timer = Timer(const Duration(seconds: 1), () {
                  setState(() {
                    _isTriggered = false;
                  });
                });
              });
            } else {
              debugPrint(
                'escape pressed but already triggered '
                'or page still loading',
              );
            }
          }
        }
      },
      child: Scaffold(
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
          child: widget.child,
        ),
      ),
    );
  }
}
