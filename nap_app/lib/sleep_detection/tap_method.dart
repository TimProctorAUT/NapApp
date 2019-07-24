import 'package:flutter/material.dart'; //Required for Flutter Widgets
import 'package:nap_app/sleep_detection/sleep_state.dart';
import 'dart:async'; //Required for Timer
import 'package:vibrate/vibrate.dart'; //Required for vibrate

class TapMethod extends StatefulWidget {
  @override
  _TapMethodState createState() => _TapMethodState();
}

enum DetectionState{
  waiting,
  started,
  running
}

class _TapMethodState extends State<TapMethod> {
  bool _tapState = false;
  int _variableTime = 5;
  DetectionState _detectState = DetectionState.waiting;

  
//initstate required to create a timer to set the state of the _tapState bool to false.
  @override
  void initState() { 
    super.initState();
      Timer.periodic(Duration(seconds: _variableTime), (timer) {
        setState(() {
          _tapState == true ? Vibrate.feedback(FeedbackType.warning) : _tapState = false;
          _tapState = false;
        });
      });
  }

//method to invoke setstate to change the state of the _tapState bool.
  void _checkTap(){
    setState(() {
      if(_detectState == DetectionState.waiting){
        _detectState = DetectionState.started;
      }
      _checkSleepState();
      _tapState = true;
    });
  }

  void _checkSleepState(){
    if(_detectState == DetectionState.started){
      SleepStateAlgorithm();
      _detectState = DetectionState.running;
    }
  }

//WillPopScope requires Future<bool> to handle back button press to terminate nap session.
  Future<bool> _confirmEnd(){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure you want to terminate your sleep session?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () => Navigator.pop(context, true),
          ),
          FlatButton(
            child: Text("No"),
            onPressed: () => Navigator.pop(context, false),
          )
        ],
      )
    );
  }

//Column returned to the main dart file to build a UI for the tap-testing.
  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: _confirmEnd,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => _checkTap(),
              //Container Child is WIP - to detect taps (currently can only tap on the word)
              child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.white, width: 2.0)
                ),
                //padding: EdgeInsets.all(200),
                alignment: Alignment.center,
                child: _tapState == true ? Text("") : Text("Tap", style: TextStyle(fontSize: 40),),
              )
            )
          ],
        ),
      ),
    );
  }
}