import 'dart:math';

enum SleepState{
  awake,
  dozing,
  sleeping
}

class SleepStateAlgorithm{
  SleepState sleepState = SleepState.awake;
  int variableTime;
  Stopwatch timeToSleep = Stopwatch();
  int tapCount = 0;
  int missedTaps = 0;
  
  SleepStateAlgorithm(this.variableTime);

  startTimer(){
    timeToSleep.start();

    print("recordTime");
  }

  stopTimer(){
    timeToSleep.stop();

    print("checkTime");
    print(timeToSleep.elapsed);
    sleepState = SleepState.sleeping;
  }

  incrementTapCount(){
    tapCount++;
    print("Tap count: $tapCount");
  }

  incrementMissedTapsCount(){
    missedTaps++;
    print("Missed count: $missedTaps");
  }
}