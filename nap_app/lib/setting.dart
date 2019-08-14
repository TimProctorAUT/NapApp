class NapSettings{

  final int napLimit;
  final int napLength;
  final int elapsedTime;

  final bool isAsleep;

  //Calculating Remaining
  int calculateRemainingTime(int napLimit, int elapsedTime)
  { 
    return napLimit - elapsedTime;
  } 

  //
  asleepTest(int napLength, int napLimit, int elapsedTime)
  {
    int napDuration;
    int remainingTime = calculateRemainingTime(napLimit, elapsedTime);
    if (remainingTime >= napLength)
    {
      napDuration = napLength;
    }
    else
    {
      napDuration = remainingTime;
    }

    return napDuration;
  }

  //Get and Set Methods

  NapSettings(this.elapsedTime, this.isAsleep, this.napLength, this.napLimit);

}