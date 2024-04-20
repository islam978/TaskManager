import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
 import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';
import 'package:todos/data/models/todomodel.dart';


import '../data/models/task.dart';
import '../data/models/usermodel.dart';
import '../linkapi.dart';



class Auth extends ChangeNotifier{
  String ?_token ;
  int ?_userId;
  bool loading = false;
  String ?_imageUrl;
  bool  get  isAuth{
    return _token !=null ;
  }
  String get token{
    if( _token != null) {
      return _token!;
    }
    return "null";
  }

  int get userId {
    return _userId!;
  }
  String get imageUrl {
    return _imageUrl!;
  }
  Future<void> authenticate (String username,String password, String urlSegment) async{

    try{
      final res =  await http.post(Uri.parse(AppLink.login),body: json.encode({
        'username': username, 'password': password
       // "returnSecureToken":true
      }),
          headers: <String, String>{'Content-Type': 'application/json'}
      );
      Map<String, dynamic> responseData =  json.decode(res.body);
         print(responseData);
      UserModel user = UserModel.fromJson(responseData);
      _token = user.token;
      if(responseData["error"] != null){
       // HttpException(responseData["error"]["message"]);
       // throw "${responseData["error"]["message"]}";
      }

      final prefs =  await SharedPreferences.getInstance();
     // final  String userData = json.encode(responseData.map((key, value) => data.));
      final  String userData = json.encode(user);
      print(userData);
      prefs.setString('userData',userData);

      //autoLogin();
       //autoLogout();
      notifyListeners();

    }
    catch(e){
      print(e);
      throw(e);
    }

  }

  Future <void> login(String username,String password) async{
    await authenticate(username, password, "signInWithPassword");
  }

  Future <bool> autoLogin() async{
    print("here");
    loading= true;
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')){
      loading = false;
      return false;
    }
    final  extractData =json.decode(prefs.getString('userData')!);
     print("here2");
    _userId =extractData['id'];
    _token = extractData['token'];
    _imageUrl = extractData['image'];
    print(_imageUrl);





    notifyListeners();
    return true;

  }
 /** void logout(){
    _token = null;
    _userId = null;
    _expireDate= null;
    if(_authTimer != null){
      _authTimer!.cancel;
      _authTimer = null;
    }
    notifyListeners();
  }*/
  /*void autoLogout() {
    if(_authTimer != null){
      _authTimer!.cancel;
    }
    final timeToExpiry = _expireDate!.difference(DateTime.now()).inSeconds;
    _authTimer =Timer( Duration(seconds: timeToExpiry),logout);

  }*/


}