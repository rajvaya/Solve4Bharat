import 'package:flutter/material.dart';
import 'package:solve4bharat_vaani/SpeechModule.dart';
import 'package:solve4bharat_vaani/dashboard.dart';
import 'package:solve4bharat_vaani/login.dart';
import 'package:solve4bharat_vaani/prescriptionscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}
