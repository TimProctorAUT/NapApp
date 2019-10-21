import 'package:vibrate/vibrate.dart';

class NapSettingsData{

  final int vibrationInterval;

  final int napLimit;
  final int napLength;
  final FeedbackType selectedVibrate;
  
  final bool wantsAudio;
  final bool wantsAlarmAudio;
  final bool wantsAlarmVibrate;
  final bool wantsGentleWake;
  final bool wantColourblindMode;
  final String selectedAudioFile;
  final String selectedAlarmSound;

//TODO update list with new messages
  static List<String> encouragingMessages = [
    "You might not have fallen asleep, but atleast you relaxed!",
    "Feeling refreshed? That's all that matters!",
    "Everytime you don't fall asleep, you're training yourself to relax.",
  ];


  //Not final because it is not instantiated when settings object is created.
  //Only set after sleep detection.
  bool dontDisplayInstructions = false;
  bool hasSavedSettings = false;
  bool defaultSettings = true;

  NapSettingsData({
    this.napLength, 
    this.napLimit,
    this.wantsAudio,
    this.selectedAudioFile,
    this.selectedAlarmSound,
    this.wantsAlarmAudio,
    this.wantsAlarmVibrate,
    this.selectedVibrate,
    this.dontDisplayInstructions,
    this.vibrationInterval,
    this.hasSavedSettings,
    this.wantsGentleWake,
    this.defaultSettings,
    this.wantColourblindMode,
  });

//If you add anymore field variables to this model class, you need to update
//the toJson and fromJson to represent the new variables added.

//To seralize the object to JSON format.
  Map<String, dynamic> toJson() =>
  {
    'vibrateInterval' : vibrationInterval,
    'napLimit' : napLimit,
    'napLength' : napLength,
    'selectedVibrate' : selectedVibrate,
    'wantsAudio' : wantsAudio,
    'wantsAlarmAudio' : wantsAlarmAudio,
    'wantsAlarmVibrate' : wantsAlarmVibrate,
    'selectedAudioFile' : selectedAudioFile,
    'selectedAlarmSound' : selectedAlarmSound,
    'dontDisplayInstructions' : dontDisplayInstructions,
    'hasSavedSettings' : hasSavedSettings,
    'gentleWake' : wantsGentleWake,
    'defaultSettings' : defaultSettings,
    'colourblindMode' : wantColourblindMode,
  };

//To deserialze from JSON format.
  NapSettingsData.fromJson(Map<String, dynamic> json)
    : vibrationInterval = json['vibrateInterval'],
      napLimit = json['napLimit'],
      napLength = json['napLength'],
      selectedVibrate = json['selectedVibrate'],
      wantsAudio = json['wantsAudio'],
      wantsAlarmAudio = json['wantsAlarmAudio'],
      wantsAlarmVibrate = json['wantsAlarmVibrate'],
      selectedAudioFile = json['selectedAudioFile'],
      selectedAlarmSound = json['selectedAlarmSound'],
      dontDisplayInstructions = json['dontDisplayInstructions'],
      hasSavedSettings = json['hasSavedSettings'],
      wantsGentleWake = json['gentleWake'],
      defaultSettings = json['defaultSettings'],
      wantColourblindMode = json['colourblindMode'];
}