import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class aktifitascontent extends StatelessWidget {

  var post;
  aktifitascontent({Key key, @required var this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PageView(
        children: <Widget>[
          new WebviewScaffold(
            url: post["link"],
            appBar: new AppBar(
              title: new Text(
                'Aktifitas',
                style: new TextStyle(
                  fontSize: Theme.of(context).platform == TargetPlatform.iOS
                      ? 17.0
                      : 20.0,
                ),
              ),
              elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
            ),
            withLocalStorage: true,
          )
        ],
      ),
    );
  }
}