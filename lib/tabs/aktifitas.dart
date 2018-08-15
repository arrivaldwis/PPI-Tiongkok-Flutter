import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/aktifitascontent.dart' as _isi;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  // Base URL for our instagram API
  final String apiUrl = "https://api.instagram.com/v1/users/1640416290/media/recent/?access_token=1640416290.166834c.18fc2f07ea704cee9881d1215f14d361";

  // Empty list for our posts
  List posts;

  // Function to fetch list of posts
  Future<String> getPosts() async {
    var res = await http.get(Uri.encodeFull(apiUrl),
        headers: {"Accept": "application/json"});

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
      body: new GridView.builder(
        itemCount: posts == null ? 0 : posts.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index){
          return _buildTile(
            new GridTile(
              child: new Image.network(posts[index]["images"]["thumbnail"]["url"]),
            ),
            onTap: (){
              //launch(posts[index]["link"]);
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) =>
                  new  _isi.aktifitascontent(
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

Widget _buildTile(Widget child, {Function() onTap}){
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
