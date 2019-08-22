import 'dart:async';

import 'package:first_app/setting.dart';
import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';

enum TapState{
  canTap,
  waitForTimer
}

class DetectionTest extends StatefulWidget {

  final int detectionMethod;
  final NapSettingsData settings;
  DetectionTest({this.detectionMethod, this.settings});

  @override
  _DetectionTestState createState() => _DetectionTestState();
}

class _DetectionTestState extends State<DetectionTest> {
  TapState _tapState = TapState.canTap;
  bool _firstTap = true;
  Timer _timer;

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing Sleep Detection Methods"),
      ),
      body: widget.detectionMethod == 0 ? buildTapPage() : buildDropPage(),
    );
  }

  tapTimerStart(){
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        //This block of code will run every vibrationInterval (10) seconds.
        _tapState = TapState.canTap;
        Vibrate.feedback(FeedbackType.warning);
      });
    });
  }

  tapPageTap(){
    setState(() {
      if(_firstTap){
        tapTimerStart();
        _firstTap = false;
      }
      _tapState = TapState.waitForTimer;
    });
  }

  Widget buildTapPage(){
    print("tap");
    return GestureDetector(
      onTap: () => tapPageTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 500,
            child: SafeArea(
              child: Container(
                color: Colors.black26,
                child: _tapState == TapState.waitForTimer ? Text("Wait") : Text("Tap", style: TextStyle(fontSize: 40), textAlign: TextAlign.center,),
                alignment: Alignment(0.0, 0.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildDropPage(){
    print("drop");
  }
}