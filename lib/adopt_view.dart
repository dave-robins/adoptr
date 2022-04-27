import 'package:flutter/material.dart';
import 'package:cat_app/cat_model.dart';
import 'package:cat_app/adopt_view_controller.dart';
import 'package:cat_app/saved_cats_view.dart';

class AdoptPage extends StatefulWidget {
  const AdoptPage({super.key});

  @override
  State<AdoptPage> createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  @override
  Widget build(BuildContext context) {
    AdoptViewController controller = AdoptViewController(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Adopt"), actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedView()),
              );
            },
            icon: const Icon(Icons.list)),
      ]),
      body: FutureBuilder<Object>(
          future: controller.fetchCat(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              Cat currentCat = snapshot.data as Cat;

              return Column(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 400,
                          minHeight: 400,
                          minWidth: 400,
                        ),
                        child: Image.network(currentCat.url, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.cancel),
                          color: Colors.blueGrey,
                          onPressed: () async {
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                            iconSize: 50,
                            icon: const Icon(Icons.check_circle),
                            color: Colors.blue,
                            onPressed: () async {
                              await _displayTextInputDialog(
                                  context, currentCat, controller);
                              setState(() {});
                            }),
                      ),
                    ],
                  )
                ],
              );
            } else {
              return errorCat(snapshot.error.toString());
            }
          }),
    );
  }

  Future<String> _displayTextInputDialog(BuildContext context, Cat currentCat,
      AdoptViewController controller) async {
    TextEditingController textFieldController = TextEditingController();
    String name = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('What would you like to name your cat?'),
          content: TextField(
            autocorrect: false,
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                currentCat.name = textFieldController.text;
                controller.saveCat(currentCat);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return name;
  }

  Widget errorCat(String message) {
    return Column(children: [
      Center(
        child: Image.network(
          'https://www.rd.com/wp-content/uploads/2020/05/GettyImages-1190284847-e1590698444425.jpg',
        ),
      ),
      Text('Error: $message')
    ]);
  }
}
