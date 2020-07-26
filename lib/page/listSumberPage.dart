import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:babu_apk/page/detailBeritaPage.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ListSumberPage extends StatefulWidget {
  List list;
  int index;
  ListSumberPage({this.index, this.list});
  @override
  _ListSumberPageState createState() => _ListSumberPageState();
}

class _ListSumberPageState extends State<ListSumberPage> {
  Future<List<Map<String, dynamic>>> getData() async {
    final response = await http
        .get("http://103.112.162.79:3000/${widget.list[widget.index]['_id']}");
    // String asd = widget.list[widget.index]['_id']
    return List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0.0,
        leading: new IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "BABU",
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FutureBuilder<List>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ItemList(list: snapshot.data)
                    : Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            height: 145.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13.0, vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    // child: Container(
                                    //   height: 120.0,
                                    //   width: 70.0,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(5.0),
                                    //     image: DecorationImage(
                                    //       image: list[i]['img'] == null
                                    //           ? AssetImage(
                                    //               "assets/images/0images.png")
                                    //           : NetworkImage(list[i]['img']),
                                    //       // image: NetworkImage(list[i]['img']),
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    // ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Wrap(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 20.0,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Color(0XFFededed),
                                                    highlightColor:
                                                        Colors.white,
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
                          ),
                          Container(
                            color: Colors.transparent,
                            height: 145.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13.0, vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    // child: Container(
                                    //   height: 120.0,
                                    //   width: 70.0,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(5.0),
                                    //     image: DecorationImage(
                                    //       image: list[i]['img'] == null
                                    //           ? AssetImage(
                                    //               "assets/images/0images.png")
                                    //           : NetworkImage(list[i]['img']),
                                    //       // image: NetworkImage(list[i]['img']),
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    // ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Wrap(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 20.0,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Color(0XFFededed),
                                                    highlightColor:
                                                        Colors.white,
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
                          ),
                          Container(
                            color: Colors.transparent,
                            height: 145.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13.0, vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    // child: Container(
                                    //   height: 120.0,
                                    //   width: 70.0,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(5.0),
                                    //     image: DecorationImage(
                                    //       image: list[i]['img'] == null
                                    //           ? AssetImage(
                                    //               "assets/images/0images.png")
                                    //           : NetworkImage(list[i]['img']),
                                    //       // image: NetworkImage(list[i]['img']),
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    // ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Wrap(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 20.0,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Color(0XFFededed),
                                                    highlightColor:
                                                        Colors.white,
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
                          ),
                        ],
                      );
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text(
            //         "Hanya itu untuk saat ini.",
            //         style: TextStyle(
            //           fontFamily: 'OpenSans',
            //           fontSize: 16.0,
            //           color: Colors.black45,
            //           fontWeight: FontWeight.w300,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new DetailBeritaPage(
                      list: list,
                      index: i,
                    ))),
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
                            image: list[i]['img'] == ""
                                ? AssetImage("assets/images/0images.png")
                                : NetworkImage(list[i]['img']),
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
                              Wrap(
                                children: <Widget>[
                                  Text(
                                    list[i]['judul'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red[600],
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    list[i]['chanel'],
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 13.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            list[i]['readmore'] == ""
                                ? ""
                                : list[i]['readmore'],
                            // list[i]['readmore'],
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
      },
    );
  }
}
