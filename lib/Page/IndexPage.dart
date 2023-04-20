import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_city/Page/ClassPage.dart';
import 'package:flutter_city/Page/HomePaeg.dart';
import 'package:flutter_city/Page/MePage.dart';
import 'package:flutter_city/Page/NewsPage.dart';

class IndexPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => IndexStatePage();

}

class IndexStatePage extends State<IndexPage>{

  late final List<Widget> _childern;

  IndexStatePage(){
    _childern = [
       HomePage(this),
       ClassPage(),
       NewsPage(),
       MePage(),
   ];
  }

   int _currentIndex= 0;


  void onTabClass(int index){
    setState(() {
      _currentIndex = 1;
    });
  }

  void onTabRapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _childern[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabRapped,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        fixedColor: Colors.blue,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: "分类"),
          BottomNavigationBarItem(icon: Icon(Icons.fiber_new_rounded),label: "新闻"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "个人中心"),
        ],
      ),
    );
  }
}