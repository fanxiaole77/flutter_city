import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NewsPageSate();

}

class _NewsPageSate extends State<NewsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("新闻"),
      ),
    );
  }
}