import 'package:appscrip_assignment/models/user_model.dart';
import 'package:appscrip_assignment/views/screens/auth/login_screen.dart';
import 'package:appscrip_assignment/views/screens/auth/register_screen.dart';
import 'package:appscrip_assignment/views/screens/view_todo_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/auth_api_services.dart';

class UserAuthProvider extends ChangeNotifier {
  UserAuthProvider(){
    getProfile();
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

    UserModel userProfile = UserModel();
  String get name => nameController.text;

  String get email => emailController.text;

  String get password => passwordController.text;

  signUp(BuildContext context) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showMessage('Please fill empty fields');
    } else {
      print(email);
      print(password);
      var response = await AuthAPi()
          .sighUp(email: email, password: password, userName: name);
      if (response.status) {
        showMessage(response.message);
        resetFields();
        getProfile();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewTodoScreen(),
          ),
              (route) => false,
        );
      } else {
        showMessage(response.message);
      }
    }
  }

  login(BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      showMessage('Please fill empty fields');
    } else {
      var response = await AuthAPi().login(email: email, password: password);
      if (response.status) {
        showMessage(response.message);
        getProfile();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewTodoScreen(),
          ),
              (route) => false,
        );
      } else {
        showMessage(response.message);
      }
    }
  }

  logout(BuildContext context) async {
    var response = await AuthAPi().logout();
    if (response.status) {
      showMessage(response.message);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (route) => false,
      );
    } else {
      showMessage(response.message);
    }
  }

  void showMessage(String? message) {
    Fluttertoast.showToast(
      msg: message ?? '',
      toastLength: Toast.LENGTH_LONG
    );
  }

  void resetFields() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    notifyListeners();
  }

  navigateSignUp(BuildContext context) {
    resetFields();
    notifyListeners();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }
  navigateLogin(BuildContext context) {
    resetFields();
    notifyListeners();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

 Future<void> getProfile() async{
   userProfile = await AuthAPi().profile();
   notifyListeners();
  }
}