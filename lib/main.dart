import 'package:distributed/src/app.dart';
import 'package:distributed/src/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  Wakelock.enable();
  runApp(const DependencyProvider(child: ChipsDistributionGameApp()));
}
