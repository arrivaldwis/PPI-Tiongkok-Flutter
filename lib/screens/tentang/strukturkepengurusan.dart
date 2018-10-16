/**
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class StrukturKepengurusan extends StatefulWidget {
  @override
  _StrukturKepengurusanState createState() => _StrukturKepengurusanState();
}

class _StrukturKepengurusanState extends State<StrukturKepengurusan> {

  final String apiUrl = "http://www.ppitiongkok.org/wp-json/wp/v2/";
  List posts;

  Future<String> getPosts() async{
    var res = await http.get(Uri.encodeFull(apiUrl + "pages?_embed&slug=periode-2018-2020"),
        headers: {"Accept": "application/json"});

    setState((){
      var resBody = json.decode(res.body);
      posts = resBody;
    });

    return "Success!";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Struktur kepengurusan 2018-2020'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new ListView(
          children: <Widget>[
            new HtmlView(data: posts[0]['content']['rendered']),
          ],
        ),
      ),
    );
  }
}
**/