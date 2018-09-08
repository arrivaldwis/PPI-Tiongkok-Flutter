import 'package:flutter/material.dart';
import '../Theme.dart' as Theme;
import '../../model/cabang.dart';

class cabangDetailBody extends StatelessWidget {
  final Cabang planet;

  cabangDetailBody(this.planet);


  @override
  Widget build(BuildContext context) {
    return new Stack(
        children: <Widget>[
          new Container(
            color: Theme.Colors.planetPageBackground,
            child: new Center(
              child: new Hero(
                tag: 'planet-icon-${planet.id}',
                child: new Image(
                  image: new AssetImage(planet.image),
                  height: Theme.Dimens.planetHeight,
                  width: Theme.Dimens.planetWidth,
                ),
              ),
            ),
          ),
        ]
    );
  }
}