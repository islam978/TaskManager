import 'package:flutter/material.dart';
import 'package:todos/core/constant/color.dart';

class CustomRadioButton extends StatelessWidget {
  final Object? initalVal;
  final int value;
  final String text;
  final Function(Object?)? onPress;
  const CustomRadioButton({super.key, this.initalVal, required this.onPress, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Radio(
        value: value,
        groupValue: initalVal,
        onChanged: onPress,

        activeColor: AppColor.primaryColor,
      ),
    );
  }
}
