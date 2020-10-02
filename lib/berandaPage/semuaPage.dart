import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:babu_apk/page/detailBeritaPage.dart';
import 'package:babu_apk/page/listSumberPage.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rupiah/rupiah.dart';

class SemuaPage extends StatefulWidget {
  @override
  _SemuaPageState createState() => _SemuaPageState();
}

class _SemuaPageState extends State<SemuaPage> {
  Future<List<Map<String, dynamic>>> getDataHorisontal() async {
    final response =
        await http.get("http://192.168.0.144:3000/countperchanel");
    return List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
  }

  String nextPage = "http://192.168.0.144:3000/";

  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;

  List list = new List();

  final dio = new Dio();
  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await dio.get(nextPage);
      List tempList = new List();
      // print(response.data['nextPage']);
      var page = response.data['nextPage'];
      // ignore: unnecessary_brace_in_string_interps
      nextPage = "http://192.168.0.144:3000/?page=${page}";
      for (int i = 0; i < response.data['data'].length; i++) {
        tempList.add(response.data['data'][i]);
      }

      setState(() {
        isLoading = false;
        list.addAll(tempList);
      });
    }
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    this._getMoreData();
    refreshList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _getMoreData();
    });

    return null;
  }

  // Widget _buildProgressIndicator() {
  //   return new Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: new Center(
  //       child: new Opacity(
  //         opacity: isLoading ? 1.0 : 00,
  //         child: new CircularProgressIndicator(),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == list.length) {
          return _shimmerVertical();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              // onTap: () => Navigator.of(context).push(
              //   new MaterialPageRoute(
              // builder: (BuildContext context) => new DetailBeritaPage(
              //   list: list,
              //   index: index,
              // ),
              //   ),
              // ),
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(seconds: 2),
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secAnimation,
                            Widget child) {
                          animation = CurvedAnimation(
                              parent: animation, curve: Curves.elasticInOut);
                          return ScaleTransition(
                              alignment: Alignment.center,
                              scale: animation,
                              child: child);
                        },
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> setAnimation) {
                          return DetailBeritaPage(
                            list: list,
                            index: index,
                          );
                        }));
              },
              child: Container(
                color: Colors.transparent,
                height: 145.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 120.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image: list[index]['img'] == null
                                  ? AssetImage("assets/images/0images.png")
                                  : NetworkImage(list[index]['img']),
                              // image: NetworkImage(list[i]['img']),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  list[index]['judul'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                // list[index]['kategori'] == ""
                                //     ? null
                                //     : Container(
                                //         decoration: BoxDecoration(
                                //           color: Colors.blue,
                                //           borderRadius:
                                //               BorderRadius.circular(15.0),
                                //         ),
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(4.0),
                                //           child: AutoSizeText(
                                //             list[index]['kategori'],
                                //             style: TextStyle(
                                //                 fontFamily: 'OpenSans',
                                //                 fontSize: 13.0,
                                //                 color: Colors.white),
                                //           ),
                                //         ),
                                //       ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                      list[index]['kategori'],
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 13.0,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                AutoSizeText(
                                  list[index]['chanel'],
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 13.0,
                                      color: Colors.red[600]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            AutoSizeText(
                              list[index]['readmore'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 13.0,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<List>(
                future: getDataHorisontal(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? ItemHorizontal(listhorizontal: snapshot.data)
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13.0, vertical: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 150.0,
                            child: Shimmer.fromColors(
                              baseColor: Color(0XFFededed),
                              highlightColor: Colors.white,
                              child: Container(
                                height: 150.0,
                                width: double.infinity,
                                color: Color(0xFFededed),
                              ),
                            ),
                          ),
                        );
                },
              ),
              _buildList(),
            ],
          ),
          controller: _scrollController,
        ),
        onRefresh: refreshList,
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class ItemHorizontal extends StatelessWidget {
  final List<Color> circleColors = [
    Colors.purple,
    Colors.orange,
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  Color randomGenerator() {
    return circleColors[new Random().nextInt(5)];
  }

  final List listhorizontal;
  ItemHorizontal({this.listhorizontal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      height: 150.0,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listhorizontal == null ? 0 : listhorizontal.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new ListSumberPage(
                    list: listhorizontal,
                    index: i,
                  ),
                ),
              ),
              child: Container(
                width: 230.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    colors: [randomGenerator(), Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/bulat.png"),
                    alignment: Alignment(1.5, 3.5),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            listhorizontal[i]['_id'],
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                color: Colors.white),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Total berita : ",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 15.0,
                                    color: Colors.white),
                              ),
                              Text(
                                // NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format("${listhorizontal[i]['count']}"),
                                rupiah("${listhorizontal[i]['count']}")
                                    .replaceAll('Rp', ''),
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 15.0,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _shimmerVertical() {
  return Container(
    color: Colors.transparent,
    height: 145.0,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 130.0,
              width: 70.0,
              child: Shimmer.fromColors(
                  baseColor: Color(0XFFededed),
                  highlightColor: Colors.white,
                  child: Container(
                    height: 130.0,
                    width: 70.0,
                    color: Color(0xFFededed),
                  )),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 20.0,
                          child: Shimmer.fromColors(
                            baseColor: Color(0XFFededed),
                            highlightColor: Colors.white,
                            child: Container(
                              height: 20.0,
                              width: double.infinity,
                              color: Color(0xFFededed),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    SizedBox(
                      width: 60.0,
                      height: 25.0,
                      child: Shimmer.fromColors(
                        baseColor: Color(0XFFededed),
                        highlightColor: Colors.white,
                        child: Container(
                          height: 25.0,
                          width: 60.0,
                          color: Color(0xFFededed),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    SizedBox(
                      width: 60.0,
                      height: 25.0,
                      child: Shimmer.fromColors(
                        baseColor: Color(0XFFededed),
                        highlightColor: Colors.white,
                        child: Container(
                          height: 25.0,
                          width: 60.0,
                          color: Color(0xFFededed),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 20.0,
                  child: Shimmer.fromColors(
                    baseColor: Color(0XFFededed),
                    highlightColor: Colors.white,
                    child: Container(
                      height: 20.0,
                      width: double.infinity,
                      color: Color(0xFFededed),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
