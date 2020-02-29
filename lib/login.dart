import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solve4bharat_vaani/SizeConfig.dart';
import 'package:solve4bharat_vaani/dashboard.dart';
import 'package:toast/toast.dart';
import 'style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var password = TextEditingController();
  var _dio = Dio();
  var email = TextEditingController();


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
//      appBar: AppBar(
//        title: Text(
//          "Doctor Login",
//          style: appbarStyle,
//        ),
//        centerTitle: true,
//        backgroundColor: Colors.white,
//        iconTheme: IconThemeData(color: Colors.black),
//        elevation: 6,
//      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: Column( mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(
                    child: Image.asset("assets/whitelogo.png" ,height: 200,width: 200,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                            enabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            labelText: "Email",
                            labelStyle: inputlableStyle,
                            border: OutlineInputBorder(),
                            hintText: "XYZ@MAIL.COM")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: outlineInputBorder,
                             focusedBorder: outlineInputBorder,labelStyle: inputlableStyle,
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            hintText: "XXXX XXXX")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton.extended(
                      onPressed: () async {
                        _showDialog();
                      try{
                        Response response = await _dio.post(
                            "https://us-central1-solve4bharat-b7a27.cloudfunctions.net/checkDoctor",
                            data: {
                              "email": email.text.toString(),
                              "pwd": password.text.toString()
                            });

                        if (response.data['message'] == "Successful")
                        {
                          print( response.data['data']);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("docid",  response.data['data']);
                          prefs.setString("docname",  response.data['name']);
                          Toast.show("Login Succsessful", context,
                              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DashBoard()),
                          );
                        }

                        else{
                          Toast.show("Username or Password is Wrong", context,
                              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          Navigator.pop(context);


                        }
                      }
                      catch(e){
                          print(e.toString());
                        Toast.show("Something went Wrong Opps Please Try Again", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

                        Navigator.pop(context);

                      }





                      },
                      icon: Icon(Icons.vpn_key),
                      label: Text("Login"),
                      backgroundColor: Colors.indigo[300]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: true,
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


