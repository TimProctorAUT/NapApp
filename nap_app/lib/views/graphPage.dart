import 'package:first_app/fileOperations.dart';
import 'package:first_app/views/homePage.dart';
import 'package:flutter/material.dart';

class PastNaps extends StatefulWidget
{
  @override 
  _PastNapsState createState() => _PastNapsState();
}

class _PastNapsState extends State<PastNaps> {

  FileOperations fileOps = FileOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Naps'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: (){
              fileOps.deleteAllNapData();
              Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
            },
            child: Text("Delete All Nap Data"),
          ),
        ],
      ),
    );
  }
}