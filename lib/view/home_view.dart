import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../model/to_do_model.dart';
import '../res/constant.dart';
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
        stream: firestore.collection("ToDoFire").snapshots(includeMetadataChanges: true),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError){
            return const Center(
              child: Text("Something went wrong............",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if
        }
      )
      // Constant.toDoModelList.isEmpty
      //     ? const Center(
      //         child: Text(
      //           "No To-Do Found",
      //           style: TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       )
      //     : ListView.separated(
      //         itemCount: Constant.toDoModelList.length,
      //         padding: const EdgeInsets.all(15),
      //         separatorBuilder: (context, index) => const SizedBox(height: 15),
      //         itemBuilder: (context, index) => ListTile(
      //           title: Text(toDoModelList[index].title ?? ""),
      //           subtitle: Text(toDoModelList[index].subtitle ?? ""),
      //         ),
              //     Container(
              //   padding: const EdgeInsets.all(15),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(15),
              //     boxShadow: const [
              //       BoxShadow(
              //         color: CupertinoColors.lightBackgroundGray,
              //         blurRadius: 10,
              //         spreadRadius: 0,
              //         offset: Offset(0, 6),
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               "Title: ${Constant.toDoModelList[index].title}",
              //               style: const TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             Text(
              //                 "SubTitle: ${Constant.toDoModelList[index].content}"),
              //           ],
              //         ),
              //       ),
              //       IconButton(
              //         onPressed: () {
              //           setState(() {
              //             Constant.toDoModelList.removeAt(index);
              //             prefs!.setString(
              //                 "ToDoList",
              //                 json.encode(Constant.toDoModelList
              //                     .map((value) => value.toJson())
              //                     .toList()));
              //           });
              //         },
              //         color: Colors.red,
              //         icon: const Icon(CupertinoIcons.delete),
              //       ),
              //       IconButton(
              //         onPressed: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => AddTodo(index: index),
              //             ),
              //           ).then((value) {
              //             setState(() {});
              //           });
              //         },
              //         color: Colors.blue,
              //         icon: const Icon(CupertinoIcons.pen),
              //       ),
              //     ],
              //   ),
              // ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTodo(),
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
