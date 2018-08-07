import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36";

//URL ADDRESS FOR WEBVIEW
String selectedUrl = "http://www.ppitiongkok.org/struktur-organisasi-2017-2018/";

void main() {
  runApp(new MaterialApp());
}



class StrukturKepengurusan extends StatefulWidget {
  StrukturKepengurusan({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StrukturKepengurusanState createState() => new _StrukturKepengurusanState();
}

class _StrukturKepengurusanState extends State<StrukturKepengurusan> {
  // Instance of WebView plugin
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  TextEditingController _urlCtrl = new TextEditingController(text: selectedUrl);

  TextEditingController _codeCtrl =
  new TextEditingController(text: "window.navigator.userAgent");

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final _history = [];

  @override
  initState() {
    super.initState();

    flutterWebviewPlugin.close();

    _urlCtrl.addListener(() {
      selectedUrl = _urlCtrl.text;
    });


    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add("onUrlChanged: $url");
        });
      }
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          if (mounted) {
            setState(() {
              _history.add("onStateChanged: ${state.type} ${state.url}");
            });
          }
        });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onUrlChanged.cancel();
    _onStateChanged.cancel();

    flutterWebviewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      //Content of tabs
      body: new PageView(
        children: <Widget>[
          new WebviewScaffold(
            url: selectedUrl,
            appBar: new AppBar(
              title: new Text(
                'Struktur Kepengurusan',
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