import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_widget/search_widget.dart';
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
      body: !isLoading
          ? Column(
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
                      style:
                          GoogleFonts.lato(fontSize: 20, color: Colors.black)),
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
                    child: listLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.indigo[300],
                              ),
                            ),
                          )
                        : Column(
                            children: <Widget>[
                              SearchWidget<dynamic>(
                                onItemSelected: (item){
                                  print(item.toString());

                                },
                                noItemsFoundWidget: NoItemsFound(),
                                textFieldBuilder: (TextEditingController controller, FocusNode focusNode) {
                                  return MyTextField(controller, focusNode);
                                },
                                listContainerHeight:
                                    SizeConfig.safeBlockVertical * 30,
                                dataList: PatientsList,
                                queryBuilder:
                                    (String query, List<dynamic> list) {
                                  return list.where((dynamic item) {
                                    return item["data"]["name"]
                                        .toLowerCase()
                                        .contains(query.toLowerCase());
                                  }).toList();
                                },
                                  popupListItemBuilder: (dynamic item) {
                                    return PopupListItemWidget(item);
                                  },
                      selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                return SelectedItemWidget(selectedItem, deleteSelectedItem);
                },

                              ),
                              Flexible(
                                child: ListView.builder(
                                    itemCount: PatientsList.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height:
                                              SizeConfig.safeBlockVertical * 8,
                                          width:
                                              SizeConfig.safeBlockHorizontal *
                                                  90,
                                          //color: Colors.deepPurpleAccent,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              //color: Colors.deepPurpleAccent,
                                              border: Border.all(
                                                  color: Colors.indigo[300],
                                                  width: 2)),
                                          child: ListTile(
                                            title: Text(PatientsList[index]
                                                ["data"]["name"]),
                                            subtitle: Text(PatientsList[index]
                                                ["data"]["phone"]),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                  ),
                )
              ],
            )
          : Center(
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPatients()),
              );
            },
            icon: Icon(Icons.shopping_cart),
            label: Text("Add Patients"),
            backgroundColor: Colors.indigo[300]),
      ),
    );
  }
}
class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item["data"]["name"],
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final dynamic selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 4,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8,
                ),
                child: Text(
                  selectedItem["data"]["name"],
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, size: 22),
              color: Colors.grey[700],
              onPressed: deleteSelectedItem,
            ),
          ],
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}