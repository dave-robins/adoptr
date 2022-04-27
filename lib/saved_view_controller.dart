import 'package:cat_app/db.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:cat_app/cat_model.dart';
import 'package:provider/provider.dart';

class SavedViewController {
  late BuildContext context;

  SavedViewController(this.context);

  Future<List<Cat>> getAllCats() async {
    CatAppDatabase db = Provider.of<CatAppDatabase>(context, listen: false);
    return await db.getAllCats();
  }

  Future<void> deleteCat(Cat cat) async {
    CatAppDatabase db = Provider.of<CatAppDatabase>(context, listen: false);
    return await db.removeCat(cat);
  }
}
