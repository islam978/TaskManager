import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/core/constant/apptheme.dart';

import '../core/constant/color.dart';
import '../core/constant/routes.dart';
import '../providers/home_provider.dart';
import '../widgets/custombottomappbar.dart';
import 'addtask_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<Home>(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(home.currentPage == 0?"Tasks":"MyTask")),
        backgroundColor: AppColor.bluishClr,
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      floatingActionButton:FloatingActionButton(backgroundColor:  AppColor.bluishClr,
        onPressed: (){
          Navigator.of(context).pushNamed(AppRoute.addTask);
        },
        child: const Icon(Icons.add,),

      ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: home.page[home.currentPage],
    );
  }
}
