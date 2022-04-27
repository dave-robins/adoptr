import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'package:cat_app/adopt_view.dart';
import 'package:cat_app/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'cats_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE catsTable(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, apiId TEXT, url TEXT, tags TEXT, name TEXT)',
      );
    },
    version: 1,
  );
  CatAppDatabase catAppDatabase = CatAppDatabase(database);

  runApp(
    Provider<CatAppDatabase>(
      create: (context) => catAppDatabase,
      child: const MyApp(),
      // dispose: (context, db) => db.close(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // CatAppDatabase database = Provider.of<CatAppDatabase>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AdoptPage(),
    );
  }
}
