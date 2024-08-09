import 'dart:convert';
import 'package:appscrip_assignment/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApiServices {
  final String _baseUrl = 'https://reqres.in/api/';
  final String _getUserEndPoint = 'users?page=1&per_page=500';

  Future<UserApiResponse> fetchUsers() async {
    final response = await http.get(Uri.parse(_baseUrl+_getUserEndPoint));

    if (response.statusCode == 200) {
      return UserApiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }
}


