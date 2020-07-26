import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  int id;
  String username;

  Category({
    this.id,
    this.username,
  });

  static Future<List<Category>> getCategories() async {
    http.Response response = await http.get("https://api.androidhive.info/contacts/");

    List<Category> list = [];

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        // Map<String, dynamic>.from(json.decode(response.body)['data']);

        for (var map in map['contacts']) {
          list.add(Category(id: map['id'], username: map['name']));
        }
      }
    } catch (e, _) {
      debugPrint(e.toString());
    }
    return list;
  }
}