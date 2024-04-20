import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../linkapi.dart';

class TasksData {
Future getTasks (int limit ,int skip ) async {
  try {
    final res = await http.get(
        Uri.parse(AppLink.todos+"limit=$limit&skip=$skip"),

        headers: <String, String>{'Content-Type': 'application/json'}
    );
    Map responseData = json.decode(res.body);
    print(responseData);

    if (responseData["error"] != null) {
      // HttpException(responseData["error"]["message"]);
      // throw "${responseData["error"]["message"]}";
    }

    return responseData;
    // notifyListeners();

  }
  catch (e) {
    print(e);
    return e;
    throw(e);
  }
}


Future getMyTask (int userId ) async {
  try {
    final res = await http.get(
        Uri.parse(AppLink.myTodo+"$userId"),

        headers: <String, String>{'Content-Type': 'application/json'}
    );
    Map responseData = json.decode(res.body);
    print(responseData);

    if (responseData["error"] != null) {
      // HttpException(responseData["error"]["message"]);
      // throw "${responseData["error"]["message"]}";
    }

    return responseData;

  }
  catch (e) {
    print(e);
    return e;
    throw(e);
  }
}


Future deleteTask (int todoId ) async {
  try {
    final res = await http.delete(
        Uri.parse(AppLink.deleteTodos+"${todoId}"),

        headers: <String, String>{'Content-Type': 'application/json'}
    );
    Map responseData = json.decode(res.body);
    print(responseData);

    if (responseData["error"] != null) {
      // HttpException(responseData["error"]["message"]);
      // throw "${responseData["error"]["message"]}";
    }

    return responseData;


  }
  catch (e) {
    print(e);
    return e;
    throw(e);
  }
}

Future updateTask (int todoId ,bool completed) async {
  try {
    final res = await http.put(
        Uri.parse(AppLink.updateTodo+"${todoId}"),
      headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode({"completed":completed}),

    );
    Map responseData = json.decode(res.body);
    print(responseData);

    if (responseData["error"] != null) {
      // HttpException(responseData["error"]["message"]);
      // throw "${responseData["error"]["message"]}";
    }

    return responseData;


  }
  catch (e) {
    print(e);
    return e;
    throw(e);
  }
}

Future addTask (Map data) async {
  try {
    final res = await http.post(
        Uri.parse(AppLink.addTodos),
        body: json.encode(data),

        headers: <String, String>{'Content-Type': 'application/json'}
    );
    Map responseData = json.decode(res.body);
    print(responseData);

    if (responseData["error"] != null) {
      // HttpException(responseData["error"]["message"]);
      // throw "${responseData["error"]["message"]}";
    }

    return responseData;


  }
  catch (e) {
    print(e);
    return e;
    throw(e);
  }
}
}