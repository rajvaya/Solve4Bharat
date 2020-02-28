import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solve4bharat_vaani/SizeConfig.dart';
import 'file:///D:/flutterprojects/solve4bharat_vaani/lib/addpatients.dart';
import 'package:solve4bharat_vaani/patientModel.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isLoading = true;
  bool listLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocID();
  }

  String docID;
  String docName;
  Future<Null> getDocID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    docID = pref.getString('docid');
    docName = pref.getString('docname');
    setState(() {
      isLoading = false;
    });

    getPatients();
  }

  var _dio = Dio();
  List<dynamic> PatientsList = [];

  getPatients() async {
    try {
      Response response = await _dio.post(
          "https://us-central1-solve4bharat-b7a27.cloudfunctions.net/docPatients",
          data: {"docID": docID});
      if (response.data['message'] == "Successful") {
        print(response.data['dataList'].runtimeType);
          PatientsList = response.data['dataList'];
          print(PatientsList.length.toString());
          setState(() {
          listLoading = false;
        });
      } else {
        print("ERROR");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("DASHBOARD"),
        centerTitle: true,
        backgroundColor: Colors.indigo[200],
      ),
      body: !isLoading ? Column(
         mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
            child: Text("Morning " + docName,
                style: GoogleFonts.pTSans(
                    fontSize: 30, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
            child: Text("Select From Existing Patients",
                style: GoogleFonts.lato(
                    fontSize: 20, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: SizeConfig.safeBlockVertical * 70,
              width: SizeConfig.safeBlockHorizontal * 100,
              //color: Colors.green[200],
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  //color: Colors.deepPurpleAccent,

              ),
              child: listLoading ?  Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.indigo[300],
                  ),
                ),
              ) :
              ListView.builder(
                  itemCount: PatientsList.length,
                  itemBuilder:(BuildContext ctxt, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: SizeConfig.safeBlockVertical * 8,
                        width: SizeConfig.safeBlockHorizontal * 90,
                        //color: Colors.deepPurpleAccent,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          //color: Colors.deepPurpleAccent,
                          border: Border.all(color: Colors.indigo[300],width: 2)
                        ),
                        child: ListTile(
                          title: Text(PatientsList[index]["data"]["name"]),
                          subtitle: Text(PatientsList[index]["data"]["phone"]),
                        ),


                      ),
                    );
                  }
              ),
            ),
          )
        ],
      ) :  Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Colors.indigo[300],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton.extended(

            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPatients()),
              );
            },
            icon: Icon(Icons.shopping_cart),
            label: Text("Add Patients"),
            backgroundColor: Colors.indigo[300]
        ),
      ),
    );
  }
}
