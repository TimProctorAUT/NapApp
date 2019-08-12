import 'package:audioplayers/audio_cache.dart';
import 'package:first_app/views/napSettingPage.dart';
import 'package:first_app/views/testDataPage.dart';
import 'package:first_app/views/timerView.dart';
import 'package:flutter/material.dart'; //Required for Flutter Widgets
import 'sleepDetection.dart';
import 'dart:async'; //Required for Timer
import 'package:vibrate/vibrate.dart'; //Required for vibrate
import 'package:audioplayers/audioplayers.dart';

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

class TapMethod extends StatefulWidget {

  final int napLength;
  final int napLimit;
  final int vibrationInterval;
  final String selectedAudio;

  const TapMethod({Key key, this.napLength, this.napLimit, this.vibrationInterval, this.selectedAudio}):super(key: key);

  @override
  _TapMethodState createState() => _TapMethodState();
}

class _TapMethodState extends State<TapMethod> with WidgetsBindingObserver{
  SleepStateAlgorithm _ssa = SleepStateAlgorithm(); 
  TapState _tapState = TapState.canTap;
  DetectionState _detectState = DetectionState.waiting;
  int tapCount = 0;
  int missedTaps = 0;
  Timer _timer;
  bool _firstTap = true;
  static AudioPlayer _audioPlayer = AudioPlayer();
  static AudioCache _audioCache = AudioCache(fixedPlayer: _audioPlayer);
  int loopCount = 0;
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  
//initstate allows any code to be run on load of this page.
  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

//dispose allows any code to be run before the instance of this page is disposed.
  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

//didChangeAppLifeCycleState allows any code to be run when the app is paused (minimized) or resumed.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        print("paused");
        _stopTimer();
        break;

      case AppLifecycleState.resumed:
        print("resumed");
        _startTimer();
        break;

      case AppLifecycleState.inactive:
        print("inactive");
        break;

      case AppLifecycleState.suspending:
        print("suspending");
        break;
    }
  }

//Starts the vibrate timer.
//Contains all code run on every timer tick.
  _startTimer(){
    _timer = Timer.periodic(Duration(seconds: this.widget.vibrationInterval != null ? this.widget.vibrationInterval : 10), (timer) {
      setState(() {
        print("~~~~~~~~~~ Loop No. $loopCount ~~~~~~~~~~");
        //This block of code will run every vibrationInterval (5) seconds.
        _ssa.setNapInformation(this.widget.napLimit, this.widget.napLength);

        if(_tapState == TapState.canTap){
          incrementMissedTapsCount();
        }
        else{
          incrementTapCount();
        }

        _ssa.updateAlgorithm(missedTaps);

        if(_ssa.isSleeping){
          _navigateToAlarm();
        }

        if(_ssa.napLimitReached){
          _navigateToAlarm();
        }
        
        _tapState = TapState.canTap;
        Vibrate.feedback(FeedbackType.warning);
        printCount();
        loopCount++;
        print("~~~~~~~~~~ END LOOP ~~~~~~~~~~");
        /////////////////////////////////////////////////////////////////////
      });
    });

    print("timer started");
  }

//Stops the vibrate timer.
  _stopTimer(){
    _timer.cancel();
    print("timer stopped");
  }

//Called when wanting to navigate to the alarm.
_navigateToAlarm(){
  _stopTimer();
  _stopAudio();
  _ssa.stopTimer();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => NapTimer(napLength: widget.napLength,)), ModalRoute.withName('/'));
}

//Called when the alarm is not needed and wanting to navigate to the summary page.
  _navigateToEnd(){
    _stopTimer();
    _stopAudio();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => TestData()), ModalRoute.withName('/'));
  }

  _playAudio() async{
    _audioCache.play('test.mp3');
  }

  _stopAudio(){
  _audioCache.fixedPlayer.stop();
  }

  _pauseAudio(){
    _audioCache.fixedPlayer.pause();
  }

  _resumeAudio(){
    _audioCache.fixedPlayer.resume();
  }

//Called everytime the user taps the screen.
  _onSleepDetectionTap(){
    setState(() {

      _playAudio();

      if(_firstTap){
        _firstTap = false;
        _startTimer();
      }
      
      if(_tapState == TapState.canTap){
        int caseNo = _checkDetectionState();

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
            _detectState = DetectionState.running;
            _resumeAudio();
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

//Returns number 0~4 to indicate current detection state.
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
    _pauseAudio();
    _detectState = DetectionState.stopped;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 600,
                child: SafeArea(
                  child: Container(
                    color: Colors.red,
                    child: _tapState == TapState.waitForTimer ? Text("Wait") : Text("Tap", style: TextStyle(fontSize: 40), textAlign: TextAlign.center,),
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