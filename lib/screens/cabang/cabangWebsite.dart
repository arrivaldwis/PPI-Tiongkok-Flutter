import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CabangWebsite extends StatefulWidget {
  CabangWebsite({Key key, this.title, this.endpoint}) : super(key: key);
  // CabangWebsite(this.title, this.endpoint);

  final String title;
  final String endpoint;

  @override
  _CabangWebsiteState createState() => _CabangWebsiteState();
}

class _CabangWebsiteState extends State<CabangWebsite> {
  // Instance of WebView plugin
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  // State listener
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  bool showLoadingIndicator = false;

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (state.type == WebViewState.startLoad) {
        setState(() {
          showLoadingIndicator = true;
        });
      } else if (state.type == WebViewState.finishLoad){
        setState(() {
          showLoadingIndicator = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PageView(
        children: <Widget>[
          new WebviewScaffold(
            url: widget.endpoint,
            appBar: new AppBar(
              title: new Row(children: <Widget>[
                new Text(
                  widget.title,
                  style: new TextStyle(
                    fontSize:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? 17.0
                            : 20.0,
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(right: 6.0),
                )
                ,
                showLoadingIndicator
                    ? new SpinKitFadingCircle(
                        color: Colors.white,
                        size: 25.0,
                      )
                    : new Container()
              ]),
              elevation:
                  Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
            ),
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          )
        ],
      ),
    );
  }
}
