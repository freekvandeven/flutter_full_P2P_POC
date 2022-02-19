import 'dart:io';

import 'package:distributed/src/app.dart';
import 'package:distributed/src/dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  _enablePlatformOverrideForDesktop();
  runApp(const DependencyProvider(child: ChipsDistributionGameApp()));
}
