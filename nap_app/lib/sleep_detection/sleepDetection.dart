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
    calcTimeBeforeEndDetection();
    checkStateChangeRequired();
  }

  calcTimeBeforeEndDetection(){
    int napLengthInSeconds = _napLength * 60;
    int napLimitInSeconds = _napLimit * 60;
    int addElapsedAndTotalLength = timeToSleep.elapsed.inSeconds + napLengthInSeconds;
    double percentOfRemainingTime = addElapsedAndTotalLength / napLimitInSeconds;
    print("Total: $percentOfRemainingTime");

    if(percentOfRemainingTime > 1.0){
      napLimitReached = true;
    }
  }

//CHECK TO SEE IF BELOW CALCULATION IS GREATER/LESS THAN SELECTED NAP LENGTH
//IF GREATER THEN SEND _NapLength. 
//IF LESS THEN SEND CALCULATION.
  int calcRemainingAlarmTime(){
    int remainingTime = (_napLength * 60) - ((_napLimit * 60) - timeToSleep.elapsed.inSeconds);
    
    if(remainingTime > _napLength){
      return _napLength;
    } 
    else{
      return remainingTime;
    }
  }

  checkStateChangeRequired(){
    print("Checking current sleep state");
    print("Current State: ${this._sleepState}");
    if(this.missedDetectionEvents > 5 && _sleepState == SleepState.awake){
      _sleepState = SleepState.dozing;
      print("State changed to 'Dozing'");
    }

    if(this.missedDetectionEvents > 10 && _sleepState == SleepState.dozing){
      _sleepState = SleepState.sleeping;
      print("State changed to 'Sleeping'");
    }

    if(_sleepState == SleepState.sleeping){
      isSleeping = true;
    }

    print("State checked, no update required");
  }
}