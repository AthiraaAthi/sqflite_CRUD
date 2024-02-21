import 'package:flutter/material.dart';
import 'package:sqflite_selfff/controller/my_controller.dart';
import 'package:sqflite_selfff/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyController.initializedb();

  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
