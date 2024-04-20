import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class ErrorDialog extends StatelessWidget {
   final double size;
  const ErrorDialog({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
     return SizedBox(
    height: 180,
    width: 200,
    child:  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('An error occurred when fetching the posts.',
    style: TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: Colors.black
    ),
    ),
    const SizedBox(height: 10,),
    Consumer<Home>(builder: (_,home,__)=>
     TextButton(
         child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.purpleAccent),),
      onPressed:  ()  {
      home.retryGetData();


      }))



],
),
);;
  }
}
