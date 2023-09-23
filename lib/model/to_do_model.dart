import 'dart:convert';

List<ToDoModel> todomodelFromjson(String str) =>
    List<ToDoModel>.from(json.decode(str).map((x) => ToDoModel.fromjson(x)));

String todomodeltojson(List<ToDoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.tojson())));

class ToDoModel {
  String? title;
  String? content;
  String? time;

  ToDoModel({
    this.title,
    this.content,
    this.time,
  });

  factory ToDoModel.fromjson(Map<String, dynamic> json) => ToDoModel(
        title: json["title"],
        content: json["content"],
        time: json["time"],
      );

  Map<String, dynamic> tojson() => {
        "title": title,
        "content": content,
        "time": time,
      };
}
