

import 'package:flutter/material.dart';
import 'package:todos/data/datasource/remote/tasks_data.dart';

class ViewTasksProvider extends ChangeNotifier{


  List Tasks =[];

  int currentIndex = 0;

  getTasks (int currentIndex,int skip) async{
     var responseData  =await TasksData().getTasks(currentIndex, skip);
     if(responseData["error"] != null){

     }
     else{
       Tasks.addAll(responseData);
     }
  }


}