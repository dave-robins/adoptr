import 'package:flutter/material.dart';
import 'package:cat_app/saved_view_controller.dart';
import 'package:cat_app/cat_model.dart';

class SavedView extends StatelessWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SavedViewController controller = SavedViewController(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Cats'),
      ),
      body: FutureBuilder<Object>(
          future: controller.getAllCats(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<Cat> allCats = snapshot.data as List<Cat>;
              return ListView.separated(
                  itemCount: allCats.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key(allCats[index].apiId),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        await controller.deleteCat(allCats[index]);
                      },
                      background: Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(allCats[index].url),
                        ),
                        title: Text(
                          allCats[index].name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        // subtitle: Text(allCats[index].tags.toString()),
                        subtitle: tagList(allCats[index].tags),
                        isThreeLine: false,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider());
            } else {
              return const Center(child: Text("error"));
            }
          }),
    );
  }

  Widget tagList(List tags) {
    return tags[0].length > 0
        ? Container(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              // child: Row(
              children: tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.only(right: 5, top: 5),
                  child: Center(
                    child: Container(
                      color: const Color.fromARGB(255, 118, 212, 255),
                      padding: const EdgeInsets.all(7),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              // ),
            ),
          )
        : Container();
  }
}
