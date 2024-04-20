import 'package:flutter/material.dart';
import 'package:todos/core/constant/apptheme.dart';

import '../core/constant/color.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading ...',style: TextStyle(fontSize: 15,color: AppColor.bluishClr,fontWeight: FontWeight.bold),),
      ),
    );
  }
}

