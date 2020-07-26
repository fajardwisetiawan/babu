import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:babu_apk/page/listSumberPage.dart';
import 'package:shimmer/shimmer.dart';

class SumberPage extends StatefulWidget {
  @override
  _SumberPageState createState() => _SumberPageState();
}

class _SumberPageState extends State<SumberPage> {
  Future<List<Map<String, dynamic>>> getData() async {
    final response =
        await http.get("http://103.112.162.79:3000/countperchanel");
    return List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    width: 3.0,
                    height: 15.0,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Container(
                    child: Text(
                      "Sumber",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ItemList(list: snapshot.data)
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 8.0),
                            child: SizedBox(
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
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 8.0),
                            child: SizedBox(
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
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 8.0),
                            child: SizedBox(
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
                          ),
                        ],
                      );
              },
            ),
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
        return new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new ListSumberPage(
                      list: list,
                      index: i,
                    ))),
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        list[i]['_id'],
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${list[i]['count']}",
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 20.0,
                    thickness: 0.5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
