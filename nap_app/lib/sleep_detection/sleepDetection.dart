enum SleepState{
  awake,
  dozing,
  sleeping
}

class SleepStateAlgorithm{
  SleepState _sleepState = SleepState.awake;
  Stopwatch timeToSleep = Stopwatch();
  int missedDetectionEvents;
  bool isSleeping = false;
  bool napLimitReached = false;
  int _napLimit = 0;
  int _napLength = 0;

  startTimer(){
    timeToSleep.start();
    print("Sleeping Elapsed Timer Started");
  }

  stopTimer(){
    timeToSleep.stop();
    print("Sleeping Elapsed Timer Stopped");
    print("Sleep Detection Elapsed Time: ${timeToSleep.elapsed.inSeconds}");
  }

  setNapInformation(int napLimit, int napLength){
    _napLimit = napLimit;
    _napLength = napLength;
  }

  updateAlgorithm(int missedDetectionEvents){
    this.missedDetectionEvents = missedDetectionEvents;
    print("Algorithm Updated");
    checkStateChangeRequired();

    if(timeToSleep.elapsed.inSeconds >= (_napLimit * 60)){
      napLimitReached = true;
    }
  }

  int calcRemainingAlarmTime(){
    int _remainingTime = (_napLimit * 60) - timeToSleep.elapsed.inSeconds;
    
    if(_remainingTime > (_napLength * 60)){
      print("_NapLength RETURNED: $_napLength");
      print("timeToSleep.elapsed.inSeconds RETURNED: ${timeToSleep.elapsed.inSeconds}");
      return (_napLength * 60);
    } 
    else{
      print("_remainingTime RETURNED: $_remainingTime");
      print("timeToSleep.elapsed.inSeconds RETURNED: ${timeToSleep.elapsed.inSeconds}");
      return _remainingTime;
    }
  }

  checkStateChangeRequired(){
    print("Checking current sleep state");
    print("Current State: ${this._sleepState}");
    if(this.missedDetectionEvents > 1 && _sleepState == SleepState.awake){
      _sleepState = SleepState.dozing;
      print("State changed to 'Dozing'");
    }

    if(this.missedDetectionEvents > 2 && _sleepState == SleepState.dozing){
      _sleepState = SleepState.sleeping;
      print("State changed to 'Sleeping'");
    }

    if(_sleepState == SleepState.sleeping){
      isSleeping = true;
    }

    print("State checked, no update required");
  }
}