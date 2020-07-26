import 'dart:convert';
// import 'dart:html';

// import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Future<String> _loadlocationAsset() async {
//   return await rootBundle.loadString('http://103.112.162.79:3000/countperchanel');
// }

// Future loadLocation() async {
//   String jsonLocation = await _loadlocationAsset();
//   final jsonResponse = json.decode(jsonLocation);
//   LocationData location = new LocationData.fromJson(jsonResponse);
//   print(location.data[0].name);
// }

class Dd extends StatefulWidget {
  @override
  _DdState createState() => _DdState();
}

class _DdState extends State<Dd> {
  List<LocationData> _list = [];
  var loading = false;
  Future<Null> _fetchData() async {
    setState(() {
      loading = true;
    });
    final response =
        await http.get("http://103.112.162.79:3000/countperchanel");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      setState(() {
        for (Map i in data) {
          _list.add(LocationData.fromJson(i));
        }
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _list.length,
                // ignore: missing_return
                itemBuilder: (context, i) {
                  final x = _list[i];
                  // return Container(
                  //   padding: EdgeInsets.all(10.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Text(x.id),
                  //       SizedBox(
                  //         height: 5.0,
                  //       ),
                  //       Text(
                  //         "STATUS GROUP",
                  //         style: TextStyle(
                  //             fontSize: 16.0, fontWeight: FontWeight.bold),
                  //       ),
                  //       Text(x.data[i].status),
                  //     ],
                  //   ),
                  // );
                  if (x is LocationData) {
                    return ListTile(
                      title: Text(
                        x.id,
                      ),
                    );
                  } else if (x is Data) {
                    return ListTile(
                      title: Text(x.data[i].status),
                      // subtitle: Text(item.body),
                    );
                  }
                },
              ),
      ),
    );
  }
}

// class UsersDetail {
//   final int id;
//   final String name;
//   final String username;
//   final String email;
//   final Address address;
//   final String phone;
//   final String website;
//   final Company company;

//   UsersDetail(
//       {this.id,
//       this.name,
//       this.username,
//       this.email,
//       this.address,
//       this.phone,
//       this.website,
//       this.company});

//   factory UsersDetail.fromJson(Map<String, dynamic> json) {
//     return new UsersDetail(
//         id: json['id'],
//         name: json['name'],
//         username: json['username'],
//         email: json['email'],
//         address: Address.fromJson(json['address']),
//         phone: json['phone'],
//         website: json['website'],
//         company: Company.fromJson(json['company']));
//   }
// }

// class Address {
//   final String street;
//   final String suite;
//   final String city;
//   final String zipcode;

//   Address({this.street, this.suite, this.city, this.zipcode});

//   factory Address.fromJson(Map<String, dynamic> json) {
//     return new Address(
//       street: json['street'],
//       suite: json['suite'],
//       city: json['city'],
//       zipcode: json['zipcode'],
//     );
//   }
// }

// class Company {
//   final String name;
//   final String catchPhrase;
//   final String bs;

//   Company({this.name, this.catchPhrase, this.bs});
//   factory Company.fromJson(Map<String, dynamic> json) {
//     return new Company(
//       name: json['name'],
//       catchPhrase: json['catchPhrase'],
//       bs: json['bs'],
//     );
//   }
// }

class LocationData {
  final int count;
  final String id;
  final List<Data> data;

  LocationData({this.count, this.id, this.data});

  factory LocationData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['STATUS_GROUP'] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return LocationData(
        count: parsedJson['count'], id: parsedJson['_id'], data: dataList);
  }
}

class Data {
  final int count1;
  final String status;

  Data({this.count1, this.status});

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      count1: parsedJson['count'],
      status: parsedJson['STATUS'],
    );
  }
  // Map<String, dynamic> toJson() {
  //       final Map<String, dynamic> data = new Map<String, dynamic>();
  //       data['count'] = this.count1;
  //       data['STATUS'] = this.status;
  //       return data;
  //   }
}
