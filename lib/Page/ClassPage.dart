import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ClassPageSate();

}

class _ClassPageSate extends State<ClassPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("分类"),
      ),
    );
  }
}