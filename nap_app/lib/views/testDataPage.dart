import 'dart:convert';
import 'dart:io';

import 'package:first_app/fileOperations.dart';
import 'package:first_app/userNapData.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class TestData extends StatefulWidget
{
  final UserNapData napData;

  TestData({this.napData});

  @override
  _TestDataPageState createState() => _TestDataPageState();
}


class _TestDataPageState extends State<TestData> {

  FileOperations fileOps = FileOperations();
  UserNapData tmpData = UserNapData();

  @override
  void initState() {
    super.initState();
    writeNapData();
  }

  writeNapData() async{
    await fileOps.writeNapData(jsonEncode(widget.napData), widget.napData.napNumber);
    getNapData();
  }

  getNapData() async{
    await fileOps.readNapData(widget.napData.napNumber);

    print("file read");

    setState(() {
      tmpData = UserNapData(
        napNumber: FileOperations.decodedNapData['napNumber'],
        successfullSleep: FileOperations.decodedNapData['successfullSleep'],
        timeOfNap: FileOperations.decodedNapData['timeOfNap'],
        timeSleptInSeconds: FileOperations.decodedNapData['timeSleptInSeconds'],
        timeToSleep: FileOperations.decodedNapData['timeToSleep']
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NapApp Menu Tests',
      theme: ThemeData(
        //Colors
        primaryColor: Color.fromRGBO(18, 18, 18, 1),
        scaffoldBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
        cardColor: Color.fromRGBO(18, 18, 18, 0.8),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Nap Number: ${tmpData.napNumber}", style: Theme.of(context).textTheme.body1,),
                Text("Did you fall asleep: ${tmpData.successfullSleep}", style: Theme.of(context).textTheme.body1,),
                Text("Time of Nap: ${tmpData.timeOfNap}", style: Theme.of(context).textTheme.body1,),
                Text("Time Slept: ${tmpData.timeSleptInSeconds}", style: Theme.of(context).textTheme.body1,),
                Text("Time to Sleep: ${tmpData.timeToSleep}", style: Theme.of(context).textTheme.body1,),
                RaisedButton(
                  child: Text("Go Home"),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
                  },
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}