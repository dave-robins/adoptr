import 'package:cat_app/db.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:cat_app/cat_model.dart';
import 'package:provider/provider.dart';

class AdoptViewController {
  late BuildContext context;

  AdoptViewController(this.context);

  Future<Cat> fetchCat() async {
    try {
      final response = await http
          .get(Uri.parse('https://cataas.com/cat?json=true&type=:sq'));
      var catJson = jsonDecode(response.body);

      Cat newCat = Cat(
          apiId: catJson['id'],
          url: 'https://cataas.com${catJson['url']}',
          tags: catJson['tags'],
          name: '');

      Cat fakeCat = Cat(
        apiId: '595f280e557291a9750ebfab',
        url:
            'https://image.shutterstock.com/image-photo/pitbull-dressed-cat-ears-halloween-260nw-1537669772.jpg',
        tags: ['fakeTag'],
      );

      return newCat;
    } catch (err) {
      return Cat(
          apiId: '12abe3',
          tags: ['test1', 'test2'],
          url:
              'https://www.rd.com/wp-content/uploads/2020/05/GettyImages-1190284847-e1590698444425.jpg',
          name: "Error: ${err.toString()}");
    }
  }

  Future<void> saveCat(cat) async {
    CatAppDatabase db = Provider.of<CatAppDatabase>(context, listen: false);
    await db.insertCat(cat);
    // await fetchCat();
  }
}
