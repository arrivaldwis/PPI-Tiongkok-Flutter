import 'package:flutter/material.dart';
import '../../model/cabang.dart';
import '../../model/cabangDetail.dart';
import '../cabang/DetailAppBar.dart';
import '../cabang/cabangDetailBody.dart';

class cabangDetailPage extends StatelessWidget {

  final Cabang planet;

  cabangDetailPage(String id) :
        planet = cabangDetail.getPlanetById(id);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new cabangDetailBody(planet),
          new DetailAppBar(),
        ],
      ),
    );
  }
}
