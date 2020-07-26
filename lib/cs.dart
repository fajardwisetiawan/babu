import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:babu_apk/model/post_result_model.dart';

class Cs extends StatefulWidget {
  @override
  _CsState createState() => _CsState();
}

class _CsState extends State<Cs> {
  PostResult postResult;

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          PostResult.connectToAPI("Aku").then((value){
                            postResult = value;
                            setState(() {});
                          });
                        },
                        child: Text('CEK'),
                      ),
                    ],
                  ),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        ListTile(
                          title: Text('nilai return'),
                          subtitle: Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('response code : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text((postResult != null)
                                    ? postResult.data[0].id
                                    : "Tidak ada data",
                                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('return message : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text((postResult != null)
                                    ? postResult.data[0].judul
                                    : "Tidak ada data",
                                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('return tanggal : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text((postResult != null)
                                    ? postResult.data[0].url
                                    : "Tidak ada data",
                                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('return jam : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text((postResult != null)
                                    ? postResult.data[0].tglPost
                                    : "Tidak ada data",
                                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('return nomorAccount : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text((postResult != null)
                                    ? postResult.data[0].img
                                    : "Tidak ada data",
                                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),
                                ),
                              ],
                            ),
                          ],),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}