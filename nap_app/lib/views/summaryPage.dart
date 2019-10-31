import 'dart:convert';
import 'dart:math';
import 'package:first_app/fileOperations.dart';
import 'package:first_app/setting.dart';
import 'package:first_app/userNapData.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget{
  final UserNapData napData;
  SummaryPage({this.napData});

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  FileOperations fileOps = FileOperations();
  UserNapData tmpData = UserNapData();
  int random;
  Duration duration;

//initstate allows any code to be run on load of this page.
  @override
  void initState() {
    super.initState();
    writeNapData();
    convertToTimeDisplay(20);
  }

//Writes the current session napData to file.
//This is only done on the summary page as at this point the user has 'completed' a nap session.
  writeNapData() async{
    await fileOps.writeNapData(jsonEncode(widget.napData), widget.napData.napNumber);
    getNapData();
  }

//Reads the napData from file to be used to display on the summary page.
  getNapData() async{
    UserNapData decodedNapData = await fileOps.readObjectFromFile("UserNapData", napNumber: widget.napData.napNumber);

    print("file read");

    setState(() {
      tmpData = decodedNapData;
      random = 0 + Random().nextInt(NapSettingsData.encouragingMessages.length);
    });
  }

//returns a Card widget to the build method
  cardBuilder(String title, String subtitle){

    if(subtitle == "true"){
      subtitle = "Successfull";
    }
    else if(subtitle == "false"){
      subtitle = "Unsuccessfull";
    }

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

//returns a column widget to the build method.
  centerBuilder(String mainText, String subText){
    if(widget.napData.successfullSleep){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(mainText, style: TextStyle(fontSize: 50),),
          Text(subText, style: TextStyle(fontSize: 20),)
        ],
      );
    }
    else{
      //if
      return random == null 
      //then
      ? Text("Something went wrong reading nap data", textAlign: TextAlign.center,) 
      //else
      : Text(NapSettingsData.encouragingMessages[random], style: TextStyle(fontSize: 30), textAlign: TextAlign.center,);
    }
  }

//Converts the stored value of time(seconds) into a more readable time display
// of M:SS
  String convertToTimeDisplay(int savedValue){
    duration = Duration(seconds: savedValue);
    String minutesSeconds;
    int minutes = duration.inSeconds ~/ 60;
    int seconds = duration.inSeconds % 60;

    if(duration.inMinutes == 0){
      minutesSeconds = "second(s)";
    }
    else{
      minutesSeconds = "minute(s)";
    }

    if(seconds < 10){
      return "$minutes:0$seconds $minutesSeconds";
    }
    else{
      return "$minutes:$seconds $minutesSeconds";
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
            padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
          ),
          //Center Piece Title
          Spacer(),
          tmpData.successfullSleep == null ? centerBuilder("Oops", "Something went wrong") : centerBuilder("You Fell Asleep!", "That's definitely time well spent!"),
          Spacer(),

          //Start of Stat cards
          Divider(),

          //if
          tmpData.napNumber == null
          //then 
          ? cardBuilder("Oops", "${null}")
          //else 
          : cardBuilder("Nap Number", "${tmpData.napNumber}"),

          Divider(),

          //if
          tmpData.successfullSleep == null
          //then 
          ? cardBuilder("Oops", "${null}")
          //else 
          : cardBuilder("Fell Asleep?", "${tmpData.successfullSleep}"),
          Divider(),

          //if
          tmpData.successfullSleep == null 
          //then
          ? cardBuilder("Oops", "${null}") 
          //else
          : cardBuilder("Time Till Asleep", "${convertToTimeDisplay(tmpData.timeToSleep)}"),
         
          Divider(),

          //if
          tmpData.successfullSleep == null
          //then
          ? cardBuilder("Oops", "${null}")
          //else
          : cardBuilder("Time Slept", "${convertToTimeDisplay(tmpData.timeSleptInSeconds)}"),
          
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