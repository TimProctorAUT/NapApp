///
///This class holds the current session nap settings for the application.
///Not all the settings here are being utilized.
///
///Unused Settings:
///   wantsAlarmAudio
///   selectedVibrate
///   musicFade
///   selectedAlarmSound
///
///The settings are set up to be used however the development ran out of time and utlimately fell outside the scope of the project.
///To implement these settings they need to be added to the toJson and fromJson methods below in this class, aswell as inside the fileOperations.dart file.
///

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
  final bool musicFade;
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
    this.musicFade
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
    'musicFade' : musicFade,
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
      wantColourblindMode = json['colourblindMode'],
      musicFade = json['musicFade'];
}