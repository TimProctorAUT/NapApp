enum SleepState{
  awake,
  dozing,
  sleeping
}

class SleepStateAlgorithm{
  SleepState _sleepState = SleepState.awake;
  int variableTime;
  Stopwatch timeToSleep = Stopwatch();
  int missedDetectionEvents;
  bool isSleeping = false;
  bool napLimitReached = false;
  int napLimit;
  int napLength;

  startTimer(){
    timeToSleep.start();
    print("Timer Started");
  }

  stopTimer(){
    timeToSleep.stop();
    print("Timer Stopped");
    print(timeToSleep.elapsed);
  }

  setNapInformation(napLimit, napLength){
    napLimit = this.napLimit;
    napLength = this.napLength;
  }

  updateAlgorithm(int missedDetectionEvents){
    this.missedDetectionEvents = missedDetectionEvents;
    print("Algorithm Updated");
    checkStateChangeRequired();
  }

  checkStateChangeRequired(){
    print("Check state");
    print(this.missedDetectionEvents);
    print(this._sleepState);
    if(this.missedDetectionEvents > 2 && _sleepState == SleepState.awake){
      _sleepState = SleepState.dozing;
      print("State changed to 'Dozing'");
    }

    if(this.missedDetectionEvents > 3 && _sleepState == SleepState.dozing){
      _sleepState = SleepState.sleeping;
      print("State changed to 'Sleeping'");
    }

    if(_sleepState == SleepState.sleeping){
      isSleeping = true;
    }

    // if((timeToSleep.elapsed.inSeconds + napLength) >= (napLimit)){
    //   napLimitReached = true;
    // }

    print("State checked, no update required");
  }
}