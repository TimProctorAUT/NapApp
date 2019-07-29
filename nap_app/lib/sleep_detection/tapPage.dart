import 'package:flutter/material.dart'; //Required for Flutter Widgets
import 'sleepDetection.dart';
import 'dart:async'; //Required for Timer
import 'package:vibrate/vibrate.dart'; //Required for vibrate

class TapMethod extends StatefulWidget {

  final int napLength;
  final int napLimit;
  final int vibrationInterval;

  const TapMethod({Key key, this.napLength, this.napLimit, this.vibrationInterval}):super(key: key);

  @override
  _TapMethodState createState() => _TapMethodState();
}

enum DetectionState{
  waiting,
  started,
  running,
  stopped
}

enum TapState{
  canTap,
  waitForTimer
}

class _TapMethodState extends State<TapMethod> {

  SleepStateAlgorithm _ssa = SleepStateAlgorithm(); 
  TapState _tapState = TapState.canTap;
  DetectionState _detectState = DetectionState.waiting;
  int tapCount = 0;
  int missedTaps = 0;

  
//initstate required to create a periodic timer.
  @override
  void initState() { 
    super.initState();
    _ssa.printSleepStateDebugOnly();
      Timer.periodic(Duration(seconds: this.widget.vibrationInterval != null ? this.widget.vibrationInterval : 5), (timer) {
        setState(() {
          //This block of code will run every vibrationInterval (5) seconds.
          
          if(_tapState == TapState.canTap){
            incrementMissedTapsCount();
          }
          else{
            incrementTapCount();
          }

          _ssa.updateAlgorithm(missedTaps);

          _tapState = TapState.canTap;
          Vibrate.feedback(FeedbackType.warning);
          printCount();

          /////////////////////////////////////////////////////////////////////
        });
      }
    );
  }

  _onSleepDetectionTap(){
    setState(() {
      if(_tapState == TapState.canTap){
        int caseNo = _checkDetectionState();
        print(caseNo);

        switch(caseNo){
          case 1: //WAITING
            _detectState = DetectionState.started;
            _ssa.startTimer();
          break;

          case 2: //STARTED
            _detectState = DetectionState.running;
          break;

          case 3: //RUNNING
          break;

          case 4: //STOPPED
          break;

          case -1: //NEITHER OF THE OPTIONS
          break;
        }
      }
      else{
        print("It is not time to tap yet");
      }

      _tapState = TapState.waitForTimer;
    });
  }

  int _checkDetectionState(){
    if(_detectState == DetectionState.waiting){
      return 1;
    }
    if(_detectState == DetectionState.started){
      return 2;
    }
    if(_detectState == DetectionState.running){
      return 3;
    }
    if(_detectState == DetectionState.stopped){
      return 4;
    }
    return -1;
  }

  incrementTapCount(){
    tapCount++;
  }

  incrementMissedTapsCount(){
    missedTaps++;
  }

  printCount(){
    print("Missed count: $missedTaps");
    print("Tap count: $tapCount");
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
    return WillPopScope(
      onWillPop: _confirmEnd,
      child: Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
          onTap: () => _onSleepDetectionTap(),
          onDoubleTap: _ssa.forceSleepStateDebugOnly(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 600,
                child: SafeArea(
                  child: Container(
                    color: Colors.red,
                    child: _tapState == TapState.waitForTimer ? Text("") : Text("Tap", style: TextStyle(fontSize: 40), textAlign: TextAlign.center,),
                    alignment: Alignment(0.0, 0.0),
                  ),
                )
              ),
            ],
          )
        ),
      ),
    );
  }
}