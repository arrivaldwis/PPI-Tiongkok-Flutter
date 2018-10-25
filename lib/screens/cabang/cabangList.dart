import 'package:flutter/material.dart';
import '../cabang/cabangRow.dart';
import '../Theme.dart' as Theme;
import '../../model/cabangDetail.dart';

class cabangList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Container(
        color: Theme.Colors.regionPageBackground,
        child: new ListView.builder(
          itemExtent: 200.0,
          itemCount: cabangDetail.regions.length,
          itemBuilder: (_, index) => new cabangRow(cabangDetail.regions[index]),
        ),
      ),
    );
  }
}