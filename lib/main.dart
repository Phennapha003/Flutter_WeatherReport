import 'package:flutter/material.dart';
import 'package:flutter_application_w7/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey).copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 139, 213, 247)),
      home: const Home(),
    );
  }
}
