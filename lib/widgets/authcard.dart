
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class AuthCard extends StatefulWidget  {
  const AuthCard({
    Key ?key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {

  final GlobalKey<FormState> _formKey = GlobalKey();
 // AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(begin:Offset(0,-0.15),end:Offset(0,0)).animate(
        CurvedAnimation(parent: _controller,
            curve: Curves.fastOutSlowIn
        )
    );
    _opacityAnimation = Tween<double>(begin:0.0,end:1.0).animate(
        CurvedAnimation(parent: _controller,
            curve: Curves.easeIn
        )
    );

  }


  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
     // if (_authMode == AuthMode.Login) {
        // Log user in


        await Provider.of<Auth>(context, listen: false).login(
            _authData["username"]!, _authData["password"]!);

    }
    on HttpException catch (e) {
      var errorMessage = "Authentication Failed";
      if (e.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address is already in use";
      } else if (e.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This is not a valid email address";
      } else if (e.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This password is too weak";
      } else if (e.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "could not find a user with that email";
      } else if (e.toString().contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid password";
      }
      _showErrorDialog(errorMessage);
    }
    catch(error){
      var errorMessage = 'Could not authenticate you,Please try again later';
      _showErrorDialog(errorMessage);

    }

    setState(() {
      _isLoading = false;
    });
  }


  void _showErrorDialog(String message) {
    showDialog(context: context, builder: (ctx) {
      return AlertDialog(
        title: const Text("An Error Occurred"),
        content: Text(message),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("Okay"))
        ],);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeIn,
        child: Container(
          height:  260,
          constraints:
          BoxConstraints(minHeight:  260),
          width: deviceSize.width * 0.75,
          padding:  const EdgeInsets.all(16.0),   ////////300
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty ) {
                        return 'Invalid username!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['username']= value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),

                      child:
                      Text( 'LOGIN' ),
                      onPressed: _submit,

                       padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme
                          .of(context)
                          .colorScheme.primary,
                      textColor: Colors.white
                      /*Theme
                          .of(context)
                          .primaryTextTheme
                          .button
                          .color,*/
                    ),
                /*  TextButton(
                    child: Text(
                        '${_authMode == AuthMode.Login
                            ? 'SIGN UP'
                            : 'LOGIN'} INSTEAD'),
                    onPressed: _switchAuthMode,
                    //padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    /* textColor: Theme
                        .of(context)
                        .colorScheme
                        .primary,*/
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}