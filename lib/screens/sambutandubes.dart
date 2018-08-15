import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class sambutandubes extends StatefulWidget {
  @override
  _sambutandubesState createState() => _sambutandubesState();
}

class _sambutandubesState extends State<sambutandubes> {

  final String apiUrl = "http://www.ppitiongkok.org/wp-json/wp/v2/";

  // Empty list for our posts
  List posts;

  // Function to fetch list of posts
  Future<String> getPosts() async {
    var res = await http.get(Uri.encodeFull(apiUrl + "pages?_embed&slug=sambutan-dubes"),
        headers: {"Accept": "application/json"});

    // fill our posts list with results and update state
    setState(() {
      var resBody = json.decode(res.body);
      posts = resBody;
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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          posts[0]['title']['rendered'],
          style: new TextStyle(
            fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new ListView(
          children: <Widget>[
            new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: posts[0]["featured_media"] == 0
                  ? ''
                  : posts[0]["content"]["rendered"],
            ),
            new Text(posts[0]['content']['rendered'].replaceAll(new RegExp(r'<[^>]*>'), ''))
          ],
        ),
      ),
    );
  }
}
