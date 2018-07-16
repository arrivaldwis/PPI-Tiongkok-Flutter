import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class beritapost extends StatelessWidget {

  var post;
  beritapost({Key key, @required var this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(post['title']['rendered']),
      ),
      body: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new ListView(
          children: <Widget>[
            new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: post["featured_media"] == 0
                  ? 'http://old.ppidunia.org/wp-content/uploads/2016/10/LAMBANG-JPEG.jpg'
                  : post["_embedded"]["wp:featuredmedia"][0]["source_url"],
            ),
            new Text(post['content']['rendered'].replaceAll(new RegExp(r'<[^>]*>'), ''))
          ],
        ),
      ),
    );
  }
}