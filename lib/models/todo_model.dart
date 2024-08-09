import 'dart:convert';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  int? id;
  String? title;
  String? description;
  String? subject;
  String? status;
  String? priority;
  String? assignedUserName;
  String? email;
  String? avatar;
  int? assignedUserId;
  DateTime? deadline;

  TodoModel({
    this.id,
     this.title,
     this.description,
     this.subject,
     this.status,
     this.priority,
    this.assignedUserName,
    this.assignedUserId,
    this.deadline,
    this.avatar,
    this.email
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      status: (json['task_status']==null || json['task_status']==0) ? "To-Do": (json['task_status']==1)? "In Progress" : "Done",
      priority:  (json['task_priority']==null || json['task_priority']==0) ? "Low": (json['task_priority']==1)? "Medium" : "High",
      assignedUserName: json['task_assigned_userName'],
      assignedUserId: json['task_assigned_userId'],
      email: json['user_email'],
      avatar: json['user_avatar'],
      deadline: json['task_deadline'] != null ? DateTime.parse(json['task_deadline']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['subject'] = subject;
    data['task_status'] = (status==null || status=="To-Do") ? 0: (status=="In Progress")?  1: 2;
    data['task_priority'] =  (priority==null || priority=="Low") ? 0: (priority=="Medium")? 1 : 2;
    data['task_assigned_userName'] = assignedUserName;
    data['task_assigned_userId'] = assignedUserId;
    data['user_avatar'] = avatar;
    data['user_email'] = email;
    data['task_deadline'] = deadline?.toIso8601String();
    return data;
  }
}

