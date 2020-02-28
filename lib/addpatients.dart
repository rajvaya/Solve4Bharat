import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solve4bharat_vaani/PatientsDetails.dart';
import 'package:solve4bharat_vaani/SpeechModule.dart';
import 'package:solve4bharat_vaani/data.dart';
import 'package:toast/toast.dart';
import 'SizeConfig.dart';

class AddPatients extends StatefulWidget {
  @override
  _AddPatientsState createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  var _dio = new Dio();
  var phone = TextEditingController();
  var name = TextEditingController();
  var email = TextEditingController();
  var dob = TextEditingController();
  var gender = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("ADD PATIENT"),
        centerTitle: true,
        backgroundColor: Colors.indigo[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.indigo)),
                          labelText: "Name",
                          border: OutlineInputBorder(),
                          hintText: "1234 XXXX XXXX")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: TextField(
                      controller: phone,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.indigo)),
                          labelText: "Phone Number",
                          border: OutlineInputBorder(),
                          hintText: "9999999999")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.indigo)),
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          hintText: "XYZ@MAIL.COM")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: TextField(
                      controller: dob,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.indigo)),
                          labelText: "Date Of Birth",
                          border: OutlineInputBorder(),
                          hintText: "DD-MM-YYYY")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: TextField(
                      controller: gender,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.indigo)),
                          labelText: "gender",
                          border: OutlineInputBorder(),
                          hintText: "Male/Female")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton.extended(
                    onPressed: () async {
                      _showDialog();
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      var docID = pref.getString('docid');


                      try {
                        Response response = await _dio.post(
                            "https://us-central1-solve4bharat-b7a27.cloudfunctions.net/addPatient",
                            data: {
                              "email": email.text.toString(),
                              "phone": phone.text.toString(),
                              "docID": docID,
                              "dob": dob.text.toString(),
                              "name": name.text.toString(),
                              "gender": gender.text.toString()
                            });
                        if (response.data['data']!= null) {
                          print(response.data['data']);

                          var DataObject = {
                             "id": response.data['data'],
                            "data" : {
                              "email": email.text.toString(),
                              "phone": phone.text.toString(),
                              "docID": docID,
                              "dob": dob.text.toString(),
                              "name": name.text.toString(),
                              "gender": gender.text.toString(),
                            }
                          };
                          PatientObject = DataObject;
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PatientsDetails()),
                          );
                        }
                      } catch (e) {
                        print(e);
                        // BotToast.showText(text:"xxxx");
                        Toast.show("Something went Wrong Opps", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.add),
                    label: Text("ADD"),
                    backgroundColor: Colors.indigo[200]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Please Wait"),
          content: Wrap(
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.indigo[200],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
