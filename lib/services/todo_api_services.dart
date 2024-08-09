import 'dart:convert';
import 'package:appscrip_assignment/models/to_do_response_model.dart';
import 'package:http/http.dart' as http;

class TodoApiServices {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/';
  final String _getTodoEndPoint ='todos';

  Future<List<ToDoResponseModel>> fetchTodos() async {
    final response = await http.get(Uri.parse(_baseUrl+_getTodoEndPoint));

    if (response.statusCode == 200) {
      List<dynamic> todoJsonList =json.decode(response.body);
      return todoJsonList.map((e) => ToDoResponseModel.fromJson(e),).toList() ;
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<int> addTodos(ToDoResponseModel todo ) async {
    final response = await http.post(Uri.parse(_baseUrl+_getTodoEndPoint), body:todo.toJson() );
    return response.statusCode;
  }
  Future<ToDoResponseModel> updateTodos(ToDoResponseModel todo) async {
    final response = await http.put(Uri.parse("$_baseUrl$_getTodoEndPoint/${todo.id}"));

    if (response.statusCode == 200) {
      return ToDoResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<int> deleteTodo(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl$_getTodoEndPoint/$id"));
    return response.statusCode;
  }
}


