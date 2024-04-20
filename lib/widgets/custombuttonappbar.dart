
import 'package:flutter/material.dart';
import 'package:todos/core/constant/apptheme.dart';

import '../../../core/constant/color.dart';

class CustomButtonAppBar extends StatelessWidget {

  final String title;
  final void Function()? onPressed ;
  final bool activeColor;
  const CustomButtonAppBar({super.key,
     this.onPressed, required this.activeColor,  required this.title});

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      onPressed: (){},child: Column(
      mainAxisSize: MainAxisSize.min,
      children:  [
       /* IconButton(onPressed: onPressed, icon:Icon(iconData,
          color:activeColor ? AppColor.primaryColor : AppColor.grey2,
    )),*/
       TextButton(onPressed: onPressed,
           child: Text(title,style:TextStyle(
             color: AppColor.bluishClr,
           ),),
         ),


      ],),);
  }
}
