import 'package:flutter/material.dart';
import 'package:babu_apk/page/berandaPage.dart';
import 'package:babu_apk/page/sumberPage.dart';
import 'package:babu_apk/page/kategoriPage.dart';

class ViewPage extends StatefulWidget {
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage>
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
    controller = new TabController(vsync: this, length: 3);
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: controller.index == 0
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/searchPage');
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 35.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 5.0, left: 15.0, bottom: 5.0, top: 5.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.black26,
                          size: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Cari BABU",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'OpenSans',
                              color: Colors.black26),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: new Text(
                    controller.index == 1
                        ? "Sumber"
                        : controller.index == 2 ? "Kategori" : "BABU",
                    style: new TextStyle(color: Colors.black)),
              ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new BerandaPage(),
          new SumberPage(),
          new KategoriPage(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50.0,
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
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.transparent,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey[400],
          tabs: <Widget>[
            new Tab(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.dashboard,
                      size: 20.0,
                    ),
                    Text(
                      "Beranda",
                      style: new TextStyle(fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ),
            new Tab(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.blur_circular,
                      size: 20.0,
                    ),
                    Text(
                      "Sumber",
                      style: new TextStyle(fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ),
            new Tab(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.category,
                      size: 20.0,
                    ),
                    Text(
                      "Kategori",
                      style: new TextStyle(fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
