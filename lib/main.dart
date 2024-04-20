import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/providers/addtask_provider.dart';
import 'package:todos/providers/auth_provider.dart';
import 'package:todos/providers/home_provider.dart';
import 'package:todos/providers/viewtasks_provider.dart';
import 'package:todos/routes.dart';
import 'package:todos/screens/auth_screen.dart';

import 'package:todos/screens/home_screen.dart';
import 'package:todos/screens/splash_screen.dart';


void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value:Auth()),
       ChangeNotifierProvider.value(value:Home()),
      ChangeNotifierProvider.value(value:ViewTasksProvider()),
        ChangeNotifierProvider.value(value:AddTaskProvide()),
        /*ChangeNotifierProxyProvider<Auth,Products>(
          create: (_)=>Products(),
          update: (ctx,authValue,previousProducts)=>previousProducts..getData(
              authValue.token,
              authValue.userId,
              previousProducts == null ?null:previousProducts.productsList),
        ),*/
        //ChangeNotifierProvider.value(value:Orders()),


      ],
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        //initialRoute: '/',
        home:
        //HomeScreen()
        Consumer<Auth>(
          builder:(_,data,__)=>
       data.isAuth?HomeScreen() :
    FutureBuilder(future: data.autoLogin(),
    builder: (ctx,snapshot) {
     if( data.loading){
        return SplashScreen();

      }
      else {
        return AuthScreen();
      }
    })),routes:routes

    );
  }
}

