///
///This class does the calculations and decides if the user is asleep.
///

//Sleep state enum to allow for more complex algorithms in the future.
//Currently only awake and sleeping is being used, ideally in the future the algoritm 
//would revert back to a higher sleep state if the user starts to wake up
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

//Starts the timer for measuring how long the user takes to fall asleep.
  startTimer(){
    timeToSleep.start();
    print("Sleeping Elapsed Timer Started");
  }

//Stops the timer for measruing how long the user took to fall asleep.
//Called when the application navigates to the alarm countdown page from tapPage.dart.
  stopTimer(){
    timeToSleep.stop();
    print("Sleeping Elapsed Timer Stopped");
    print("Sleep Detection Elapsed Time: ${timeToSleep.elapsed.inSeconds}");
  }

//Method to allow for the tapPage.dart to send the information napLength and napLimit to the sleep algorithm each calculation tick.
  setNapInformation(int napLimit, int napLength){
    _napLimit = napLimit;
    _napLength = napLength;
  }

//Mathod to allow the tapPage.dart to send the updated missedTapEvents to the algorithm every calculation tick.
  updateAlgorithm(int missedDetectionEvents){
    this.missedDetectionEvents = missedDetectionEvents;
    print("Algorithm Updated");
    checkStateChangeRequired();

    if(timeToSleep.elapsed.inSeconds >= (_napLimit * 60)){
      napLimitReached = true;
    }
  }

//Method to calculate the time that should be displayed on the countdown timer.
//Called from the tapPage.dart file when the application navigates to the countdown alarm.
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

//Method to check wether the sleep state of the user needs to be changed based on how many missed tap events have occured.
//Called from within the updateAlgorithm() method in the sleepDetection.dart class.
  checkStateChangeRequired(){
    print("Checking current sleep state");
    print("Current State: ${this._sleepState}");
    if(this.missedDetectionEvents > 1 && _sleepState == SleepState.awake){
      _sleepState = SleepState.dozing;
      print("State changed to 'Dozing'");
    }

    if(this.missedDetectionEvents >= 2 && _sleepState == SleepState.dozing){
      _sleepState = SleepState.sleeping;
      print("State changed to 'Sleeping'");
    }

    if(_sleepState == SleepState.sleeping){
      isSleeping = true;
    }

    print("State checked, no update required");
  }
}