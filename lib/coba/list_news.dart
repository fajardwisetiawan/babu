import 'package:flutter/material.dart';
import 'package:babu_apk/coba/category.dart';

class ListNews extends StatefulWidget {
  ListNews({Key key}) : super(key: key);

  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: Category.getCategories(),
      builder: (c, s) {
        if (s.hasData) {
          List<Tab> tabs = new List<Tab>();

          for (int i = 0; i < s.data.length; i++) {
            tabs.add(Tab(
              child: Text(
                s.data[i].username,
                style: TextStyle(color: Colors.white),
              ),
            ));
          }
          return DefaultTabController(
            length: s.data.length,
            child: Scaffold(
              appBar: AppBar(
                // title: Image.asset('assets/images/list1.jpg', fit: BoxFit.cover),
                title: Text("Oke"),
                backgroundColor: Colors.red,
                bottom: TabBar(
                  indicatorColor: Colors.blue,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: tabs,
                ),
              ),
            ),
          );
        }
        if (s.hasError) print(s.error.toString());
        return Scaffold(
          body: Center(
              child: Text(s.hasError ? s.error.toString() : "Loading...")),
        );
      },
    );
  }
}
