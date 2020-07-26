import 'package:flutter/material.dart';
import 'package:babu_apk/page/semuaKategori.dart';
import 'package:babu_apk/berandaPage/semuaPage.dart';
import 'package:babu_apk/berandaPage/healthPage.dart';
import 'package:babu_apk/berandaPage/travelPage.dart';
import 'package:babu_apk/berandaPage/teknoPage.dart';
import 'package:babu_apk/berandaPage/trenPage.dart';
import 'package:babu_apk/berandaPage/newsPage.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  String text;

  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  TabController controller;
  IconData ttd = Icons.search;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 6);
    controller.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 9,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    child: TabBar(
                      isScrollable: true,
                      controller: controller,
                      indicatorColor: Colors.blue,
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      tabs: <Widget>[
                        new Tab(
                          text: "Semua",
                        ),
                        new Tab(
                          text: "News",
                        ),
                        new Tab(
                          text: "Tren",
                        ),
                        new Tab(
                          text: "Tekno",
                        ),
                        new Tab(
                          text: "Health",
                        ),
                        new Tab(
                          text: "Travel",
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new SemuaKategoriPage(),
                      ),
                    ),
                    child: Container(
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(40.0)),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new SemuaPage(),
          new NewsPage(),
          new TrenPage(),
          new TeknoPage(),
          new HealthPage(),
          new TravelPage(),
        ],
      ),
    );
  }
}
