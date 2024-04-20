
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/widgets/buildtaskview.dart';

import '../data/models/todomodel.dart';
import '../providers/auth_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/errorDialog.dart';
import '../widgets/taskcard.dart';

class MyTask extends StatefulWidget {
  const MyTask({super.key});

  @override
  State<MyTask> createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var home  = Provider.of<Home>(context, listen: false);
      home.initalDataMyTask(Provider.of<Auth>(context, listen: false).userId);
    });
  }
  @override
  Widget build(BuildContext context) {
     return Consumer<Home>(
        builder: (_,home,__) {
          if (home.myTask.isEmpty) {
            if (home.loading) {
              return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ));
            } else if (home.error) {
              return Center(
                  child: ErrorDialog(size: 20)
              );
            }
          }
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                //  controller: _scrollController,

                  itemCount: home.myTask.length  ,
                  itemBuilder: (BuildContext context, int index) {


                    final TodoModels task = home.myTask[index];
                    return TaskCard(todo: task);
                    // }

                  }

              ));}
    );;
  }
}
