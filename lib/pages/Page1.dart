import 'package:flutter/material.dart';
import 'package:flutterproject/providers/searchprovide.dart';
import 'package:provider/provider.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvide>(builder: (context, model, child) {
      return Center(
        child: Text(
          "${model.placeno}",
          style: TextStyle(fontSize: 12.0),
        ),
      );
    });
  }
}
