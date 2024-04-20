

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../data/datasource/remote/tasks_data.dart';
import 'home_provider.dart';

class AddTaskProvide extends ChangeNotifier{

  bool loading = false;
  int initalValueRadio = -1;
  Map data ={};
  TextEditingController task = TextEditingController();

  cahngeChoice( Object choice){
    initalValueRadio = choice as int;
    notifyListeners();
  }

  Future<void>addTasks (Map data ) async{
    //initalValueRadio = choice as int;
    loading = true;
    notifyListeners();
    var responseData  =await TasksData().addTask(data);
    if(responseData["message"] != null){

    }
    else{
      print(responseData);
     // tasks.removeWhere((element) => element.id == todoId);
      notifyListeners();
    }
  }
}