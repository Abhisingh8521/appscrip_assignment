import 'dart:convert';

class AuthResponse {
  String? token;
  String? message;
  bool status;
  String? id;
  AuthResponse({
  this.token,
  this.message,
  this.id,
  required this.status,

  });

}