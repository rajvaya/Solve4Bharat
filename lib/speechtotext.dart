import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data.dart';

import 'SizeConfig.dart';

class SpeechToText extends StatefulWidget {
  @override
  _SpeechToTextState createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Speak Your Prescription"),
        centerTitle: true,
        backgroundColor: Colors.indigo[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey,
              height: SizeConfig.safeBlockVertical * 70-16,
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
 style:  GoogleFonts.pTSans(fontSize: 24, color: Colors.indigo[400],fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){

      }, label: Text("Speak NOw")),
    );
  }
}
