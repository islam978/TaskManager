import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todos/core/constant/color.dart';
import 'package:todos/providers/home_provider.dart';
import 'package:todos/providers/viewtasks_provider.dart';
import 'package:todos/screens/splash_screen.dart';
import 'package:todos/widgets/taskcard.dart';

import '../data/models/todomodel.dart';
import '../widgets/buildtaskview.dart';
import '../widgets/errorDialog.dart';

class ViewTasks extends StatefulWidget {
  const ViewTasks({super.key});

  @override
  State<ViewTasks> createState() => _ViewTasksState();

}

class _ViewTasksState extends State<ViewTasks> {

  @override
  void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  var home  = Provider.of<Home>(context, listen: false);
  home.initalDataAllTask();


  });
  }

  @override
  Widget build(BuildContext context) {

   return BuildTaskView();

  }
}
