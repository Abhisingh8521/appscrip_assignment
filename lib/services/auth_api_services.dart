import 'dart:convert';
import 'package:appscrip_assignment/models/auth_response.dart';
import 'package:appscrip_assignment/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthAPi {
  final String _baseUrl = 'https://reqres.in';
  final String _middlePoint = 'api';
  String _endPoint = '';
  Uri get _url => Uri.parse('$_baseUrl/$_middlePoint/$_endPoint');

  Future<AuthResponse> login({required String email, required String password}) async {
    AuthResponse responseData;
    _endPoint = 'login';
    var reqBody = <String, String>{"email": email, "password": password};
    try {
      var response = await http.post(_url, body: reqBody);
      var decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // var id = decodedData["id"];
        var token = decodedData["token"];
        responseData = AuthResponse(status: true,token: token,message: "Login successful");
        await storeToken(responseData);
      } else {
        var error = decodedData['error'];
        responseData = AuthResponse(status: false,message: "$error");
      }
    } catch (e) {
      responseData = AuthResponse(status: false, message: "$e");
    }
    return responseData;
  }
  Future<AuthResponse> sighUp({required String email, required String password,required String userName}) async {
    AuthResponse responseData;
    _endPoint = 'register';
    var reqBody = <String, String>{"email": email, "password": password};
    try {
      var response = await http.post(_url, body: reqBody);
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      if (response.statusCode == 200) {
        var id = decodedData["id"];
        var token = decodedData["token"];
        responseData = AuthResponse(status: true,id:id.toString(),token: token.toString(),message: "SignUp successful");
        await storeId(responseData);
        await storeToken(responseData);
      } else {
        var error = decodedData['error'];
        responseData = AuthResponse(status: false,message: "$error");
      }
    } catch (e) {
      responseData = AuthResponse(status: false, message: "error $e");
    }
    return responseData;
  }

  Future<UserModel> profile() async {
    var id = await getId();
    UserModel responseData;
    _endPoint = 'users/$id';
    var token = await getToken();
    var headers = {
      'Authorization':'Bearer $token'
    };
    try {
      var response = await http.get(_url);
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      print(id);
      if (response.statusCode == 200) {

        responseData = UserModel.fromJson(decodedData['data']);

      } else {
        responseData = UserModel(id: id);
      }
    } catch (e) {
      print(e.toString());
      responseData = UserModel(id: id);
    }
    return responseData;
  }
  Future<void> storeToken(AuthResponse responseData) async{
    var pref = await SharedPreferences.getInstance();
    await pref.setString('token', responseData.token ?? '');
    return;
  }
  Future<void> storeId(AuthResponse responseData) async{
    var pref = await SharedPreferences.getInstance();
    await pref.setString('id', responseData.id.toString() ?? '');
    return;
  }
  Future<String> getToken() async{
    var pref = await SharedPreferences.getInstance();
    var token =  pref.getString('token') ?? '';
    return token;
  }
  Future<String> getId() async{
    var pref = await SharedPreferences.getInstance();
    var token =  pref.getString('id') ?? '';
    return token;
  }
  Future<AuthResponse>  isLogin() async{
    var token = await getToken();
    if(token.isEmpty){
      return AuthResponse(status: false,message: "Not logged in");
    }else{
      return AuthResponse(status: true,message: "logged in",token: token);
    }
  }
  Future<AuthResponse>  isSignUp() async{
    var token = await getId();
    if(token.isEmpty){
      return AuthResponse(status: false,message: "Not Signed Up");
    }else{
      return AuthResponse(status: true,message: "Signed Up",token: token);
    }
  }
  Future<AuthResponse> logout() async{
    _endPoint ='logout';
    var token = await getToken();
    var headers = {
      'Authorization':'Bearer $token'
    };
    AuthResponse responseData;
    try {
      var response = await http.post(_url, headers: headers);
      var decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await storeToken(AuthResponse(status: true,token: ''));
        responseData = AuthResponse(status: true,token: '',message: 'Logout Successfully',id: '');
      } else {
        responseData = AuthResponse(status: false,token: '',message: 'Logout failed',id: '');
      }
    } catch (e) {
      responseData = AuthResponse(status: false, message: "$e");
    }
    return responseData;
  }
}