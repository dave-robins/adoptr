import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:cat_app/cat_model.dart';

class CatAppDatabase {
  late Database db;

  CatAppDatabase(this.db);

  Future<void> insertCat(Cat cat) async {
    await db.insert(
      'catsTable',
      cat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeCat(Cat cat) async {
    await db.delete(
      'catsTable',
      where: 'name = ?',
      whereArgs: [cat.name],
    );
  }

  Future<List<Cat>> getAllCats() async {
    final List<Map<String, dynamic>> maps = await db.query('catsTable');

    var fullList = List.generate(maps.length, (i) {
      return Cat(
        apiId: maps[i]['id'].toString(),
        url: maps[i]['url'],
        tags: maps[i]['tags'].split(','),
        name: maps[i]['name'],
      );
    });
    print(fullList);
    return fullList;
  }
}
