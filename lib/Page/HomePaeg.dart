import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_city/Page/ClassPage.dart';
import 'package:flutter_city/Page/IndexPage.dart';
import 'package:flutter_city/Page/NewsContentPage.dart';
import 'package:flutter_city/service/http_service.dart';
import 'package:flutter_city/service/htttp_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:html/parser.dart';

class HomePage extends StatefulWidget {

  HomePage(IndexStatePage bb){
    aa = bb;
  }

  @override
  State<StatefulWidget> createState() => _HomePageSate();
}

class _HomePageSate extends State<HomePage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Future.wait([
        get(getHomeBanner),
        get(getHomeType),
        get(getHomeHot, query: {"hot": "Y"}),
        get(getHomeNewsType),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());

            List<Map> getHomeBanner = (data[0]['rows'] as List).cast();

            List<Map> getHomeType = (data[1]['rows'] as List).cast();

            List<Map> getHomeHot = (data[2]['rows'] as List).cast();

            List<Map> getHomeNewsType = (data[3]['data'] as List).cast();

            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [];
              },
              body: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    BannerDiy(BannerDataList: getHomeBanner),
                    SizedBox(
                      height: 20,
                    ),
                    TopNavigation(navigationlist: getHomeType),
                    SizedBox(
                      height: 20,
                    ),
                    HotNews(hotnewsList: getHomeHot),
                    SizedBox(
                      height: 20,
                    ),
                    NewsTpye(topList: getHomeNewsType),
                  ],
                ),
              ),
            );
          }
        }
        return Center(
          child: Text("!11"),
        );
      },
    ));
  }
}

//首页轮播图
class BannerDiy extends StatelessWidget {
  final List BannerDataList;

  BannerDiy({Key? key, required this.BannerDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 180,
      child: Swiper(
        itemCount: BannerDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "$base_url${BannerDataList[index]['advImg']}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

late final IndexStatePage aa;

//首页分类
class TopNavigation extends StatelessWidget {
  final List navigationlist;

  TopNavigation({Key? key, required this.navigationlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tempIndex = -1;
    return Container(
      color: Colors.white,
      height: 150,
      padding: EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 5,
        physics: NeverScrollableScrollPhysics(),
        children: navigationlist.map((item) {
          tempIndex++;
          return _gridViewItemUI(context, item, tempIndex);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, item, index) {
    if (index == 9) {
      return InkWell(
        onTap: () {
          aa.onTabClass(1);
        },
        child: Column(
          children: [
            Image.network(
              "$base_url${navigationlist[index]['imgUrl']}",
              width: 50,
            ),
            Text(
              "全部服务",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {},
        child: Column(
          children: [
            Image.network(
              "$base_url${navigationlist[index]['imgUrl']}",
              width: 50,
            ),
            Text(
              item['serviceName'],
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      );
    }
  }
}

//热点新闻
class HotNews extends StatelessWidget {
  final List hotnewsList;

  HotNews({Key? key, required this.hotnewsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tempIndex = -1;
    return Container(
      color: Colors.white,
      height: 235,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1 / 0.65,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: hotnewsList.map((item) {
          tempIndex++;
          return _gridViewItemUI(context, item, tempIndex);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, item, index) {
    return InkWell(
      onTap: () {},
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "$base_url${hotnewsList[index]['cover']}",
              width: 170,
              height: 90,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            item['title'],
            style: TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

//新闻列表
class NewsTpye extends StatefulWidget {


  final List topList;

  NewsTpye({Key? key, required this.topList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsTypeSate(topList);
}

class _NewsTypeSate extends State<NewsTpye>
    with SingleTickerProviderStateMixin {
  final List topList;

  _NewsTypeSate(this.topList);

  String removeHtmlTags(String html) {
    final document = parse(html);
    return parse(document.body!.text).documentElement!.text;
  }



  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: topList.length, vsync: this);
    var _tabs = topList
        .map((item) => Tab(
              text: item["name"],
            ))
        .toList();
    var _newsList = topList.map((item) {
      return FutureBuilder(
        future: Future.wait([
          get(getHomeNews, query: {"type": "${item['id']}"})
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> getHomeNews = (data[0]["rows"] as List).cast();
              print("${getHomeNews.toString()}");

              return ListView.builder(
                itemCount: getHomeNews.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _item(index, context, getHomeNews);
                },
              );
            }
          }
          return Center(
            child: Text("1111"),
          );
        },
      );
    }).toList();

    return SizedBox(
      width: 350,
      height: 1600,
      child: DefaultTabController(
        length: topList.length,
        child: Column(
          children: [
            Material(
              color: Colors.yellow,
              child: Container(
                height: 55,
                color: Colors.white,
                child: TabBar(
                  tabs: _tabs,
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: _newsList,
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(index, context, getHomeNews) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsContentPage(Itemid:int.parse("${getHomeNews[index]["id"]}"))));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
                "${base_url}${getHomeNews[index]['cover']}",
                height: 80,
                width: 120,
                fit: BoxFit.fill,
              ),
            SizedBox(width: 10,),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${getHomeNews[index]['title']}", maxLines: 1, overflow: TextOverflow.ellipsis,),
                Text(removeHtmlTags("${getHomeNews[index]["content"]}"),maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey),),
               Row(
                 children: [
                   Text("发布时间:"),
                   Text("${getHomeNews[index]['publishDate']}")
                 ],
               ),
                Row(
                  children: [
                    Text("点赞数:"),
                    Text("${getHomeNews[index]['likeNum']}")
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
