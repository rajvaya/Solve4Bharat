import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solve4bharat_vaani/data.dart';
import 'package:solve4bharat_vaani/prescriptionscreen.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'SizeConfig.dart';
import 'package:speech_recognition/speech_recognition.dart';

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
  bool isListening = false;
  var _dio = Dio();
  var _speech = SpeechRecognition();

  List prescriptionlist = [];

  @override
  void initState() {
    super.initState();
    _speech.activate();
    initSpeechRecognizer();
  }

  initSpeechRecognizer() {
    _speech.setRecognitionResultHandler((String text) {
      setState(() {
           lastWords = text;
        });
    });

    _speech.setRecognitionCompleteHandler(
        () {
          isListening = false;
          if (!isListening) {
//            prescriptionlist.add(lastWords);
//            Prescription= " ";
//            for(int i=0;i<=prescriptionlist.length;i++)
//            {
//              prescriptionlist.removeAt(i);
//            }
//           // Prescription += lastWords;
//           for(int i=0;i<=prescriptionlist.length;i++)
//             {
//               Prescription = Prescription + prescriptionlist[i];
//             }
//            print(Prescription);
//            lastWords = " ";
            setState(() {
              if (initmic) {
                initmic = !initmic;
              }
            });
          }
        });

    _speech
        .setRecognitionStartedHandler(() => setState(() {
           isListening = true;
           if(initmic){
             initmic = !initmic;
           }
        }));


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
      body: !_hasSpeech
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
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.indigo[300], width: 2),
                            ),
                            height: SizeConfig.safeBlockVertical * 20,
                            width: SizeConfig.safeBlockHorizontal * 100 - 32,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    isListening
                                        ? "I can hear something like ...."
                                        : "I am not listening!",
                                    style: GoogleFonts.bevan(
                                        fontSize: 24,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400),
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
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.indigo[300], width: 2),
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
                                    lastWords,
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
      floatingActionButton:  MultiFabs(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }





  Widget MultiFabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton.extended(
          heroTag: "mic",
          icon: Icon(Icons.mic),
          label: Text('Speak'),
          onPressed: () {
            _speech.listen(locale: "en_IN");
          },
          backgroundColor: Colors.indigo[200],
        ),
        FloatingActionButton.extended(
          heroTag: "clear",
          icon: Icon(Icons.clear),
          label: Text('Clear'),
          onPressed: () {
            Prescription = " ";
            lastWords = " ";
            initmic = true;
            setState(() {});
          },
          backgroundColor: Colors.indigo[200],
        ),
        FloatingActionButton.extended(
          heroTag: "send",
          icon: Icon(Icons.send),
          label: Text('Send'),
          onPressed: () async {
            try {
              var jsondata = jsonEncode({'pres_str': lastWords});
              Response response = await _dio.post(
                  "https://vaani-nlp.herokuapp.com/model",
                  data: jsondata);
              if (response.statusCode == 200) {
                print(response.data.toString());
                DataObject = response.data;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrescriptionScreen()),
                );
              } else {
                print("ERROR");
              }
            } catch (e) {
              print(e.toString());
            }
          },
          backgroundColor: Colors.indigo[200],
        ),
      ],
    );
  }
}
