import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:babu_apk/splashScreenPage.dart';
import 'package:babu_apk/page/viewPage.dart';
import 'package:babu_apk/page/detailBeritaPage.dart';
import 'package:babu_apk/page/listKategoriPage.dart';
import 'package:babu_apk/page/listSumberPage.dart';
import 'package:babu_apk/searchPage.dart';
import 'package:babu_apk/cs.dart';
// import 'package:babu_apk/search/autosearch.dart';
// import 'package:babu_apk/search/mainSearch.dart';
// import 'package:babu_apk/f.dart';
import 'package:babu_apk/aa.dart';
import 'package:babu_apk/dd.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
        title: 'BABU',
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
        routes: <String, WidgetBuilder>{
          '/spalshScreenPage': (BuildContext context) => new SplashScreenPage(),
          '/viewPage': (BuildContext context) => new ViewPage(),
          '/detailBeritaPage': (BuildContext context) => new DetailBeritaPage(),
          '/listKategoriPage': (BuildContext context) =>
              new ListKategoriPage(),
          '/listSumberPage': (BuildContext context) => new ListSumberPage(),
          '/searchPage': (BuildContext context) => new SearchPage(),
        });
  }
}
