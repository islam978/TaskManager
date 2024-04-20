import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/core/constant/color.dart';
import 'package:todos/widgets/showdialog.dart';

import '../core/constant/routes.dart';
import '../data/models/todomodel.dart';
import '../providers/home_provider.dart';

class TaskCard extends StatelessWidget {
  final TodoModels todo;
  const TaskCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    Color color = AppColor
        .backgroundColors[Random().nextInt(AppColor.backgroundColors.length)];
    return Container(
      //color:  color,
      height: 100,
      child: Card(
        color: color,
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: ListTile(
                  leading: todo.completed!
                      ? Icon(
                          Icons.done,
                          color: AppColor.primaryColor,
                        )
                      : Icon(
                          Icons.access_time_rounded,
                          color: AppColor.primaryColor,
                        ),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CustomDialogTask(
                                  todo: todo,
                                ));
                      },
                    ),
                    Consumer<Home>(builder: (context, home, _) {
                      return IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          home.deleteTasks(todo.id!);
                        },
                      );
                    }),
                  ]),
                  title: Text(
                    todo.todo!,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    // style: TextStyle(fontSize: 20),
                  ),
                  subtitle: FittedBox(
                      fit: BoxFit.scaleDown, child: Text(todo.id.toString())),
                ))
          ],
        ),
      ),
    );
  }
}
