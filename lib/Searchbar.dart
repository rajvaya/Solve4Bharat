import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';

class Sbar extends StatefulWidget {
  @override
  _SbarState createState() => _SbarState();
}

class _SbarState extends State<Sbar> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FloatingSearchBar.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },
        trailing: CircleAvatar(
          child: Text("RD"),
        ),
        drawer: Drawer(
          child: Container(),
        ),
      ),
    );
  }
}
