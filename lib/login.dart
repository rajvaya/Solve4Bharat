import 'package:flutter/material.dart';
import 'package:solve4bharat_vaani/SizeConfig.dart';
import 'style.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var password = TextEditingController();
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
            elevation: 6,
            child: Column( mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(
                    child: Image.asset("assets/logo.png" ,height: 100,width: 100,),
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

                      },
                      icon: Icon(Icons.verified_user),
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


