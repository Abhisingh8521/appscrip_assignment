// import 'package:appscrip_assignment/models/to_do_response_model.dart';
// import 'package:appscrip_assignment/services/todo_api_services.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../../models/todo_model.dart';
// import '../database_controller/database_helper_controller.dart';
//
//
// class TodoProviderController with ChangeNotifier {
//   List<TodoModel> allTodoList = [];
//   List<TodoModel> isCompletedTodo = [];
//   List<TodoModel> filterTodoList = [];
//   int selectedFilterIndex = 0;
//   String  selectedFilterValue = 'All';
//   List<TodoModel> get completeTodo => isCompletedTodo;
//   DatabaseHelper dbHelper = DatabaseHelper();
//   bool checkBoxStatus = false;
//   bool loading = false;
//
//   String selectedStringDate = "";
//
//   final List<String> statusOptions = ['To-Do', 'In Progress', 'Done'];
//   final List<String> priorityOptions = ['Low', 'Medium', 'High'];
//   String selectedStatus = 'To-Do';
//   String selectedPriority = 'Low';
//
//
//   var itemList = [
//     'All',
//     'Active',
//     'Completed',
//   ];
//
//   void toggleCheckBoxValue(bool newValue) {
//     try{
//       checkBoxStatus = newValue;
//       notifyListeners();
//     }catch(e){
//       return print("Error : $e");
//     }
//
//   }
//
//   void setToggleForAddPage(){
//     try{
//       checkBoxStatus = false;
//     }catch(e){
//       return print("Error : $e");
//     }
//
//   }
//   onFilterChange(int index)async{
//     try{
//       selectedFilterIndex = index;
//       selectedFilterValue = itemList[selectedFilterIndex];
//       viewTodo(itemList[selectedFilterIndex]).then((value) {
//         notifyListeners();
//       },);
//     }
//     catch(e){
//       print("Error : $e");
//
//     }
//
//   }
//
//   Future<void> addTodo(TodoModel todo) async {
//     try{
//      var todoResult=await TodoApiServices().addTodos(ToDoResponseModel(title: todo.title, userId: todo.assignedUserId,completed: todo.status=="Done"?true:false));
//
//      if(todoResult==201){
//        await dbHelper.insertTodo(todo).then((value) {
//          allTodoList.add(todo);
//          viewTodo(selectedFilterValue);
//        },);
//      }
//
//      print("todo added $todoResult");
//     }catch(e){
//       print("Error : $e");
//     }
//   }
//
//   Future<void> viewTodo(String data) async {
//     try{
//       var getTodoApiRes =await TodoApiServices().fetchTodos();
//       if(getTodoApiRes.isNotEmpty) {
//         allTodoList = await dbHelper.viewData();
//         filterTodos(data);
//       }
//     }catch(e){
//       print("Error : $e");
//     }
//   }
//
//   Future<void> updateTodo(int index, TodoModel todo) async {
//     try{
//
//       var todoResult=await TodoApiServices().updateTodos(ToDoResponseModel(id: todo.id, title: todo.title, userId: todo.assignedUserId,completed: todo.status=="Done"?true:false));
//       if(todoResult.id!=null){
//         await dbHelper.updateTodoList(todo).then((value) {
//           allTodoList[index] = todo;
//           viewTodo(selectedFilterValue);
//         },);
//       }
//
//     }catch(e){
//       print("Error : $e");
//     }
//
//   }
//
//   Future<void> deleteTodo(int index, id) async {
//     try{
//       if(allTodoList.isNotEmpty){
//         await dbHelper.delete(id).then((value) {
//           allTodoList.removeAt(index);
//           notifyListeners();
//         },);
//
//       }else{
//         filterTodoList.clear();
//         notifyListeners();
//       }
//     }catch(e){
//       print("Error : $e");
//     }
//
//   }
//
//   Future<void>  filterTodos(String data) async{
//     try{
//       if(data == 'All'){
//         filterTodoList = allTodoList;
//         notifyListeners();
//       }
//       else if(data == 'Active'){
//         filterTodoList.clear();
//         for (var element in allTodoList) {
//           if(element.status !=null && element.status==false) {
//             filterTodoList.add(element);
//           }
//         }
//
//         notifyListeners();
//       }
//       else if(data == 'Completed'){
//         filterTodoList.clear();
//         for (var element in allTodoList) {
//           if(element.status !=null && element.status==true) {
//             filterTodoList.add(element);
//           }
//         }
//
//         notifyListeners();
//       }
//     }catch(e){
//       print("Error : $e");
//     }
//
//   }
//
//   void updateSelectedStatus(int statusIndex){
//     selectedStatus = statusOptions[statusIndex];
//     notifyListeners();
//   }
//
//   void updatePriorityStatus(int index) {
//     selectedPriority = priorityOptions[index];
//     notifyListeners();
//   }
//   Future<void> openDatePicker(BuildContext context) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (selectedDate != null && selectedDate != DateTime.now()) {
//       selectedStringDate = dateTimeToString(selectedDate);
//       print("Selected date: ${selectedDate.toLocal()}");
//       notifyListeners();
//     }
//   }
//
//
//   String dateTimeToString(DateTime selectedDate){
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     return formatter.format(selectedDate);
//   }
//
//
//
// }



import 'package:appscrip_assignment/models/to_do_response_model.dart';
import 'package:appscrip_assignment/services/todo_api_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/todo_model.dart';
import '../database_controller/database_helper_controller.dart';


class TodoProviderController with ChangeNotifier {
  TodoProviderController(){
    viewTodo('All');

  }
  List<TodoModel> allTodoList = [];
  List<TodoModel> isCompletedTodo = [];
  List<TodoModel> filterTodoList = [];
  int selectedFilterIndex = 0;
  String  selectedFilterValue = 'All';
  List<TodoModel> get completeTodo => isCompletedTodo;
  DatabaseHelper dbHelper = DatabaseHelper();
  bool checkBoxStatus = false;
  bool loading = false;

  String selectedStringDate = "";

  final List<String> statusOptions = ['To-Do', 'In Progress', 'Done'];
  final List<String> priorityOptions = ['Low', 'Medium', 'High'];
  String selectedStatus = 'To-Do';
  String selectedPriority = 'Low';


  var itemList = [
    'All',
    'To-Do',
    'In Progress',
    'Done'
  ];

  void toggleCheckBoxValue(bool newValue) {
    try{
      checkBoxStatus = newValue;
      notifyListeners();
    }catch(e){
      return print("Error : $e");
    }

  }

  void setToggleForAddPage(){
    try{
      checkBoxStatus = false;
    }catch(e){
      return print("Error : $e");
    }

  }
  onFilterChange(int index)async{
    try{
      selectedFilterIndex = index;
      selectedFilterValue = itemList[selectedFilterIndex];
      viewTodo(itemList[selectedFilterIndex]).then((value) {
        notifyListeners();
      },);
    }
    catch(e){
      print("Error : $e");

    }

  }

  Future<void> addTodo(TodoModel todo) async {
    try{
      var todoResult=await TodoApiServices().addTodos(ToDoResponseModel(title: todo.title, userId: todo.assignedUserId,completed: todo.status=="Done"?true:false));

      if(todoResult==201){
        await dbHelper.insertTodo(todo).then((value) {
          allTodoList.add(todo);
          viewTodo(selectedFilterValue);
        },);
      }

      print("todo added $todoResult");
    }catch(e){
      print("Error : $e");
    }
  }

  Future<void> viewTodo(String data) async {
    try{
      var getTodoApiRes =await TodoApiServices().fetchTodos();
      if(getTodoApiRes.isNotEmpty) {
        allTodoList = await dbHelper.viewData();
        filterTodos(data);
      }
    }catch(e){
      print("Error : $e");
    }
  }

  Future<void> updateTodo(int index, TodoModel todo) async {
    try{
      await dbHelper.updateTodoList(todo).then((value) {
        allTodoList[index] = todo;
        viewTodo(selectedFilterValue);
      },);

    }catch(e){
      print("Error : $e");
    }

  }

  Future<void> deleteTodo(int index, id) async {
    try{
      if(allTodoList.isNotEmpty){
        await dbHelper.delete(id).then((value) {
          allTodoList.removeAt(index);
          notifyListeners();
        },);

      }else{
        filterTodoList.clear();
        notifyListeners();
      }
    }catch(e){
      print("Error : $e");
    }

  }

  Future<void>  filterTodos(String data) async{
    try{
      if(data == 'All'){
        filterTodoList = allTodoList;
        notifyListeners();
      }
      else if(data == 'To-Do'){
        filterTodoList.clear();
        for (var element in allTodoList) {
          if(element.status !=null && element.status=='To-Do') {
            filterTodoList.add(element);
          }
        }

        notifyListeners();
      }
      else if(data == 'In Progress'){
        filterTodoList.clear();
        for (var element in allTodoList) {
          if(element.status !=null && element.status=='In Progress') {
            filterTodoList.add(element);
          }
        }

        notifyListeners();
      }
      else if(data == 'Done'){
        filterTodoList.clear();
        for (var element in allTodoList) {
          if(element.status !=null && element.status=='Done') {
            filterTodoList.add(element);
          }
        }

        notifyListeners();
      }
    }catch(e){
      print("Error : $e");
    }

  }

  void updateSelectedStatus(int statusIndex){
    selectedStatus = statusOptions[statusIndex];
    notifyListeners();
  }

  void updatePriorityStatus(int index) {
    selectedPriority = priorityOptions[index];
    notifyListeners();
  }
  Future<void> openDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      selectedStringDate = dateTimeToString(selectedDate);
      print("Selected date: ${selectedDate.toLocal()}");
      notifyListeners();
    }
  }


  String dateTimeToString(DateTime selectedDate){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(selectedDate);
  }



}