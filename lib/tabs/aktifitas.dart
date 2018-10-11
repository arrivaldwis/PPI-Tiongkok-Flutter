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
  final String apiUrl = "https://api.instagram.com/v1/users/679855155/media/recent/?access_token=679855155.135f81d.1b4a1b50181143c983b9642d1ad26bd1";

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
