import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'beritaSearch.dart';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class AutoCompleteDemo extends StatefulWidget {
  AutoCompleteDemo() : super();

  final String title = "AutoComplete Demo";

  @override
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Berita>> key = new GlobalKey();
  static List<Berita> users = new List<Berita>();
  bool loading = true;

  void getUsers() async {
    try {
      final response =
          await http.get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        users = loadUsers(response.body);
        print('Users: ${users.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<Berita> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Berita>((json) => Berita.fromJson(json)).toList();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Widget row(Berita user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          user.berita,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: loading
            ? CircularProgressIndicator()
            : searchTextField = AutoCompleteTextField<Berita>(
                key: key,
                clearOnSubmit: false,
                suggestions: users,
                textInputAction: TextInputAction.search,
                style: TextStyle(
                  color: Colors.black45,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  contentPadding:EdgeInsets.fromLTRB(50,0,50,0),
                  filled: true,
                  fillColor: Colors.grey,
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
                itemFilter: (item, query) {
                  return item.berita
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                },
                itemSorter: (a, b) {
                  return a.berita.compareTo(b.berita);
                },
                itemSubmitted: (item) {
                  setState(() {
                    searchTextField.textField.controller.text = item.berita;
                  });
                },
                itemBuilder: (context, item) {
                  // ui for the autocompelete row
                  return row(item);
                },
              ),
      ),
      body: ListView(
        children: [Text("data"), Text("data")],
      ),
    );
  }
}
