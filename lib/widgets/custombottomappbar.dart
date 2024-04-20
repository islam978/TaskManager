
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/core/constant/apptheme.dart';



import '../providers/home_provider.dart';
import 'custombuttonappbar.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({super.key});




  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}


class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {

 final home =Provider.of<Home>(context);


    return  BottomAppBar(


          shape:const  CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            children: [
            ...List.generate(home.page.length ,((index){
              // int i = index>2?(index-1):index;

             // return (index==2)? const Spacer():
              return Expanded(
                child: Container(
                //   color :home.currentPage == (index)?bluishClr:Colors.white,
                  child: CustomButtonAppBar(
                    onPressed:() {
                      home.changePage(index);
                    },
                    activeColor: index>1
                      ?home.currentPage == (index):
               home.currentPage == (index),
                    title: home.bottomAppBar[index]["title"],
                    ),
                ),
              );
            })),


            ],

          ));

  }
}
