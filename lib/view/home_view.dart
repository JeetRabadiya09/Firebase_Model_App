import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_model_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/to_do_model.dart';
import 'add_todo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ToDoModel> toDoData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To - Do View"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection("ToDoFire")
              .snapshots(includeMetadataChanges: true),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Something went wrong............",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No To-Do Found............",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }

            toDoData = List<ToDoModel>.from(snapshot.data!.docs.map((value) =>
                ToDoModel.fromjson(value.data()! as Map<String, dynamic>)));
            return ListView.separated(
              itemCount: toDoData.length,
              padding: const EdgeInsets.all(15),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: CupertinoColors.lightBackgroundGray,
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title: ${toDoData[index].title}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("SubTitle: ${toDoData[index].content}"),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        firestore
                            .collection("ToDoFire")
                            .doc(snapshot.data!.docs[index].id)
                            .delete()
                            .then((value) {
                          toDoData.removeAt(index);
                          Utils().showToastMessage(content: "TO Do Deleted");
                        });
                        setState(() {});
                      },
                      color: Colors.red,
                      icon: const Icon(CupertinoIcons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditToDoView(
                              id: snapshot.data!.docs[index].id,
                              toDoModel: toDoData[index],
                            ),
                          ),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      color: Colors.blue,
                      icon: const Icon(CupertinoIcons.pen),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditToDoView(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('Add To-do'),
      ),
    );
  }
}
