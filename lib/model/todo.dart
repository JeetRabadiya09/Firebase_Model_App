// To parse this JSON data, do
//
//     final toDoModel = toDoModelFromJson(jsonString);

import 'dart:convert';

ToDoModel toDoModelFromJson(String str) => ToDoModel.fromJson(json.decode(str));

String toDoModelToJson(ToDoModel data) => json.encode(data.toJson());

class ToDoModel {
  String? title;
  String? discription;
  String? time;

  ToDoModel({
    this.title,
    this.discription,
    this.time,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        title: json["title"],
        discription: json["discription"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "discription": discription,
        "time": time,
      };
}
