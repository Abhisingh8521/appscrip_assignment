
import 'package:appscrip_assignment/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../services/user_api_services.dart';

class UserApiProvider with ChangeNotifier {
  final UserApiServices _userApiServices = UserApiServices();
  UserApiResponse? apiResponse;
  bool isLoading = false;
  String? error;

  String taskAssignedUser = "Select User";
  String taskAssignedEmail = "";
  String taskAssignedAvtar = "";
  int taskAssignedId = 0;

  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();

    try {
      apiResponse = await _userApiServices.fetchUsers();
      error = null;
    } catch (e) {
      error = e.toString();
      apiResponse = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  void updateAssignUser(int index) {
    if(apiResponse!=null){
      taskAssignedUser= apiResponse!.users[index].fullName;
      taskAssignedId= apiResponse!.users[index].id??0;
      taskAssignedEmail= apiResponse!.users[index].email??"";
      taskAssignedAvtar= apiResponse!.users[index].avatar??"";
      notifyListeners();
    }
  }
}
