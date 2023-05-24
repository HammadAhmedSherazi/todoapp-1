import 'package:flutter/material.dart';

import 'export_all.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  
  builder: (ctx, child) {
    ScreenUtil.init(ctx);
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 30.sp)),
      ),
      child: const Center(
        child: Text('Todo App'),
      ),
    );
  },
);
  }
}

