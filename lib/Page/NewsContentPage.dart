import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_city/service/http_service.dart';
import 'package:flutter_city/service/htttp_config.dart';
import 'package:html/parser.dart';

class NewsContentPage extends StatelessWidget{

  final int Itemid;

  NewsContentPage({required this.Itemid});

  @override
  Widget build(BuildContext context) {

    String removeHtmlTags(String html) {
      final document = parse(html);
      return parse(document.body!.text).documentElement!.text;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("新闻首页"),
      ),
      body: FutureBuilder(
        future: Future.wait([
          get("$getNewContent$Itemid")
        ]),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              var data = json.decode(snapshot.data.toString());

              return ListView(
                padding: EdgeInsets.all(10),
                children: [
                  Center(
                    child: Text(data[0]["data"]["title"],style: TextStyle(fontSize: 18),),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Image.network("$base_url${data[0]["data"]["cover"]}",width: 300,height: 200,),
                  ),
                  SizedBox(height: 20,),
                  Text(removeHtmlTags(data[0]["data"]["content"])),
                ],
              );
            }
          }
          return Text("!11");
        },
      )
    );
  }

}