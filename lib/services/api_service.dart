import 'dart:convert';
import 'dart:developer';
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
      userId = jsonResponse['userId'].toString();
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

  Future<List<dynamic>> getTodoList() async {
    final response = await http.post(Uri.parse('$apiUrl/getTodosList'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId}));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == 200 && jsonResponse['success']) {
      // List todoList = [];

     
      
      return jsonResponse['todos'].map((e) => TodoModule.fromJson(e)).toList();
    }
    else{
      throw Exception(response.reasonPhrase);
    }
  }

  String endPoint = "https://jsonplaceholder.typicode.com/todos";

  Future<List<TodoModule>> getTodos() async{
    var response = await http.get(Uri.parse(endPoint));

    if(response.statusCode == 200){
      final List result = jsonDecode(response.body);
      return result.map((e) => TodoModule.fromJson(e)).toList();
    }
    else{
      throw Exception(response.reasonPhrase);
    }
  }
}


final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
