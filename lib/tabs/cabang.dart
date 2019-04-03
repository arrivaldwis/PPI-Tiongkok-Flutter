import 'package:flutter/material.dart';
import '../screens/cabang/cabangList.dart';

class cabang extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[new cabangList()],
        ),
      );
}
