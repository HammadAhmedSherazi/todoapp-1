import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:todoapp/export_all.dart';

class ApiService {
  //REGISTRATION API
  static registrationApi(
      Map<String, String> reqData, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => spinkit,
    );
    final response = await http.post(Uri.parse('$apiUrl/registration'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqData));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status']) {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
        ..pop()
        ..pop();
    }
  }

  //LOGIN API
  static loginApi(Map<String, String> reqData, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: spinkit,
        onWillPop: () async {
          return false;
        },
      ),
    );
    final response = await http.post(Uri.parse('$apiUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqData));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status']) {
      token = jsonResponse['token'];
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/HomeScreen', (Route<dynamic> route) => false);
    }
  }

  // ignore: todo
  //ADD TODO API

  static addTodoApi(Map<String, String> reqData, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: spinkit,
        onWillPop: () async {
          return false;
        },
      ),
    );
    final response = await http.post(Uri.parse('$apiUrl/saveTodo'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqData));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status']) {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
        ..pop()
        ..pop();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/HomeScreen', (Route<dynamic> route) => false);
    }
  }

  static getTodoList(Map<String, String> reqData, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: spinkit,
        onWillPop: () async {
          return false;
        },
      ),
    );
    final response = await http.post(Uri.parse('$apiUrl/getTodosList'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqData));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == 200 && jsonResponse['success']) {
      todoList.clear();
      for (var i = 0; i < jsonResponse['todos'].length; i++) {
        // var lst = jsonDecode(jsonResponse['todos']);
        TodoModule item = TodoModule.fromJson(jsonResponse['todos'][i]);
        todoList.add(item);
      }
      Navigator.of(context).pop();
      
      // ignore: use_build_context_synchronously
    }
  }
}
