// import 'package:flutter/material.dart';
// import './sqlite/dbmanager.dart';
// import 'package:http/http.dart' as http;
// import 'search/beritaSearch.dart';
// import 'dart:convert';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:shimmer/shimmer.dart';

// class SearchPage extends StatefulWidget {
//   SearchPage() : super();

//   final String title = "AutoComplete Demo";
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final DbSearchManager dbmanager = new DbSearchManager();

//   final _nameController = TextEditingController();
//   final _formKey = new GlobalKey<FormState>();
//   Search search;
//   List<Search> searchlist;
//   int updateIndex;

//   AutoCompleteTextField searchTextField;
//   GlobalKey<AutoCompleteTextFieldState<Berita>> key = new GlobalKey();
//   static List<Berita> beritas = new List<Berita>();
//   bool loading = true;

//   void getUsers() async {
//     try {
//       final response =
//           await http.get("http://192.168.0.144:3000/search");
//       if (response.statusCode == 200) {
//         beritas = loadUsers(response.body);
//         print('Beritas: ${beritas.length}');
//         setState(() {
//           loading = false;
//         });
//       } else {
//         print("Error getting users.");
//       }
//     } catch (e) {
//       print("Error getting users.");
//     }
//   }

//   static List<Berita> loadUsers(String jsonString) {
//     final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
//     return parsed.map<Berita>((json) => Berita.fromJson(json)).toList();
//   }

//   @override
//   void initState() {
//     getUsers();
//     super.initState();
//   }

//   Widget row(Berita berita) {
//     return Container(
//       height: 40.0,
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Icon(
//               Icons.search,
//               size: 18.0,
//               color: Colors.black54,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(1.0),
//             child: Text(
//               berita.berita,
//               style: TextStyle(fontSize: 17.0, color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         leading: new IconButton(
//           color: Colors.black54,
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         //   title: Container(
//         //     // alignment: Alignment.centerLeft,
//         //     height: 35.0,
//         //     // width: MediaQuery.of(context).size.width * 0.8,
//         //     decoration: BoxDecoration(
//         //       color: Colors.grey[200],
//         //       borderRadius: BorderRadius.circular(20.0),
//         //     ),
//         //     child: TextField(
//         //       controller: _nameController,
//         //       textInputAction: TextInputAction.search,
//         //       onSubmitted: (value) {
//         //         _submitSearch(context);
//         //       },
//         //       keyboardType: TextInputType.text,
//         //       style: TextStyle(
//         //         color: Colors.black45,
//         //         fontFamily: 'OpenSans',
//         //       ),
//         //       decoration: new InputDecoration(
//         //         // labelText: 'Name',
//         //         focusedBorder: OutlineInputBorder(
//         //           borderRadius: BorderRadius.circular(20.0),
//         //           borderSide: BorderSide(color: Colors.grey[400], width: 1.0),
//         //         ),
//         //         enabledBorder: OutlineInputBorder(
//         //           borderRadius: BorderRadius.circular(20.0),
//         //           borderSide: BorderSide(color: Colors.grey[200], width: 1.0),
//         //         ),
//         //         hintText: 'Cari BABU',
//         //         hintStyle: TextStyle(
//         //           color: Colors.grey[400],
//         //           fontFamily: 'OpenSans',
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         title: Container(
//           height: 35.0,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: loading
//               ? SizedBox(
//                   width: double.infinity * 0.9,
//                   height: 40.0,
//                   child: Shimmer.fromColors(
//                     baseColor: Color(0XFFededed),
//                     highlightColor: Colors.white,
//                     child: Container(
//                       height: 40.0,
//                       width: double.infinity * 0.9,
//                       color: Color(0xFFededed),
//                     ),
//                   ),
//                 )
//               : searchTextField = AutoCompleteTextField<Berita>(
//                   key: key,
//                   clearOnSubmit: false,
//                   suggestions: beritas,
//                   controller: _nameController,
//                   textInputAction: TextInputAction.search,
//                   textSubmitted: (value) {
//                     _submitSearch(context);
//                   },
//                   style: TextStyle(
//                     color: Colors.black45,
//                     fontFamily: 'OpenSans',
//                   ),
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide:
//                           BorderSide(color: Colors.grey[400], width: 1.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide:
//                           BorderSide(color: Colors.grey[200], width: 1.0),
//                     ),
//                     hintText: 'Cari BABU',
//                     hintStyle: TextStyle(
//                       color: Colors.grey[400],
//                       fontFamily: 'OpenSans',
//                     ),
//                   ),
//                   itemFilter: (item, query) {
//                     return item.berita
//                         .toLowerCase()
//                         .startsWith(query.toLowerCase());
//                   },
//                   itemSorter: (a, b) {
//                     return a.berita.compareTo(b.berita);
//                   },
//                   itemSubmitted: (item) {
//                     setState(() {
//                       searchTextField.textField.controller.text = item.berita;
//                     });
//                   },
//                   itemBuilder: (context, item) {
//                     // ui for the autocompelete row
//                     return row(item);
//                   },
//                 ),
//         ),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
//                     child: Text(
//                       "Riwayat Pencarian",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   FutureBuilder(
//                     future: dbmanager.getSearchList(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         searchlist = snapshot.data;
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: searchlist == null ? 0 : searchlist.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             Search st = searchlist[index];
//                             return Container(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     onTap: () {
//                                       _nameController.text = st.name;
//                                       search = st;
//                                       updateIndex = index;
//                                     },
//                                     child: Container(
//                                       color: Colors.transparent,
//                                       width: width * 0.6,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: <Widget>[
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Icon(
//                                               Icons.history,
//                                               size: 18.0,
//                                               color: Colors.black54,
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               '${st.name}',
//                                               style: TextStyle(
//                                                   color: Colors.black54,
//                                                   fontSize: 15.0),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       dbmanager.deleteSearch(st.id);
//                                       setState(() {
//                                         searchlist.removeAt(index);
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.close,
//                                       size: 18.0,
//                                       color: Colors.black54,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }
//                       return new SizedBox(
//                         width: double.infinity,
//                         height: 20.0,
//                         child: Shimmer.fromColors(
//                           baseColor: Color(0XFFededed),
//                           highlightColor: Colors.white,
//                           child: Container(
//                             height: 20.0,
//                             width: double.infinity,
//                             color: Color(0xFFededed),
//                           ),
//                         ),
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _submitSearch(BuildContext context) {
//     if (_formKey.currentState.validate()) {
//       if (search == null) {
//         Search st = new Search(name: _nameController.text);
//         dbmanager.insertSearch(st).then((id) => {
//               _nameController.clear(),
//               // ignore: unnecessary_brace_in_string_interps
//               print('Search Added to Db ${id}')
//             });
//       } else {
//         search.name = _nameController.text;

//         dbmanager.updateSearch(search).then((id) => {
//               setState(() {
//                 searchlist[updateIndex].name = _nameController.text;
//               }),
//               _nameController.clear(),
//               search = null
//             });
//       }
//     }
//   }
// }
