import 'package:babu_apk/page/detailBeritaPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController contSearch = new TextEditingController();
  var text;
  List data;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _getData();
    }
  }

  Future<Null> _getData() async {
    if (text == '' || text == null) {
      text = 'purwokerto';
    }
    Map param = {'search': text};
    var res = await http.post("http://192.168.0.144:3000/search", body: param);
    if (this.mounted) {
      print(res.statusCode);
      if (res.statusCode == 200) {
        setState(() {
          try {
            data = json.decode(res.body)['data'];
          } catch (e) {
            print("Error: $e");
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: new IconButton(
          color: Colors.black54,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          height: 35.0,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            controller: contSearch,
            textInputAction: TextInputAction.search,
            onChanged: (value) {
              _getData();
              setState(() {
                text = contSearch.text;
              });
            },
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black45,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.grey[400], width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
              ),
              hintText: 'Cari BABU',
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: TextFormField(
              //     controller: contSearch,
              //     onChanged: (value) {
              //       setState(() {
              //         _getData();
              //         text = contSearch.text;
              //       });
              //     },
              //     decoration: InputDecoration(labelText: 'Enter your username'),
              //   ),
              // ),
              data == null
                  ? Container(
                      height: MediaQuery.of(context).size.height * 1.0,
                      width: MediaQuery.of(context).size.width * 1.0,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  // Column(
                  //   children: <Widget>[
                  //     Container(
                  //       padding: const EdgeInsets.only(top: 20.0),
                  //       child: Text('Data kosong',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             color: Color(0xFF333333),
                  //             fontSize: 18,
                  //           )),
                  //     )
                  //   ],
                  // ),
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new DetailBeritaPage(
                                          list: data,
                                          index: index,
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
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                            // image: list[i]['img'] == ""
                                            //     ? AssetImage("assets/images/0images.png")
                                            //     : NetworkImage(list[i]['img']),
                                            image: AssetImage(
                                                "assets/images/0images.png"),
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
                                                  Text(
                                                    data[index]['judul'],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    data[index]['chanel'],
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
                                            data[index]['readmore'] == ""
                                                ? ""
                                                : data[index]['readmore'],
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
                      })
            ],
          ),
        ],
      ),
    );
  }
}
