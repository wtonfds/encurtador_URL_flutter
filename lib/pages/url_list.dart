import 'package:desafio_logique/pages/url_page.dart';
import 'package:flutter/material.dart';

class URLList extends StatefulWidget {
  @override
  _URLListState createState() => _URLListState();
}

class _URLListState extends State<URLList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        title: Text('Urls', style: TextStyle(color: Colors.black),),

      ),

      body: new UrlPage(),
    );
  }
}
