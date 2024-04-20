import 'package:flutter/material.dart';
import 'package:todos/screens/addtask_screen.dart';
import 'package:todos/screens/home_screen.dart';


import 'core/constant/routes.dart';

Map<String, Widget Function(BuildContext)> routes = {
//  "/": (context) => AuthScreen(),

  //Auth
  AppRoute.home: (context) => const HomeScreen(),
  AppRoute.addTask: (context) => const AddTaskPage(),

};