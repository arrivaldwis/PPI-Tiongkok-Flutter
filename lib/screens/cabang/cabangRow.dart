import 'package:flutter/material.dart';
import '../../model/cabang.dart';
import '../Theme.dart' as Theme;
import './cabangWebsite.dart';

class cabangRow extends StatelessWidget {
  final Cabang planet;

  cabangRow(this.planet);

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 24.0),
      child: new Hero(
        tag: 'planet-icon-${planet.id}',
        child: new Image(
          image: new AssetImage(planet.image),
          height: Theme.Dimens.planetHeight,
          width: Theme.Dimens.planetWidth,
        ),
      ),
    );

    final planetCard = new Container(
      margin: const EdgeInsets.only(left: 72.0, right: 24.0),
      decoration: new BoxDecoration(
        color: Theme.Colors.planetCard,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(planet.name, style: Theme.TextStyles.planetTitle),
            new Container(
                color: const Color(0xFFF44336),
                width: 24.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: planet.daftarCabang.length,
              itemBuilder: (context, index) => new InkWell(
                    onTap: () =>
                        Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => new CabangWebsite(
                              planet.daftarCabang[index].name,
                              planet.daftarCabang[index].endpoint),
                        )),
                    child: new Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(planet.daftarCabang[index].name,
                            style: Theme.TextStyles.planetDistance2)),
                  ),
            ),
          ],
        ),
      ),
    );

    return new Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new Stack(
        children: <Widget>[
          planetCard,
          planetThumbnail,
        ],
      ),
    );
  }
}
