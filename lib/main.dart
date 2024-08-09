import 'package:appscrip_assignment/controllers/provider_controller/user_auth_provider.dart';
import 'package:appscrip_assignment/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/api_provider/user_api_provider.dart';
import 'controllers/database_controller/database_helper_controller.dart';
import 'controllers/provider_controller/theme_controller.dart';
import 'controllers/provider_controller/todo_provider_controller.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider<TodoProviderController>(create: (context) => TodoProviderController(),),
      ChangeNotifierProvider<UserApiProvider>(create: (context) => UserApiProvider(),),
      ChangeNotifierProvider<UserAuthProvider>(create: (context) => UserAuthProvider(),),
      ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider(),),

    ],child:  MyApp(),),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   Future.delayed(Duration(seconds: 2),() =>  Provider.of<UserApiProvider>(context, listen: false).fetchUsers());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SplashScreen(),
    );
  }
}

