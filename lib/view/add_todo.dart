import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/to_do_model.dart';
import '../res/constant.dart';

class AddTodo extends StatefulWidget {
  final int? index;
  const AddTodo({
    super.key,
    this.index,
  });

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController subtitlecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  userdata() {
    try {
      firestore.collection('Firebase data').where("").get().then(
        (value) {
          debugPrint("value.size ------> ${value.size}");

          for (var data in value.docs) {
            debugPrint("value.id ------> ${data.id}");
            debugPrint("value.docs ------> ${data.data()}");
          }
        },
      );
    } on FirebaseException catch (error) {
      debugPrint("Firebase error------> $error");
    } catch (error) {
      debugPrint("error------> $error");
    }
  }

  storeuserdata() {
    try {
      firestore.collection('Firebase data').add(
        {
          "TextEditingController": titlecontroller,
          "TextEditingController": subtitlecontroller,
          "TextEditingController": timecontroller
        },
      ).then(
        (value) {
          debugPrint("Data add------> ");
        },
      );
    } on FirebaseException catch (error) {
      debugPrint("Firebase error------> $error");
    } catch (error) {
      debugPrint("error------> $error");
    }
  }

// @override
// void initState() {
//   // TODO: implement initState
//   userdata();
//   super.initState();
// }
  String time = "";

  SharedPreferences? prefs;

  setInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  TimeOfDay timeOfDay = TimeOfDay.now();
  Future displayTimePicker(BuildContext context) async {
    var timeData = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (timeData != null) {
      setState(() {
        // time = "${timeData.hour}:${timeData.minute}";
        time = timeData.format(context);
      });
    }
  }

  setTodoData() {
    prefs!.setString(
        "ToDoModelData",
        json.encode(
            Constant.toDoModelList.map((value) => value.tojson!()).toList()));
  }

  @override
  void initState() {
    // TODO: implement initState
    setInstance();
    userdata();

    if (widget.index != null) {
      titlecontroller.text = Constant.toDoModelList[widget.index!].title!;
      subtitlecontroller.text = Constant.toDoModelList[widget.index!].subtitle!;
      time = Constant.toDoModelList[widget.index!].time!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index == null ? "Add To-do" : "Edit To-Do"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 1, color: Colors.deepPurple),
                ),
                // contentPadding: const EdgeInsets.all(00),
                isDense: true,
                labelText: "title",
                hintText: "Enter title ",
                contentPadding: const EdgeInsets.all(12),
                hintStyle: const TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins"),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: subtitlecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 1, color: Colors.deepPurple),
                ),
                // contentPadding: const EdgeInsets.all(00),
                isDense: true,
                labelText: "Subtitle",
                hintText: "Enter Subtitle ",
                contentPadding: const EdgeInsets.all(30),
                hintStyle: const TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins"),
              ),
              onTap: () {},
            ),
            // AppTextFiled(
            //   controller: titleController,
            //   hintText: "Enter Title",
            //   textInputType: TextInputType.text,
            // ),
            // const SizedBox(height: 15),
            // AppTextFiled(
            //   controller: contentController,
            //   hintText: "Enter Content",
            //   textInputType: TextInputType.text,
            // ),
            const SizedBox(height: 15),
            // GestureDetector(
            //   onTap: () => displayTimePicker(context),
            //   child: Container(
            //     height: 45,
            //     padding: const EdgeInsets.symmetric(horizontal: 15),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(color: Colors.black54, width: 1.2),
            //     ),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Text(time.isEmpty ? "hh : mm" : time),
            //         const SizedBox(width: 8),
            //         const Icon(Icons.date_range_rounded),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 25),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (widget.index != null) {
                    //? To Edit to-do model in to-doModel list
                    Constant.toDoModelList[widget.index!] = ToDoModelData(
                      title: titlecontroller.text,
                      subtitle: subtitlecontroller.text,
                      time: timecontroller.text,
                    );
                    setState(() {});
                  } else {
                    //? To add to-do model in to-doModel list
                    Constant.toDoModelList.add(
                      ToDoModelData(
                        title: titlecontroller.text,
                        subtitle: subtitlecontroller.text,
                        time: timecontroller.text,
                      ),
                    );
                    setState(() {});
                  }
                  setTodoData();
                  Navigator.pop(context);
                },
                child: Text(widget.index == null ? "Add To-do" : "Edit To-Do"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
