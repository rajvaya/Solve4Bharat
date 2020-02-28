import 'package:flutter/material.dart';
import 'package:solve4bharat_vaani/SpeechModule.dart';
import 'package:solve4bharat_vaani/data.dart';

class PatientsDetails extends StatelessWidget {
  TextStyle apnastyle = TextStyle(
    fontSize: 24,
        color: Colors.grey[500],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Patient Details"),
        centerTitle: true,
        backgroundColor: Colors.indigo[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
             // height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Name : " + PatientObject['data']['name'].toString(),style: apnastyle,),
                  Text("Gender : " + PatientObject['data']['gender'].toString(),style: apnastyle,),
                  Text("Date of Birth : " + PatientObject['data']['dob'].toString(),style: apnastyle,),
                  Text("Email : " + PatientObject['data']['email'].toString(),style: apnastyle,),
                  Text("Phone : " + PatientObject['data']['phone'].toString(),style: apnastyle,),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpeechModule()),
          );
        },
        icon: Text("Add Prescription") ,
        label: Icon(Icons.arrow_forward),
        backgroundColor: Colors.indigo[200],
      ),
    );
  }
}
