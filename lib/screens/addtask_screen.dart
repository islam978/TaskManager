import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:todos/providers/addtask_provider.dart';
import 'package:todos/widgets/customradiobutton.dart';
import '../core/constant/apptheme.dart';
import '../core/constant/color.dart';
import '../core/constant/size_config.dart';

import '../data/models/todomodel.dart';
import '../providers/auth_provider.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key ?key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bluishClr,
          title:Center(child: Center(child: Text("Add Task")),)),
      body:
         Consumer<AddTaskProvide>(
         builder:(_,add,__)=>
           Container(
             padding: EdgeInsets.symmetric(horizontal: 15),
             child: Column(
                children: [
                  SizedBox(height: 15,),
                  Container(

                    width: 100,
                    height: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(45)),
                    child: Image.network(Provider.of<Auth>(context,listen:false).imageUrl)),

                  
              //    CircleAvatar(backgroundImage: CachedNetworkImageProvider(Provider.of<Auth>(context).imageUrl ),radius: 40,),
                  SizedBox(height: 30,),
                  InputField(title: "Task",hint:"Enter text here" ,
                   controller: add.task,
                   // controller: _titleController,
                  ),
                  SizedBox(height: 10,),
                  CustomRadioButton(initalVal: add.initalValueRadio,
                    text: "Completed",
                    value: 1,
                    onPress: (value){
                     // todo.completed = true;
                      add.cahngeChoice(value!);},),
                  SizedBox(height: 5,),
                  CustomRadioButton(initalVal: add.initalValueRadio,
                    text: "UnCompleted",
                    value: 2,
                    onPress: (value){
                      add.cahngeChoice(value!);},),
                  SizedBox(height: 10,),
                  MyButton(
                    width: MediaQuery.of(context).size.width-20,

                      label: "Save", onTap: (){
                      if(add.initalValueRadio != -1 && add.task!="") {
                        print( Provider
                            .of<Auth>(context, listen: false)
                            .userId);

                        print(add.initalValueRadio);
                        print(add.task);
                        Map addTask = {
                          "todo": add.task.text,
                          "completed": add.initalValueRadio == 1?true:false,
                          "userId": Provider
                              .of<Auth>(context, listen: false)
                              .userId,


                        };
                        add.addTasks(addTask);
                      }
                      else{

                      }



                  }),







//


      ]  ),
           ),
         ),


    );


  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: (){

      },icon:Icon(Icons.arrow_back_ios),color: Colors.blue,),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        CircleAvatar(backgroundImage:AssetImage("images/person.jpeg"),radius: 18,),
        SizedBox(width:20)
      ],
    );
  }



}
