import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/core/constant/apptheme.dart';
import 'package:todos/core/functions/checkinternet.dart';
import 'package:todos/widgets/taskcard.dart';

import '../core/constant/color.dart';
import '../data/models/todomodel.dart';
import '../providers/home_provider.dart';
import 'errorDialog.dart';

class BuildTaskView extends StatelessWidget {
  const BuildTaskView({super.key});

  @override
  Widget build(BuildContext context) {
   return Consumer<Home>(
        builder: (_,home,__) {
          if (home.tasks.isEmpty) {
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


     child:
        ListView.builder(


          //  controller: _scrollController,

            itemCount: home.tasks.length + (home.isLastPage ? 0 : 1) ,
            itemBuilder: (BuildContext context, int index) {
              if (index == home.tasks.length-1  && !home.isLastPage  ) {
                home.loading = true;
                home.getTasks(home.numberOfPostsPerRequest, home.tasks[index].id!);
              }
              if (index == home.tasks.length) {
                if (home.error) {
                  return Center(
                      child: ErrorDialog(size:15)
                  );
                }
                else {
                  return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(color:AppColor.bluishClr,),
                      ));
                }
              }

              final TodoModels task = home.tasks[index];
              return TaskCard(todo: task);
              // }

            }

        ),

    );}
    );
  }
}
