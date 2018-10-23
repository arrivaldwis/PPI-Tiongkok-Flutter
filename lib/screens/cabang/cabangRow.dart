import 'package:flutter/material.dart';
import '../../model/cabang.dart';
import '../Theme.dart' as Theme;
import './cabangWebsite.dart';

class cabangRow extends StatelessWidget {
  final Cabang china;

  cabangRow(this.china);

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      alignment: new FractionalOffset(0.1, 0.5),
      margin: const EdgeInsets.only(left: 24.0),
      child: new Hero(
        tag: 'region-icon-${china.id}',
        child: new Image(
          image: new AssetImage(china.image),
          height: 150.0,
          width: 150.0,
        ),
      ),
    );

    final planetCard = new Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: new BoxDecoration(
        color: Theme.Colors.regionCard,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 200.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(china.name, style: Theme.TextStyles.regionTitle),
            new Container(
                color: const Color(0xFFF44336),
                width: 24.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: china.daftarCabang.length,
              itemBuilder: (context, index) => new InkWell(
                    onTap: () =>
                        Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  new CabangWebsite(
                                      key: new ObjectKey(index),
                                      title: china.daftarCabang[index].name,
                                      endpoint:
                                          china.daftarCabang[index].endpoint),
                        )),
                    child: new Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(china.daftarCabang[index].name,
                            style: Theme.TextStyles.regionDistance2)),
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
