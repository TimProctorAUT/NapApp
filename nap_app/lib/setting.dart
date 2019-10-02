import 'package:vibrate/vibrate.dart';

class NapSettingsData{

  final int vibrationInterval;

  final int napLimit;
  final int napLength;
  final int elapsedTime;
  final FeedbackType selectedVibrate;
  
  final bool wantsAudio;
  final bool wantsAlarmAudio;
  final bool wantsAlarmVibrate;

  final String selectedAudioFile;
  final String selectedAlarmSound; //Currently alarm library doesnt support.

  final List<String> encouragingMessages = [
    "Atleast you tried.",
    "Good Job!",
  ];


  //Not final because it is not instantiated when settings object is created.
  //Only set after sleep detection.
  bool successfullSleep;
  int timeSleptInSeconds;
  bool dontDisplayInstructions = false;
  bool hasSavedSettings = false;

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
    this.selectedVibrate,
    this.dontDisplayInstructions,
    this.vibrationInterval,
    this.hasSavedSettings
  });

//If you add anymore field variables to this model class, you need to update
//the toJson and fromJson to represent the new variables added.

//To seralize the object to JSON format.
  Map<String, dynamic> toJson() =>
  {
    'vibrateInterval' : vibrationInterval,
    'napLimit' : napLimit,
    'napLength' : napLength,
    'elapsedTime' : elapsedTime,
    'selectedVibrate' : selectedVibrate,
    'wantsAudio' : wantsAudio,
    'wantsAlarmAudio' : wantsAlarmAudio,
    'wantsAlarmVibrate' : wantsAlarmVibrate,
    'selectedAudioFile' : selectedAudioFile,
    'selectedAlarmSound' : selectedAlarmSound,
    'successfullSleep' : successfullSleep,
    'timeSleptsInSeconds' : timeSleptInSeconds,
    'dontDisplayInstructions' : dontDisplayInstructions,
    'hasSavedSettings' : hasSavedSettings
  };

//To deserialze from JSON format.
  NapSettingsData.fromJson(Map<String, dynamic> json)
    : vibrationInterval = json['vibrateInterval'],
      napLimit = json['napLimit'],
      napLength = json['napLength'],
      elapsedTime = json['elapsedTime'],
      selectedVibrate = json['selectedVibrate'],
      wantsAudio = json['wantsAudio'],
      wantsAlarmAudio = json['wantsAlarmAudio'],
      wantsAlarmVibrate = json['wantsAlarmVibrate'],
      selectedAudioFile = json['selectedAudioFile'],
      selectedAlarmSound = json['selectedAlarmSound'],
      successfullSleep = json['successfullSleep'],
      timeSleptInSeconds = json['timeSleptInSeconds'],
      dontDisplayInstructions = json['dontDisplayInstructions'],
      hasSavedSettings = json['hasSavedSettings'];
}