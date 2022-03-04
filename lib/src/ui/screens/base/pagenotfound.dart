import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      child: Container(
        child: Text('Page not found'),
      ),
    );
  }
}
