///
/// This class holds all user nap data for a single session and is created every time a user starts a nap session.
///

class UserNapData{
  bool successfullSleep;
  int timeSleptInSeconds;
  int timeToSleep;
  int napNumber;
  dynamic timeOfNap;

  UserNapData({this.successfullSleep, this.timeSleptInSeconds, this.timeToSleep, this.napNumber, this.timeOfNap});

//If you add anymore field variables to this model class, you need to update
//the toJson and fromJson to represent the new variables added.
//To seralize the object to JSON format.
  Map<String, dynamic> toJson () =>
  {
    'successfullSleep' : successfullSleep,
    'timeSleptInSeconds' : timeSleptInSeconds,
    'timeToSleep' : timeToSleep,
    'napNumber' : napNumber,
    'timeOfNap' : timeOfNap
  };

//To deserialze from JSON format.
  UserNapData.fromJson(Map<String,dynamic> json)
  : successfullSleep = json['successfullSleep'],
    timeSleptInSeconds = json['timeSleptInSeconds'],
    timeToSleep = json['timeToSleep'],
    napNumber = json['napNumber'],
    timeOfNap = json['timeOfNap'];
}