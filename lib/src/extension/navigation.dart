import 'package:distributed/src/routes.dart';
import 'package:flutter/material.dart';

extension QuickNavigation on BuildContext {
  static QuickNavigationHandler handler = QuickNavigationHandler();

  Future<T?> navReplace<T, TO>(ChipsRoute route) {
    return handler.navReplace<T, TO>(this, route);
  }

  Future<T?> navPush<T>(ChipsRoute route) {
    return handler.navPush<T>(this, route);
  }

  Future<T?> navRoot<T>(ChipsRoute route) {
    return handler.navRoot(this, route);
  }

  void pop<T>([T? value]) {
    return handler.pop(this, value);
  }
}

class QuickNavigationHandler {
  Future<T?> navReplace<T, TO>(BuildContext context, ChipsRoute route) {
    return Navigator.pushReplacementNamed<T, TO>(context, route.route);
  }

  Future<T?> navPush<T>(BuildContext context, ChipsRoute route) {
    return Navigator.pushNamed<T>(
      context,
      route.route,
    );
  }

  Future<T?> navRoot<T>(BuildContext context, ChipsRoute route) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      route.route,
      (route) => false,
    );
  }

  void pop<T>(BuildContext context, T? value) {
    Navigator.pop(context, value);
  }
}
