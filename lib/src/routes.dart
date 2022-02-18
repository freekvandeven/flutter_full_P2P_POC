import 'package:distributed/src/extension/extension.dart';
import 'package:distributed/src/ui/screens/home.dart';
import 'package:flutter/material.dart';

class ChipsRoute {
  const ChipsRoute(this.route);

  //global
  static const homeScreen = ChipsRoute('home-screen');
  final String route;

  @override
  String toString(){
    return route;
  }

  NavigateAction root([NavigateAction? parent]) =>
      _asCallBack(root: true, parent: parent);
  NavigateAction replacement([
    NavigateAction? parent,
  ]) =>
      _asCallBack(parent: parent);
  NavigateAction push([NavigateAction? parent]) =>
      _asCallBack(nested: true, parent: parent);

  NavigateAction _asCallBack({
    bool root = false,
    bool nested = false,
    NavigateAction? parent,
  }) {
    return (context) {
      parent?.call(context);
      if (root) {
        context.navRoot(this);
      } else if (nested) {
        context.navPush(this);
      } else {
        context.navReplace(this);
      }
    };
  }

  static NavigateAction back() {
    return (context) {
      context.pop();
    };
  }
}

typedef NavigateAction = void Function(BuildContext);

Map<String, WidgetBuilder> getRoutes() {
  return {
    ChipsRoute.homeScreen: (context) => HomeScreen(
        ),
  }.map((key, value) => MapEntry(key.toString(), value));
}
