

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos/core/functions/checkinternet.dart';
import 'package:todos/screens/mytask.dart';
import 'package:todos/screens/viewtasks.dart';

import '../data/datasource/remote/tasks_data.dart';
import '../data/models/todomodel.dart';


class Home extends ChangeNotifier{
 bool isLoading = false;

  int currentPage =0;

  int totalTask =0;

 List<TodoModels> tasks =[];
 List<TodoModels> myTask =[];
  int currentIndex = 0;
  bool isLastPage = false;
  SharedPreferences ?sharedPreferences;
  int pageNumber =0;
  bool loading = true;
  bool error = false;
  int limited = 10;

 int numberOfPostsPerRequest =10;
  var initalValueRadio = -1;

  ScrollController scrollController = ScrollController();
  List bottomAppBar = [
    {"title": "All Tasks "},
    {"title": "My Task "},
  ] ;


  List page = [
    const ViewTasks(),
    const MyTask(),
  ];


  changePage(index){

    currentPage = index;
   notifyListeners();
  }



  getTasks (int limit,int skip) async{
  if(await checkInternet()) {
    loading = true;
    var responseData = await TasksData().getTasks(limit, skip);
    try {
      List listdata = responseData['todos'];
      totalTask = responseData['total'];
      isLastPage = listdata.length < numberOfPostsPerRequest;
      pageNumber = pageNumber + 1;
      tasks.addAll(listdata.map((e) => TodoModels.fromJson(e)));
      loading = false;
      sharedPreferences = await SharedPreferences
          .getInstance();
      sharedPreferences!.setString("todos", json.encode(tasks));
      notifyListeners();
    } catch (e) {
      print("error --> $e");

      loading = false;
      error = true;
    }
  }
  else{
   tasks =[];
 sharedPreferences = await SharedPreferences.getInstance();
 List extractData = json.decode(sharedPreferences!.getString("todos")!);

 if(extractData.isNotEmpty){
   tasks.addAll(extractData.map((e) => TodoModels.fromJson(e)));
   notifyListeners();
 }
  }
  }


 getMyTask (int userId) async{
   loading = true;
   var responseData = await TasksData().getMyTask(userId);
   try{
     List listdata = responseData['todos'];
     myTask.addAll(listdata.map((e) => TodoModels.fromJson(e)));
     loading = false;
     notifyListeners();
   }catch(e){
     print("error --> $e");
     loading = false;
     error = true;
   }

 }



   deleteTasks (int todoId) async{
     tasks.removeWhere((element) => element.id == todoId);

     myTask.removeWhere((element) => element.id == todoId);
   //loading = true;
   notifyListeners();
   var responseData  =await TasksData().deleteTask(todoId);
   if(responseData["message"] != null){
   }
   else{
     loading = false;
     notifyListeners();
   }
 }

   cahngeChoice( Object choice){
     initalValueRadio = choice as int;
     notifyListeners();
   }

   Future<void>updateTasks (int todoId,bool completed) async{
     /*tasks.firstWhere((element) {
       if(element.id == todoId){
         element.completed =
       }
     } )*/
   loading = true;
   notifyListeners();
   var responseData  =await TasksData().updateTask(todoId,completed);
   print(responseData);
   if(responseData["message"] != null){

   }
   else{
    // tasks.removeWhere((element) => element.id == todoId);
     notifyListeners();
   }
 }
   void retryGetData(){
   loading = true;
   error = false;
   getTasks(10, tasks.length);
 }
 initalDataAllTask(){
   pageNumber = 0;
   isLastPage = false;
   loading = true;
    error = false;
    totalTask =0;
    tasks =[];
    getTasks(10, 0);
    notifyListeners();
 }

 initalDataMyTask(int userId){
   loading = true;
   error = false;
   totalTask =0;
   myTask=[];
   getMyTask(userId);
   notifyListeners();
 }
}