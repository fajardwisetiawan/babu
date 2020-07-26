import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbSearchManager {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "ss.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(         
           "CREATE TABLE search(id INTEGER PRIMARY KEY autoincrement, name TEXT)",
           
            );
      } );
    }
  }

  Future<int> insertSearch(Search search) async {
    await openDb();
    return await _database.insert('search', search.toMap());
  }

  Future<List<Search>> getSearchList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('search');
    return List.generate(maps.length, (i) {
      return Search(
          id: maps[i]['id'], name: maps[i]['name']);
    });
  }

  Future<int> updateSearch(Search search) async {
    await openDb();    
    return await _database.update('search', search.toMap(),
        where: "id = ?", whereArgs: [search.id]);
  }

  Future<void> deleteSearch(int id) async {
    await openDb();
    await _database.delete(
      'search',
        where: "id = ?", whereArgs: [id]
    );
  }
}

class Search {
  int id;
  String name;
  Search({@required this.name, this.id});
  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}