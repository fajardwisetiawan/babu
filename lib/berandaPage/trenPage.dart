import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:babu_apk/page/detailBeritaPage.dart';
import 'package:shimmer/shimmer.dart';

class TrenPage extends StatefulWidget {
  @override
  _TrenPageState createState() => _TrenPageState();
}

class _TrenPageState extends State<TrenPage> {
  String nextPage = "http://192.168.0.144:3000/app/kategori/" + "TREN";

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
      nextPage = "http://192.168.0.144:3000/app/kategori/TREN/?page=${page}";
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
              //     builder: (BuildContext context) => new DetailBeritaPage(
              //       list: list,
              //       index: index,
              //     ),
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
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red[600],
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                      list[index]['chanel'],
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 13.0,
                                          color: Colors.white),
                                    ),
                                  ),
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
