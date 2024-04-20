import 'package:flutter/material.dart';

import '../core/constant/apptheme.dart';
import '../core/constant/color.dart';


class MyButton extends StatelessWidget {
  final double width;
  final  String label;
    final void Function()? onTap;
   MyButton({Key? key,required this.label, required this.onTap, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    // ElevatedButton(onPressed: onTap, child: Text(label));
      InkWell(onTap:onTap,
        //onTap: onTap()
        child: Container(
      alignment: Alignment.center,
      width: width,
        height: 40,
      //  color: bluishClr,
        decoration:BoxDecoration(borderRadius: BorderRadius.circular(8),color:AppColor.bluishClr),
        child:Text(label,style: TextStyle(color: Colors.white),)));
  }
}
