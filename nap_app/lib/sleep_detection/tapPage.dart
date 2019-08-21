import 'package:audioplayers/audio_cache.dart';
import 'package:first_app/setting.dart';
import 'package:first_app/views/homePage.dart';
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

  final NapSettingsData settings;

  TapMethod({this.settings});

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
  static AudioPlayer _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
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
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        print("~~~~~~~~~~ Loop No. $loopCount ~~~~~~~~~~");
        //This block of code will run every vibrationInterval (5) seconds.
        //_ssa.setNapInformation(this.widget.settings.napLimit, this.widget.settings.napLength);
        _ssa.setNapInformation(2, 1);
        if(_tapState == TapState.canTap){
          incrementMissedTapsCount();
        }
        else{
          incrementTapCount();
        }

        _ssa.updateAlgorithm(missedTaps);

        if(_ssa.isSleeping){
          _navigateToAlarmSuccess();
        }

        if(_ssa.napLimitReached){
          _navigateToAlarmFail();
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
_navigateToAlarmSuccess(){
  _stopTimer();
  _stopAudio();
  _audioCache.clearCache();
  _ssa.stopTimer();
  this.widget.settings.successfullSleep = true;
  this.widget.settings.timeSleptInSeconds = _ssa.calcRemainingAlarmTime();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => NapTimer(napLength: _ssa.calcRemainingAlarmTime())), ModalRoute.withName('/'));
}

//Called when the alarm is not needed and wanting to navigate to the summary page.
  _navigateToAlarmFail(){
    _stopTimer();
    _stopAudio();
    _audioCache.clearCache();
    _ssa.stopTimer();
    this.widget.settings.successfullSleep = false;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => NapTimer(napLength: 1)), ModalRoute.withName('/'));
  }

  _playAudio() async{
    //SAMPLE AUDIO
    //https://www.youtube.com/watch?v=79io3wgRAFU
    //Check with Brian if he wants to purchase
    try{
      _audioCache.play(this.widget.settings.selectedAudioFile + ".mp3");
    }
    catch(e){
    }
  }

  _stopAudio(){
  _audioCache.fixedPlayer.stop();
  //ADD TIMER TO SLOWLY DECREASE VOLUME
  //HOPEFULLY PERSIST INTO ALARM PAGE???
  }

//Called everytime the user taps the screen.
  _onSleepDetectionTap(){
    setState(() {
      //Only plays audio if selected from the settings page
      if(this.widget.settings.wantsAudio){
        _playAudio();
      }

      //Starts timer on the first tap
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

//DEBUG OUTPUT
  printCount(){
    print("Missed count: $missedTaps");
    print("Tap count: $tapCount");
  }

//Called when "YES" is tapped on terminate session dialog
  bool terminateNapSession(){
    _stopAudio();
    _stopTimer();
    _audioCache.clearCache();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), ModalRoute.withName('/'));
    return true;
  }

//WillPopScope requires Future<bool> to handle back button press to terminate nap session.
  Future<bool> _confirmEnd(){
    _detectState = DetectionState.stopped;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure you want to terminate your sleep session?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () => Navigator.pop(context, terminateNapSession()),
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