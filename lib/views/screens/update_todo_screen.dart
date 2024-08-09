
import 'package:appscrip_assignment/views/screens/view_todo_Screen.dart';
import 'package:appscrip_assignment/views/utils/extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controllers/api_provider/user_api_provider.dart';
import '../../controllers/provider_controller/todo_provider_controller.dart';
import '../../models/todo_model.dart';
import '../utils/widgets/app_widgets.dart';
import 'add_todo_screen.dart';


class UpdateTodoScreen extends StatefulWidget {
  const UpdateTodoScreen({super.key, required this.dataModel, required this.index});
  final TodoModel dataModel;
  final int index;

  @override
  State<UpdateTodoScreen> createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  var view = AppWidgets();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    var userApiProvider = Provider.of<UserApiProvider>(context, listen: false);

    titleController.text = widget.dataModel.title.toString();
    descriptionController.text = widget.dataModel.description.toString();
    subjectController.text = widget.dataModel.subject.toString();
    userApiProvider.taskAssignedAvtar = widget.dataModel.avatar??"";
    userApiProvider.taskAssignedEmail = widget.dataModel.email??"";
    userApiProvider.taskAssignedUser = widget.dataModel.assignedUserName??"";
    userApiProvider.taskAssignedId = widget.dataModel.assignedUserId??0;

  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme
        .of(context)
        .colorScheme;

    var userApiProvider = Provider.of<UserApiProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: theme.primary),
        title: Text(
          'Update Your Todo',
          style: TextStyle(color: theme.primary, fontSize: 16,fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                view.sizedBoxView(height: 40),
                view.textFormFieldView(
                  controller: titleController,
                  hintText: 'Enter Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                view.sizedBoxView(height: 15),
                view.textFormFieldView(
                  controller: descriptionController,
                  hintText: 'Enter Description',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                view.sizedBoxView(height: 15),
                view.textFormFieldView(
                  controller: subjectController,
                  hintText: 'Enter Subject',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                view.sizedBoxView(height: 15),
                Consumer<TodoProviderController>(builder: (context, value, child) => InkWell(
                  onTap: () async{
                    await value.openDatePicker(context);
                    datePickerController.text = value.selectedStringDate;
                  },
                  child: view.textFormFieldView(
                    enabled:false ,
                    controller: datePickerController,
                    hintText: 'Pick a date',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Pick a date';
                      }
                      return null;
                    },
                  ),
                ),),
                view.sizedBoxView(height: 15),
                Container(
                  width: context.screenWidth-20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: theme.background,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Consumer<TodoProviderController>(
                    builder: (context, provider, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Task Status       ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Expanded(
                              child: PopupMenuButton<int>(
                                itemBuilder: (context) => provider.statusOptions.map((value) => PopupMenuItem<int>(child: Padding(
                                  padding:  EdgeInsets.only(right: context.screenWidth-250),
                                  child: Text(value,),
                                ),value: provider.statusOptions.indexOf(value),),).toList(),
                                offset: const Offset(0, 50),
                                elevation: 2,
                                onSelected:(index){

                                  provider.updateSelectedStatus(index);

                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border:  Border.all(color: theme.tertiary.withOpacity(0.4),width: 1.3)),
                                  child: Center(child: Text(provider.selectedStatus)),
                                ),
                              ),
                            ),
                            view.sizedBoxView(width: 10,)
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: context.screenWidth-20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: theme.background,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Consumer<TodoProviderController>(
                    builder: (context, provider, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Task Priority       ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Expanded(
                              child: PopupMenuButton<int>(
                                itemBuilder: (context) => provider.priorityOptions.map((value) => PopupMenuItem<int>(child: Padding(
                                  padding:  EdgeInsets.only(right: context.screenWidth-250),
                                  child: Text(value,),
                                ),value: provider.priorityOptions.indexOf(value),),).toList(),
                                offset: const Offset(0, 50),
                                elevation: 2,
                                onSelected:(index){
                                  provider.updatePriorityStatus(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border:  Border.all(color: theme.tertiary.withOpacity(0.4),width: 1.3)),
                                  child: Center(child: Text(provider.selectedPriority)),
                                ),
                              ),
                            ),
                            view.sizedBoxView(width: 10,)
                          ],
                        ),
                      );

                    },
                  ),
                ),
                view.sizedBoxView(height: 40),
                Container(
                  width: context.screenWidth-20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: theme.background,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Consumer<UserApiProvider>(
                    builder: (context, provider, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Assign Task To  ",style: TextStyle(fontWeight: FontWeight.bold),),
                            provider.isLoading? Center(child: CircularProgressIndicator(),)
                                : provider.error != null
                                ?  Text("User List Empty")
                                :provider.apiResponse != null
                                ? Expanded(
                              child: PopupMenuButton<int>(
                                itemBuilder: (context) => provider.apiResponse!.users.map((value) => PopupMenuItem<int>(child: Padding(
                                  padding:  EdgeInsets.only(right: context.screenWidth-250),
                                  child: Text("${value.fullName}",),
                                ),value: provider.apiResponse!.users.indexOf(value),),).toList(),
                                offset: const Offset(0, 50),
                                elevation: 2,
                                onSelected:(index){
                                  provider.updateAssignUser(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border:  Border.all(color: theme.tertiary.withOpacity(0.4),width: 1.3)),
                                  child: Center(child: Text(provider.taskAssignedUser)),
                                ),
                              ),
                            ) : Container(),
                            view.sizedBoxView(width: 10,)
                          ],
                        ),
                      );

                    },
                  ),
                ),
                view.sizedBoxView(height: 40),
                Consumer<TodoProviderController>(
                  builder: (BuildContext context, TodoProviderController value,
                      Widget? child) {
                    return value.loading
                        ? const Center(child: CircularProgressIndicator(),)
                        : view.elevatedButtonView(
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                          await  value.updateTodo(widget.index ,TodoModel(
                            title: titleController.text.capitalize,
                            subject: subjectController.text.capitalize,
                            description: descriptionController.text.capitalize,
                            status: value.selectedStatus,
                            deadline: DateTime.parse(value.selectedStringDate),
                            assignedUserId: userApiProvider.taskAssignedId,
                            assignedUserName: userApiProvider.taskAssignedUser,
                            priority: value.selectedPriority,
                            avatar: userApiProvider.taskAssignedAvtar,
                            email: userApiProvider.taskAssignedEmail,
                            id: widget.dataModel.id
                          ));

                          titleController.clear();
                          subjectController.clear();
                          descriptionController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Task Added Successfully")));
                          view.nextScreenPushReplacement(
                              context: context,
                              screen: const ViewTodoScreen());
                        }
                      },
                      child: const Text("Update Now",style: TextStyle(color: Colors.white),),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //
  //   var theme = Theme.of(context).colorScheme;
  //   DateTime now = DateTime.now();
  //   String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  //   return Scaffold(
  //     backgroundColor: theme.background,
  //     appBar: AppBar(
  //       iconTheme: IconThemeData(color: theme.primary),
  //       title:  Text(
  //         'Update Your Todo',
  //         style: TextStyle(color: theme.primary, fontSize: 16,fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             view.sizedBoxView(height: 40),
  //             view.textFormFieldView(
  //                 controller: titleController, hintText: 'Enter Title'),
  //             view.sizedBoxView(height: 15),
  //             view.textFormFieldView(
  //                 controller: descriptionController, hintText: 'Enter Description'),
  //             view.sizedBoxView(height: 15),
  //             view.textFormFieldView(
  //                 controller: subjectController,
  //                 hintText: 'Enter Subject'),
  //             view.sizedBoxView(height: 15),
  //
  //             view.sizedBoxView(height: 40),
  //             Consumer<TodoProviderController>(
  //               builder: (BuildContext context, provider, Widget? child) {
  //                 return view.elevatedButtonView(
  //                     onPressed: () {
  //                       var taskStatus = "Progress";
  //                       provider.updateTodo(widget.index,TodoModel(
  //                         title: titleController.text.capitalize,
  //                         description: descriptionController.text.capitalize,
  //                         subject: subjectController.text.capitalize,
  //                         status: taskStatus,
  //                         id: widget.dataModel.id
  //                       ));
  //                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated Successfully")));
  //                       Navigator.pop(context);
  //                       // provider.toggleCheckBoxValue(false);
  //
  //                     },
  //                     child: const Text("Save Now", style :TextStyle(color: Colors.white),));
  //               },
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
