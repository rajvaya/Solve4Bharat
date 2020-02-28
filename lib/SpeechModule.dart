import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solve4bharat_vaani/prescriptionscreen.dart';
import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

import 'SizeConfig.dart';

class SpeechModule extends StatefulWidget {
  @override
  _SpeechModuleState createState() => _SpeechModuleState();
}

class _SpeechModuleState extends State<SpeechModule> {
  bool _hasSpeech = false;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String Prescription = "";
  bool initmic = true;
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

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
      body: _hasSpeech
          ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(16),
                          border: Border.all(
                              color: Colors.indigo[300],
                              width: 2),
                        ),
                        height: SizeConfig.safeBlockVertical * 20,
                        width: SizeConfig.safeBlockHorizontal*100 - 32,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                            Text(
                            speech.isListening ? "I Can Here Something Like ....":"I Am Not Listening !",
                            style: GoogleFonts.bevan(
                                fontSize: 24,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                          ),
                              Text(
                                speech.isListening ? lastWords: initmic ? "Click on Speak to Start Prescribing" : " Click On Add More For Adding More Data",
                                style: GoogleFonts.pTSans(
                                    fontSize: 20,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.indigo[300],
                                width: 2),
                        ),
                        height: SizeConfig.safeBlockVertical * 60,
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Prescription",
                                style: GoogleFonts.bevan(
                                    fontSize: 24,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Center(
                              child: Text(
                                 Prescription,
                                style: GoogleFonts.pTSans(
                                    fontSize: 20,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])
          : Center(
              child: Text('Speech recognition unavailable',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
      floatingActionButton: initmic?initmicwidget(): MultiFabs(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(onResult: resultListener);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {});
  }

  void cancelListening() {
    speech.cancel();
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords}";
      //joinText();
      //Prescription = lastWords;
      //joinText();
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void joinText() {
    print("IN JOIN");
    if (!speech.isListening) {
      Prescription = Prescription + " " + lastWords;
      lastWords = " ";
      setState(() {

        if(initmic){
          initmic = !initmic;
        }
      });
    }
  }

  void statusListener(String status) {
    joinText();
    setState(() {
      lastStatus = "$status";
    });
  }

  Widget initmicwidget(){
    return FloatingActionButton.extended(
      icon: Icon(Icons.mic),
      label: Text('Speak'),
      onPressed: startListening,
      backgroundColor: Colors.indigo[200],
    );
  }


  Widget MultiFabs(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: <Widget>[
        FloatingActionButton.extended(
          icon: Icon(Icons.mic),
          label: Text('Add More'),
          onPressed: startListening,
          backgroundColor: Colors.indigo[200],
        ),
        FloatingActionButton.extended(
          icon: Icon(Icons.clear),
          label: Text('Clear'),
          onPressed: (){
         Prescription = " ";
         initmic = true;
         setState(() {

         });
          },
          backgroundColor: Colors.indigo[200],
        ),
        FloatingActionButton.extended(
          icon: Icon(Icons.send),
          label: Text('Send'),
          onPressed: (){
            print(Prescription);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrescriptionScreen()),
            );
          },
          backgroundColor: Colors.indigo[200],
        ),
      ],
    );
  }

}

class _HexagonBorder extends ShapeBorder {
  const _HexagonBorder();

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.left + rect.width / 6.0, rect.top)
      ..lineTo(rect.right - rect.width / 6.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.right - rect.width / 6.0, rect.bottom)
      ..lineTo(rect.left + rect.width / 6.0, rect.bottom)
      ..lineTo(rect.left, rect.bottom - rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
