import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:first_app/fileOperations.dart';
import 'package:first_app/setting.dart';
import 'package:first_app/userNapData.dart';
import 'package:first_app/views/homePage.dart';
import 'package:first_app/views/timerPage.dart';
import 'package:flutter/material.dart'; //Required for Flutter Widgets
import 'package:intl/intl.dart';
import 'dart:async'; //Required for Timer
import 'package:vibrate/vibrate.dart'; //Required for vibrate
import 'package:audioplayers/audioplayers.dart';
import 'package:wakelock/wakelock.dart';

import '../sleepDetection.dart';

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
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static AudioPlayer _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  static AudioCache _audioCache = AudioCache(fixedPlayer: _audioPlayer);

  TapState _tapState = TapState.canTap;
  DetectionState _detectState = DetectionState.waiting;
  int tapCount = 0;
  int missedTaps = 0;
  Timer _timer;
  Timer _musicTimer;
  double _musicVolume = 1;
  bool _firstTap = true;

  UserNapData napData = UserNapData();
  FileOperations fileOps = FileOperations();

  int loopCount = 0;
  
//initstate allows any code to be run on load of this page.
  @override
  void initState() { 
    super.initState();
    Wakelock.enable();
    WidgetsBinding.instance.addObserver(this);
    loadNapNumber();
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

//Sets default napNumber to 1 if this is first nap, else it checks what files have been created and sets napnumber to that.
  loadNapNumber() async{
    //Checking to see what files exist to get the current napNumber.
    for(int i = 1; i <= 500; i++){
      File file = await FileOperations().getDataFile(i);

      if(i == 500 && await file.exists()){
        buildErrorPopup();
      }

      if(await file.exists()){
        print(file);
      }
      else{
        print("The file for nap number $i dont exist yet");
        napData.napNumber = i;
        i = 500;
      }
    }
  }

  buildErrorPopup(){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("You already have the maximum number of saved nap's.\n\nTo continue, please reset your nap data from the 'Previous Naps' page. Scroll to the bottom (below the graphs) and tap 'Reset Nap Data'."),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/'))
            ),
        ],
      )
    );
  }

//Starts the vibrate timer.
//Contains all code run on every timer tick.
  _startTimer(){
    _timer = Timer.periodic(Duration(seconds: widget.settings.vibrationInterval), (timer) {
      setState(() {
        print("~~~~~~~~~~ Loop No. $loopCount ~~~~~~~~~~");
        //This block of code will run every vibrationInterval (30) seconds.
        _ssa.setNapInformation(this.widget.settings.napLimit, this.widget.settings.napLength);
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
  _stopAudio(1);
  _ssa.stopTimer();
  updateNapData(true);
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => NapTimer(napLength: _ssa.calcRemainingAlarmTime(), napData: napData, settings: widget.settings,)), ModalRoute.withName('/'));
}

//Called when the alarm is not needed and wanting to navigate to the summary page.
  _navigateToAlarmFail(){
    _stopTimer();
    _stopAudio(1);
    _ssa.stopTimer();
    updateNapData(false);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => NapTimer(napLength: 1, napData: napData, settings: widget.settings,)), ModalRoute.withName('/'));
  }

  updateNapData(bool didSleep){
    napData.successfullSleep = didSleep;
    napData.timeToSleep = _ssa.timeToSleep.elapsed.inSeconds;
    napData.timeOfNap = DateFormat().add_yMMMd().add_Hm().format(DateTime.now());
  }

  _playAudio() async{
    try{
      _audioCache.play(this.widget.settings.selectedAudioFile + ".mp3");
    }
    catch(e){
    }
  }

  _stopAudio(int push){
//Timer to fade music out over 30 seconds when entering the alarm page.
    if(push == 1){
      _musicTimer = Timer.periodic(Duration(seconds: 2), (timer) {
        _musicVolume -= 0.2;
        _audioPlayer.setVolume(_musicVolume);

        if(_musicVolume <= 0){
          _musicTimer.cancel();
          _audioCache.fixedPlayer.stop();
        }
      });
      _audioCache.clearCache();
    }
    else{
      _audioPlayer.stop();
      _audioCache.clearCache();
    }
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
    _stopAudio(0);
    if(!_firstTap){
      _stopTimer();
    }
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
                height: 500,
                child: SafeArea(
                  child: Container(
                    color: Colors.black12,
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