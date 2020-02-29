import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solve4bharat_vaani/SizeConfig.dart';
import 'package:solve4bharat_vaani/style.dart';
import 'package:toast/toast.dart';
import 'data.dart';

class PrescriptionScreen extends StatefulWidget {
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {

  var symptoms = TextEditingController();
  var diagnoses = TextEditingController();
  var medicine = TextEditingController();

  TextStyle apnastyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[500],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(DataObject.toString());
    diagnoses.text =  DataObject['diagnosis'].toString();
    medicine.text =  DataObject['medicine'].toString();
    symptoms.text =  DataObject['symptoms'].toString();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Name : " + PatientObject['data']['name'].toString(),style: apnastyle),
              Text("Gender : " + PatientObject['data']['gender'].toString(),style: apnastyle,),
              Text("Date of Birth : " + PatientObject['data']['dob'].toString(),style: apnastyle,),
              Text("Email : " + PatientObject['data']['email'].toString(),style: apnastyle,),
              Text("Phone : " + PatientObject['data']['phone'].toString(),style: apnastyle,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: TextField(
                      controller: symptoms,
                      decoration: InputDecoration(
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          labelText: "symptoms",
                          labelStyle: inputlableStyle,
                          border: OutlineInputBorder(),
                          hintText: " ")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: TextField(
                      controller: diagnoses,
                      decoration: InputDecoration(
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          labelText: "Diagnosis",
                          labelStyle: inputlableStyle,
                          border: OutlineInputBorder(),
                          hintText: " ")),
                ),

              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: TextField(
                      controller: medicine,
                      decoration: InputDecoration(
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          labelText: "medicine",
                          labelStyle: inputlableStyle,
                          border: OutlineInputBorder(),
                          hintText: " ")),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(

           onPressed: (){
             Toast.show("Not Available", context);
           },
      ),
    );
  }
}
