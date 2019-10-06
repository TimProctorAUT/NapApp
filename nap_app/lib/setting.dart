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


  final String selectedAudioFile;
  final String selectedAlarmSound;

  final List<String> encouragingMessages = [
    "Atleast you tried.",
    "Good Job!",
    "Don't give up, we'll all die one day!",
    "Congratulations, You got the super rare pepe message. Nap now for successful sleep"
  ];


  //Not final because it is not instantiated when settings object is created.
  //Only set after sleep detection.
  bool dontDisplayInstructions = false;
  bool hasSavedSettings = false;

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
    this.wantsGentleWake
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
    'gentleWake' : wantsGentleWake
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
      wantsGentleWake = json['gentleWake'];
}