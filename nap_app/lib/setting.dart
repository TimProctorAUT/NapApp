class NapSettingsData{

  final int napLimit;
  final int napLength;
  final int elapsedTime;
  
  final bool wantsAudio;

  final String selectedAudioFile;


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
  });
}