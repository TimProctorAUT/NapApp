import 'dart:math';

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

  
  SleepStateAlgorithm();

  startTimer(){
    timeToSleep.start();
    print("Timer Started");
  }

  stopTimer(){
    timeToSleep.stop();
    print("Timer Stopped");
    print(timeToSleep.elapsed);
  }

  updateAlgorithm(int missedDetectionEvents){
    this.missedDetectionEvents = missedDetectionEvents;
    print("AlgorithmUpdated");
    checkStateChangeRequired();
  }

  checkStateChangeRequired(){
    print("Chck state");
    print(this.missedDetectionEvents);
    print(this._sleepState);
    if(this.missedDetectionEvents > 5 && _sleepState == SleepState.awake){
      _sleepState = SleepState.dozing;
      print("State changed to 'Dozing'");
    }

    if(this.missedDetectionEvents > 15 && _sleepState == SleepState.dozing){
      _sleepState = SleepState.sleeping;
      print("State changed to 'Sleeping'");
    }

    print("State checked, no update required");
  }

  //THIS IS FOR DEBUGGING ONLY
  forceSleepStateDebugOnly(){
    print("this was called");
    _sleepState = SleepState.sleeping;
  }
  printSleepStateDebugOnly(){
    print(_sleepState);
  }
}