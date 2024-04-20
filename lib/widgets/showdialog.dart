import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/core/constant/color.dart';
import 'package:todos/data/models/todomodel.dart';
import 'package:todos/widgets/button.dart';
import 'package:todos/widgets/customradiobutton.dart';

import '../core/constant/apptheme.dart';
import '../providers/home_provider.dart';
class CustomDialogTask extends StatelessWidget {
   final TodoModels todo;
  const CustomDialogTask({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    int val = -1;
    return Dialog(child: Container(
      height: 200,
      width:100 ,
      padding: EdgeInsets.symmetric(vertical: 15),
      child:Consumer<Home>(
        builder: (_,home,__){
          home.initalValueRadio = todo.completed!?1:2;
          return Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("TaskNumber:",
                style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: AppColor.bluishClr)),
              Text("${todo.id!}",style:TextStyle(fontWeight: FontWeight.bold,color: AppColor.bluishClr))
            ],),
            CustomRadioButton(initalVal: home.initalValueRadio,
              text: "Completed",
              value: 1,
              onPress: (value){
              todo.completed = true;
              home.cahngeChoice(value!);},),
            CustomRadioButton(initalVal: home.initalValueRadio,
              text: "UnCompleted",
              value: 2,
              onPress: (value){
                todo.completed = false;
                home.cahngeChoice(value!);},),

          Consumer<Home>(

            builder: (_,home,__)=>MyButton(width: 100,label: "Save", onTap: (){
              home.updateTasks(todo.id!,todo.completed!);
              Navigator.of(context).pop();
            }),
          )
        ],);}
      )
    ),);
  }
}

