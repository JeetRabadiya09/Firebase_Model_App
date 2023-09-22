import 'dart:convert';

import 'package:firebase_model_app/view/app/to_do_add_data.dart';
import 'package:firebase_model_app/view/app/to_do_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? sharedPreferences;

  List<ToDoModel> toDoModel = [];

  setInstant() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getData();
  }

  getData() {
    toDoModel = [];
    if (sharedPreferences!.containsKey('ToDoData')) {
      var data = sharedPreferences!.getStringList("ToDoData");

      for (var mapData in data!) {
        toDoModel.add(toDoModelFromJson(mapData));
      }
      debugPrint(data.toString());
      debugPrint(jsonEncode(toDoModel));
      setState(() {});
    } else {
      debugPrint("No Data Found----------->>");
    }
  }

  setData() {
    List<String> listData = [];
    for (var mapData in toDoModel) {
      listData.add(jsonEncode(mapData));
    }

    sharedPreferences!.setStringList("ToDoData", listData);
  }

  String getGreeting() {
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;

    String greeting;

    if (currentHour < 12) {
      greeting = 'Good Morning';
    } else if (currentHour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return greeting;
  }

  @override
  void initState() {
    // TODO: implement initState
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Hello, ${getGreeting()}!",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      body: toDoModel.isEmpty
          ? const Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: toDoModel.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  title: toDoModel[index].title,
                  time: toDoModel[index].time,
                  description: toDoModel[index].discription,
                  count: "${(index + 1).toString()}.",
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoEnterData(
                          toDoModel: toDoModel[index],
                          index: index,
                        ),
                      ),
                    ).then((value) {
                      getData();
                    });
                  },
                  onDelet: () {
                    toDoModel.removeAt(index);
                    setState(() {});
                    setData();
                  },
                );
              },
              // separatorBuilder: (context, index) => SizedBox(
              //   height: MediaQuery.of(context).size.height / 150,
              // ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoEnterData(),
            ),
          ).then((value) {
            getData();
          });
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
    );
  }
}
