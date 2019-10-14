import 'dart:convert';
import 'dart:math';
import 'package:first_app/fileOperations.dart';
import 'package:first_app/setting.dart';
import 'package:first_app/userNapData.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget
{
  final UserNapData napData;

  SummaryPage({this.napData});

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  FileOperations fileOps = FileOperations();
  UserNapData tmpData = UserNapData();
  int random;

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
      random = 0 + Random().nextInt(NapSettingsData.encouragingMessages.length);
    });
  }

  cardBuilder(String title, String subtitle){
    return Card(
      color: Color.fromRGBO(50, 50, 50, 0.7),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
          ),
          Expanded(
            flex: 3,
            child: Text(title),
          ),
          Expanded(
            flex: 3,
            child: Text(":", textAlign: TextAlign.center,),
          ),
          Expanded(
            flex: 3,
            child: Text(subtitle, textAlign: TextAlign.right,),
          ),
          Spacer(),
        ],
      ),
    );
  }

  centerBuilder(String mainText, String subText){
    if(widget.napData.successfullSleep){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(mainText, style: TextStyle(fontSize: 50),),
          Text(subText, style: TextStyle(fontSize: 20),)
        ],
      );
    }
    else{
      return random == null ? Text("Something went wrong reading nap data") : Text(NapSettingsData.encouragingMessages[random], style: TextStyle(fontSize: 30),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          ),
          Spacer(),
          tmpData.successfullSleep == null ? centerBuilder("Oops", "Something went wrong") : centerBuilder("Good Job", "You Fell Asleep"),
          Spacer(),
          Divider(),
          tmpData.napNumber == null ? cardBuilder("Oops", "${null}") : cardBuilder("Nap Number", "${tmpData.napNumber}"),
          Divider(),
          tmpData.successfullSleep == null ? cardBuilder("Oops", "${null}") : cardBuilder("Fell Asleep", "${tmpData.successfullSleep}"),
          Divider(),
          tmpData.timeToSleep == null ? cardBuilder("Oops", "${null}") : cardBuilder("Time to Sleep", "${(tmpData.timeToSleep / 60).toStringAsFixed(2)} minutes"),
          Divider(),
          tmpData.timeSleptInSeconds == null ? cardBuilder("Oops", "${null}") : cardBuilder("Time Slept", "${(tmpData.timeSleptInSeconds / 60).toStringAsFixed(2)} minutes"),
          Divider(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
      child:  RaisedButton(
          color: Color.fromRGBO(150, 150, 150, 1),
          padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
          child: Text('Return Home'),
          onPressed: (){
            Navigator.popUntil(context, ModalRoute.withName('/'));
          } 
        ),
      ),
    );
  }
}