
import 'dart:convert';

List<ToDoResponseModel> toDoResponseModelFromJson(String str) => List<ToDoResponseModel>.from(json.decode(str).map((x) => ToDoResponseModel.fromJson(x)));

String toDoResponseModelToJson(List<ToDoResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToDoResponseModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  ToDoResponseModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory ToDoResponseModel.fromJson(Map<String, dynamic> json) => ToDoResponseModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId.toString(),
    "title": title,
    "completed": completed.toString(),
  };
}
