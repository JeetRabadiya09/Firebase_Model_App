// !=
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/to_do_model.dart';
import '../utils/utils.dart';

class AddEditToDoView extends StatefulWidget {
  final ToDoModel? toDoModel;
  final String? id;

  const AddEditToDoView({super.key, this.toDoModel, this.id});

  @override
  State<AddEditToDoView> createState() => _AddEditToDoViewState();
}

class _AddEditToDoViewState extends State<AddEditToDoView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String time = "";

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

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  SetTodo() {
    try {
      firestore.collection("ToDoFire").add({
        "title": titleController.text.trim(),
        "content": contentController.text.trim(),
        "time": time,
      }).then(
        (value) {
          Utils().showToastMessage(content: "To Do successfully add");
          Navigator.pop(context);
        },
      );
    } on FirebaseException catch (error) {
      Utils()
          .showSnackBar(context: context, content: "Firebase Error-->$error");
    } catch (error) {
      Utils().showSnackBar(context: context, content: "$error");
    }
  }

  updateTodo() {
    try {
      firestore.collection("ToDoFire").doc(widget.id).update({
        "title": titleController.text.trim(),
        "content": contentController.text.trim(),
        "time": time,
      }).then(
        (value) {
          Utils().showToastMessage(content: "To Do successfully update");
          Navigator.pop(context);
        },
      );
    } on FirebaseException catch (error) {
      debugPrint("Firebase error------------>$error");
      Utils()
          .showSnackBar(context: context, content: "Firebase Error-->$error");
    } catch (error) {
      Utils().showSnackBar(context: context, content: "$error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    if (widget.toDoModel != null) {
      titleController.text = widget.toDoModel!.title!;
      contentController.text = widget.toDoModel!.title!;
      time = widget.toDoModel!.time!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    // double screenWidth = size.width;
    // EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.toDoModel == null ? "Add To-do" : "Edit To-Do",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextField(
                  controller: titleController,
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
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.deepPurple),
                    ),
                    // contentPadding: const EdgeInsets.all(00),
                    isDense: true,
                    labelText: "contant",
                    hintText: "Enter contant ",
                    contentPadding: const EdgeInsets.all(30),
                    hintStyle: const TextStyle(
                        color: Color(0xFFB3B3B3),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins"),
                  ),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => displayTimePicker(context),
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black54, width: 1.2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(time.isEmpty ? "hh : mm" : time),
                      const SizedBox(width: 8),
                      const Icon(Icons.date_range_rounded),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight / 2),
              const SizedBox(width: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.toDoModel == null) {
                      SetTodo();
                    } else {
                      updateTodo();
                    }
                  },
                  child: Text(
                      widget.toDoModel == null ? "Add To-do" : "Edit To-Do"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
