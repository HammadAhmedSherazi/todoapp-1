import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todoapp/export_all.dart';

registrationApi(Map<String, String> reqData, BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) => spinkit,
  );
  final response = await http.post(Uri.parse('$apiUrl/registration'),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(reqData));

  final jsonResponse = jsonDecode(response.body);

  if (jsonResponse['status']) {
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
