import 'data.dart';
import 'package:flutter/material.dart';

class EmailSend extends StatefulWidget {
  @override
  _EmailSendState createState() => _EmailSendState();
}

class _EmailSendState extends State<EmailSend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text("Email Confirmation"),
      centerTitle: true,
      backgroundColor: Colors.indigo[200],
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.check_circle,size: 50,color: Colors.green[300],),
            ),
            Text(
              "Email Sent to: " + PatientObject['data']['email'].toString(),
              style: TextStyle(fontSize: 20),
            ),

          ],
        ),
      ),
    );
  }
}
