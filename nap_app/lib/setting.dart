import 'package:vibrate/vibrate.dart';

class NapSettingsData{

  final int vibrationInterval = 10;

  final int napLimit;
  final int napLength;
  final int elapsedTime;
  final FeedbackType selectedVibrate;
  
  final bool wantsAudio;
  final bool wantsAlarmAudio;
  final bool wantsAlarmVibrate;

  final String selectedAudioFile;
  final String selectedAlarmSound; //Currently alarm library doesnt support.

  List<String> encouragingMessages = [
    "Atleast you tried.",
    "Good Job!",
  ];


  //Not final because it is not instantiated when settings object is created.
  //Only set after sleep detection.
  bool successfullSleep;
  int timeSleptInSeconds;

  NapSettingsData({
    this.elapsedTime, 
    this.successfullSleep, 
    this.napLength, 
    this.napLimit,
    this.wantsAudio,
    this.selectedAudioFile,
    this.timeSleptInSeconds,
    this.selectedAlarmSound,
    this.wantsAlarmAudio,
    this.wantsAlarmVibrate,
    this.selectedVibrate
  });
}