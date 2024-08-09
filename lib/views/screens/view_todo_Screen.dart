import 'package:appscrip_assignment/controllers/api_provider/user_api_provider.dart';
import 'package:appscrip_assignment/controllers/provider_controller/user_auth_provider.dart';
import 'package:appscrip_assignment/views/screens/update_todo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../controllers/provider_controller/theme_controller.dart';
import '../../controllers/provider_controller/todo_provider_controller.dart';
import '../../models/to_do_response_model.dart';
import '../../models/todo_model.dart';
import '../../services/todo_api_services.dart';
import '../utils/widgets/app_widgets.dart';
import '../utils/widgets/drawer_widget.dart';
import 'add_todo_screen.dart';

class ViewTodoScreen extends StatefulWidget {
  const ViewTodoScreen({super.key});

  @override
  State<ViewTodoScreen> createState() => _ViewTodoScreenState();
}

var view = AppWidgets();

class _ViewTodoScreenState extends State<ViewTodoScreen> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    List<TodoModel> todoData = [];

    return Scaffold(
      backgroundColor: theme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTodoScreen(),));
        },
        child:  Icon(Icons.add,color: theme.secondary,),
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return CupertinoSwitch(
                applyTheme: true,
                 activeColor: theme.tertiary,
                focusColor: theme.tertiary,
                value: themeProvider.isDarkMode,
                onChanged: (value) => themeProvider.toggleTheme(),
              );
            },
          ),
          SizedBox(width: 20,)
        ],
        // leading:const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 8.0),
        //   child: Hero(
        //       tag: "app_logo",
        //   child: Image(image: AssetImage("assets/images/app_logo.png"),width: 40,height: 40,)),
        // ),
        // leadingWidth: 50,
        title: Text(
          'Your Todo List',
          style: TextStyle(color: theme.primary, fontSize: 16,fontWeight: FontWeight.bold),
        ),
      ),
      drawer: MyDrawer(),
      body: Consumer<TodoProviderController>(
        builder: (BuildContext context, provider, Widget? child) {
          var taskEmptyText = "Your ${provider.selectedFilterValue} task list is Empty";

          if(provider.filterTodoList.isNotEmpty) {
           todoData= provider.filterTodoList;
          } else if(provider.selectedFilterValue=="All")
          {
           todoData = provider.allTodoList;
          }else{
            todoData.clear();
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Filter    ",style: TextStyle(fontWeight: FontWeight.bold),),
                      PopupMenuButton<int>(
                        itemBuilder: (context) => provider.itemList.map((value) => PopupMenuItem<int>(child: Text(value,),value: provider.itemList.indexOf(value),),).toList(),
                        offset: const Offset(50, 50),
                        elevation: 2,
                        onSelected:(index){
                          provider.onFilterChange(index);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border:  Border.all(color: theme.tertiary.withOpacity(0.4),width: 1.3)),
                          child: Center(child: Text(provider.selectedFilterValue)),
                        ),
                      ),
                      view.sizedBoxView(width: 10,)
                    ],
                  ),
                ),
               Expanded(child:  (todoData.isEmpty)? Center(child:Text(taskEmptyText)):ListView.builder(
                 shrinkWrap: true,
                 physics: const BouncingScrollPhysics(),
                 itemCount: todoData.length,
                 itemBuilder: (context, index) {
                   if(todoData.isEmpty){
                     return Center(
                       child: Text("Task Not Available"),
                     );
                   }
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       decoration: BoxDecoration(border: Border.all(color: theme.tertiary.withOpacity(0.4),width: 1.3),borderRadius: BorderRadius.circular(8)),
                       child: PhysicalModel(
                         color: theme.secondary,
                         borderRadius: BorderRadius.circular(8),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("${todoData[index].status}",style: TextStyle(fontWeight: FontWeight.bold),),
                                   PopupMenuButton<int>(
                                     itemBuilder: (context) => [
                                       const PopupMenuItem(
                                         value: 1,
                                         child: Row(
                                           children: [
                                             Icon(Icons.edit),
                                             SizedBox(
                                               width: 10,
                                             ),
                                             Text(
                                               "Update",
                                             )
                                           ],
                                         ),
                                       ),
                                       const PopupMenuItem(
                                         value: 2,
                                         child: Row(
                                           children: [
                                             Icon(Icons.delete),
                                             SizedBox(
                                               width: 10,
                                             ),
                                             Text(
                                               "Delete",
                                             )
                                           ],
                                         ),
                                       ),
                                     ],
                                     offset: const Offset(0, 50),
                                     elevation: 2,
                                     onSelected: (value) {
                                       if (value == 1) {
                                        TodoApiServices().updateTodos(ToDoResponseModel(id: todoData[index].id,title: todoData[index].title, userId: todoData[index].assignedUserId,completed: todoData[index].status=="Done"?true:false)).then( (value) {
                                              if(value.id!=null){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTodoScreen(dataModel: todoData[index], index: index),));

                                              }
                                         });
                                       } else if (value == 2) {
                                          TodoApiServices().deleteTodo(todoData[index].id.toString()).then( (value) {
                                            Provider.of<TodoProviderController>(context, listen: false).deleteTodo(index, todoData[index].id).then((value) {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted Successfully")));
                                            },);
                                          },);

                                       }
                                     },
                                   ),
                                 ],
                               ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  view.getDataWidget('Title : ', todoData[index].title.toString(), context),
                                  view.getDataWidget('Description : ', todoData[index].description.toString(), context),
                                  view.getDataWidget('Subject : ', todoData[index].subject.toString(), context),
                                  view.getDataWidget('Status : ', "${todoData[index].status}", context),
                                  view.getDataWidget('Priority : ', "${todoData[index].priority}", context,isBold: true),
                                  ExpansionTile(title: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("Task is assign to ${todoData[index].assignedUserName}", style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                    children: [
                                      view.sizedBoxView(height: 20),
                                      Container(child: ClipRRect(child: Image.network(todoData[index].avatar.toString()), borderRadius: BorderRadius.circular(50),), height: 100,),
                                      view.sizedBoxView(height: 20),
                                      view.getDataWidget('User id: ', todoData[index].id.toString(), context),
                                      view.getDataWidget('User name: ', todoData[index].assignedUserName.toString(), context),
                                      view.getDataWidget('User email: ', todoData[index].email.toString(), context),

                                    ],

                                  )
                                ],
                                
                              )
                             ],
                           ),
                         ),
                       ),
                     ),
                   );
                 },
               ))
              ],
            ),
          );
        },
      ),
    );
  }
}
