// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todoapp/export_all.dart';

class ApiService {
  Map<String, String>? reqData;
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
      //     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      // // Now you can use your decoded token
      // // print(decodedToken);
      // userId = decodedToken["_id"];

      // ApiService().reqData = {
      //   "userId": jsonResponse['userId'].toString(),
      // };
      Data.userDetail = User.fromJson(jsonResponse['user']);
      userId = Data.userDetail!.sId!;
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/HomeScreen', (Route<dynamic> route) => false);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonResponse['message']),
        ),
      );
    }
  }

  // ignore: todo
  //ADD TODO API
  static Future<TodoModule?> addTodoApi(
      Map<String, String> reqData, BuildContext context) async {
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

      TodoModule item = TodoModule.fromJson(jsonResponse['success']);
      return item;
    } else {
      Navigator.of(context)
        ..pop()
        ..pop();

      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<dynamic>> getTodoList() async {
    final response = await http.post(Uri.parse('$apiUrl/getTodosList'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == 200 && jsonResponse['success']) {
      // List todoList = [];

      return jsonResponse['todos'].map((e) => TodoModule.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<bool> deteteTodoApi(String todoId, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: spinkit,
        onWillPop: () async {
          return false;
        },
      ),
    );
    final response = await http.post(Uri.parse('$apiUrl/deleteTodo'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": todoId}));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == 200 && jsonResponse['success']) {
      // Navigator.of(context).pop();
      Navigator.of(context)
        ..pop();
      return jsonResponse['success'];
    } else {
      // ignore: avoid_single_cascade_in_expression_statements
      // Navigator.of(context)..pop();

      throw Exception(response.reasonPhrase);
    }
  }

  static Future<TodoModule?> updateTodo(Object item) async {
    final response = await http.patch(Uri.parse('$apiUrl/updateTodo'),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(item));
    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == 200 && jsonResponse['success']) {
      return TodoModule.fromJson(jsonResponse['todo']);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
