import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'SizeConfig.dart';

class AddPatients extends StatefulWidget {
  @override
  _AddPatientsState createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  var _dio = new Dio();
  var phone = TextEditingController();
  var aadhar = TextEditingController();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
          child: Column( mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: TextField(
                      controller: aadhar,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.indigo)),
                          labelText: "Aad ",
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
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton.extended(
                    onPressed: () async {
                      _showDialog();
                      try {
                        print(phone.text.toString());
                        print(aadhar.text.toString());
                        Response response = await _dio.post(
                            "https://us-central1-hexahive-fda2d.cloudfunctions.net/test",
                            data: {
                              "aadhaar_number": aadhar.text.toString(),
                              "phone_number": phone.text.toString()
                            });

                        print(response.data['message']);
                        if (response.data['message'] == "Aadhaar Data found") {
                          Response response1 = await _dio.post(
                              "https://us-central1-hexahive-fda2d.cloudfunctions.net/policeVerification",
                              data: {"phone_number": phone.text.toString()});
                          print(response1.data['message']);
                          if (response1.data['message'] == "No record found") {
                            Response response2 = await _dio.post(
                                "https://us-central1-hexahive-fda2d.cloudfunctions.net/mailSend",
                                data: {"email": email.text});
                            print(response2.toString());
                            Navigator.pop(context);

                          }
                        }
                      } catch (e) {
                        print(e);
                        // BotToast.showText(text:"xxxx");
                        Toast.show("Something went Wrong Opps", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.verified_user),
                    label: Text("Verify"),
                    backgroundColor: Colors.indigo[300]),
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
                    Colors.indigo[300],
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
