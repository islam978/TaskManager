import 'package:flutter/material.dart';
import 'package:todos/core/constant/color.dart';

import '../core/constant/apptheme.dart';
import '../core/constant/size_config.dart';


class InputField extends StatelessWidget {
  final String  ?title;
  final String ? hint;
  final Widget ? widget;
  final TextEditingController  ?controller;

  const InputField({Key? key,this.title,this.hint,this.widget,this.controller}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children:[

        Text(title!,style: titleStyle.copyWith(color: AppColor.bluishClr),),
        Container(
          width:SizeConfig.screenWidth,
          height: 40,
          padding: EdgeInsets.only(left: 14),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey
            )
          ),
          child: Row(children: [
          Expanded(
            child: TextFormField(
                controller: controller,
                autofocus: false,
                style: subTitleStyle,
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  hintText: hint,

                  hintStyle: subTitleStyle.copyWith(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.grey),
                  enabledBorder:UnderlineInputBorder(
                      borderSide:BorderSide(
                        color: Colors.white,
                            width:0,

                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:BorderSide(
                          color:Colors.white
                      )
                  ),

                ),

                readOnly: widget!=null?true:false,
              ),
          ),
            widget ?? Container(),
      ]
          ),
        )

        ]
      ),
    );
  }
}
