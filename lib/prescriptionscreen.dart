import 'package:flutter/material.dart';
import 'package:solve4bharat_vaani/SizeConfig.dart';

class PrescriptionScreen extends StatefulWidget {
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Prescription"),
        centerTitle: true,
        backgroundColor: Colors.indigo[200],
      ),
    );
  }
}
