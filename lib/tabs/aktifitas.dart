import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../screens/aktifitascontent.dart' as _isi;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with AutomaticKeepAliveClientMixin<Dashboard> {
  bool get wantKeepAlive => true;

  // Base URL for our instagram API
  final String apiUrl =
      "https://api.instagram.com/v1/users/679855155/media/recent/?access_token=679855155.1677ed0.60e9260245a74290a67fce834c060b57";

  // Empty list for our posts
  List posts;

  // Function to fetch list of posts
  Future<String> getPosts() async {
    var res = await http
        .get(Uri.encodeFull(apiUrl), headers: {"Accept": "application/json"});

    // fill our posts list with results and update state
    setState(() {
      var resBody = json.decode(res.body);
      posts = resBody["data"];
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new IG()),
            ),
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: const Text('Load more...'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: new GridView.builder(
        itemCount: posts == null ? 0 : posts.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return _buildTile(
            new GridTile(
              child:
                  new Image.network(posts[index]["images"]["thumbnail"]["url"]),
            ),
            onTap: () {
              //launch(posts[index]["link"]);
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new _isi.aktifitascontent(
                        post: posts[index],
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Widget _buildTile(Widget child, {Function() onTap}) {
  return Material(
    elevation: 10.0,
    shadowColor: Color(0x802196F3),
    child: InkWell(
      onTap: onTap != null
          ? () => onTap()
          : () {
              print('Not set yet');
            },
      child: child,
    ),
  );
}

class IG extends StatelessWidget {
  final urlig = 'https://www.instagram.com/ppitiongkok/';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PageView(
        children: <Widget>[
          new WebviewScaffold(
            url: urlig,
            appBar: new AppBar(
              title: new Text(
                'Instagram PPI Tiongkok',
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
            withZoom: true,
          )
        ],
      ),
    );
  }
}
