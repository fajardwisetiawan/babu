import 'package:babu_apk/page/detailBeritaPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      text = 'aku';
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
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: contSearch,
                  onChanged: (value) {
                    setState(() {
                      _getData();
                      text = contSearch.text;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Enter your username'),
                ),
              ),
              // Text(text),
              data == null
                  ? Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                              'Data kosong',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 18,
                              )),
                        )
                      ],
                    )
                  : ListView.builder(
                      //MEMBUAT LISTVIEW
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data == null
                          ? 0
                          : data
                              .length, //KETIKA DATANYA KOSONG KITA ISI DENGAN 0 DAN APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new DetailBeritaPage(
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
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            // image: list[i]['img'] == ""
                            //     ? AssetImage("assets/images/0images.png")
                            //     : NetworkImage(list[i]['img']),
                            image: AssetImage("assets/images/0images.png"),
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
                                    data[index]['judul'],
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
