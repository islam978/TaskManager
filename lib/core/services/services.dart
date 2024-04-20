import 'dart:js';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/auth_provider.dart';
import '../functions/checkinternet.dart';

class MyServices {
  late SharedPreferences sharedPreferences;
  initalData()async{
    sharedPreferences =  await SharedPreferences.getInstance();
    //sharedPreferences.get('userData')??;
    if(await checkInternet()){

    }
    else{

    }

  }

}