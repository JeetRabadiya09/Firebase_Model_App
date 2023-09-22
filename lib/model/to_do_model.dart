import 'dart:convert';

ToDoModelData toDoModelDataFromJson(String str) =>
    ToDoModelData.fromJson(json.decode(str));

String toDoModelDataToJson(ToDoModelData data) => json.encode(data.tojson());

class ToDoModelData {
  String? title;
  String? subtitle;
  String? time;

  ToDoModelData({
    this.title,
    this.subtitle,
    this.time,
  });
  //
  // ToDoModelData.fromJson(Map<String, dynamic> json) {
  //   title = json['title'];
  //   subtitle = json['subtitle'];
  //   time = json['time'];
  // }
  factory ToDoModelData.fromJson(Map<String, dynamic> json) => ToDoModelData(
        title: json['title'],
        subtitle: json['subtitle'],
        time: json['time'],
      );
  // get toJson => null;
  Map<String, dynamic> tojson() => {
        "title": title,
        "subtitle": subtitle,
        "time": time,
      };
// ToDoModelData.tojson(Map<String, dynamic> json) {
//   title = json['title'];
//   content = json['content'];
//   time = json['time'];
// }
}
