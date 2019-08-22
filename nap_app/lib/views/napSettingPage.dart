import 'dart:convert';
import 'dart:io';

import 'package:first_app/views/detectionTestPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibrate/vibrate.dart';
//import '../sleep_detection/tapInstruction.dart' as SleepDetection;
import '../views/SettingOutputTest.dart' as TestOutput;
import '../setting.dart' as Settings;

class NapSettings extends StatefulWidget
{
  @override 
  _NapSettingsState createState() => _NapSettingsState();
}

class _NapSettingsState extends State<NapSettings> {

  bool settingCard1 = false;
  bool settingCard2 = false;
  bool settingCard3 = false;
  bool settingCard4 = false;
  bool settingCard5 = false;

//TESTING TO SEE IF THIS IMPROVES USABILITY.
  bool settingCard1NeedsAttention = true;
  bool settingCard2NeedsAttention = true;
  bool settingCard3NeedsAttention = true;
  bool settingCard4NeedsAttention = true;
  bool settingCard5NeedsAttention = true;
  bool noAttentionNeeded = false;
///////////////////////////////////////////

  int napLimit = 20;
  int napLength = 10;

  int detectionMethod = 0;
  int audioAssistSetting = 2;

  bool soundSwitch = true;
  bool vibrateSwitch = true;
  bool tapPlay = true;
  
  int alarmSound = 1;
  int vibratePower = 1;

  bool backgroundAudio = false;
  String selectedAudioFile = "Meditation";

  FeedbackType selectedVibrate;

  List<String> listOfFiles = List<String>();

  @override
  void initState() {
    super.initState();
    mapAssetsToList();
  }

//Testing to see if this improves usabilitiy
  Future<bool> closeSettingsTabs() async{
    if(!settingCard1 && !settingCard2 && !settingCard3 && !settingCard4 && !settingCard5){
      return true;
    }
    else{
      setState(() {
        settingCard1 = false;
        settingCard2 = false;
        settingCard3 = false;
        settingCard4 = false;
        settingCard5 = false;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: closeSettingsTabs,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nap Settings'),
        ),

        body: Card(
          color: Color.fromRGBO(18, 18, 18, 1),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[

                  //=========Spacer Division==========//
                  Container(height: 3,),

                  //=======Setting Card Number One=======//
                  Card(
                    child: Container(
                      color: Color.fromRGBO(30, 30, 30, 0.45),

                      width: 300,
                      height: (settingCard1? 250 : 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              //==============Dropdown Button=================//
                              Container(
                                child: MaterialButton(
                                  minWidth: 250,
                                  height: 40,
                                  onPressed: (){
                                    setState(() {
                                      if(settingCard1)
                                      {
                                        settingCard1 = false;
                                      }
                                      else
                                      {
                                        settingCard1 = true;
                                        settingCard2 = false;
                                        settingCard3 = false;
                                        settingCard4 = false;
                                        settingCard5 = false;
                                        settingCard1NeedsAttention = false;

                                        if(!settingCard1NeedsAttention && !settingCard2NeedsAttention && !settingCard3NeedsAttention && !settingCard4NeedsAttention){
                                          noAttentionNeeded = true;
                                        }
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[                                    
                                      Text('Nap Times'),
                                      (settingCard1? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                                      (settingCard1NeedsAttention ? Icon(Icons.warning, color: Colors.orange,) : Icon(Icons.done, color: Colors.green,)),
                                    ],
                                  ),
                                )
                              ),       
                              //=================================================//

                              Visibility(
                                visible: settingCard1,
                                child: Column(
                                  children: <Widget>[

                                    //Line Division
                                    Container(
                                      color: Colors.white,
                                      height: 1,
                                      width: 250,
                                    ),

                                    //Spacer
                                    Container(height: 25),

                                    //===================================Nap Length=================================//
                                    Container(
                                      width: 250,
                                      height: 75,
                                      child: Column(
                                        children: <Widget>[
                                          Text('How Long Would you Like to Nap? '), 

                                          DropdownButton <int>(
                                            value: napLength,
                                            onChanged: (int newValue) {
                                              setState(() {
                                                napLength = newValue;
                                                napLimit = newValue + 10;
                                              });
      
                                            },
                                            
                                              items: <int>[5, 10, 15, 20]
                                                .map<DropdownMenuItem<int>>((int value) {
                                                  return DropdownMenuItem<int>(
                                                    value: value,
                                                    child: Text('$value minutes'),
                                                  );
                                                })
                                                .toList(),
                                          )                                
                                        ],
                                      ),
                                    ),
                                    //==============================================================================//

                                    //Spacers
                                    Container(height: 15,),

                                    //===================================Nap Length=================================//
                                    Container(
                                      width: 250,
                                      height: 75,
                                      child: Column(
                                        children: <Widget>[
                                          Text('How Long do you have to try and nap?'),    

                                          DropdownButton <int>(
                                            value: napLimit,
                                            onChanged: (int newValue) {
                                              setState(() {
                                                napLimit = newValue;
                                              }); 
                                            },                                      
                                              items: <int>[(napLength + 5), (napLength + 10), (napLength + 15), (napLength + 20)]
                                                .map<DropdownMenuItem<int>>((int value) {
                                                  return DropdownMenuItem<int>(
                                                    value: value,
                                                    child: Text('$value minutes'),
                                                  );
                                                })
                                                .toList(),
                                          )                                
                                        ],
                                      ),
                                    ),
                                    //==============================================================================//
                                
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
  
                  //=========Spacer Division==========//
                  Container(height: 2,),

                  //=======Setting Card Number Two=======//
                  Card(
                    child: Container(
                      color: Color.fromRGBO(30, 30, 30, 0.45),

                      width: 300,
                      height: (settingCard2? 250 : 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              //==============Dropdown Button=================//
                              Container(
                                child: MaterialButton(
                                  minWidth: 250,
                                  height: 40,
                                  onPressed: (){
                                    setState(() {
                                      if(settingCard2)
                                      {
                                        settingCard2 = false;
                                      }
                                      else
                                      {
                                        settingCard1 = false;
                                        settingCard2 = true;
                                        settingCard3 = false;
                                        settingCard4 = false;
                                        settingCard5 = false;
                                        settingCard2NeedsAttention = false;

                                        if(!settingCard1NeedsAttention && !settingCard2NeedsAttention && !settingCard3NeedsAttention && !settingCard4NeedsAttention){
                                          noAttentionNeeded = true;
                                        }
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[                                    
                                      Text('Sleep Detection Method'),
                                      (settingCard2? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                                      (settingCard2NeedsAttention ? Icon(Icons.warning, color: Colors.orange,) : Icon(Icons.done, color: Colors.green,)),
                                    ],
                                  ),
                                )
                              ),       
                              //=================================================//

                              Visibility(
                                visible: settingCard2,
                                child: Column(
                                  children: <Widget>[

                                    //Line Division
                                    Container(
                                      color: Colors.white,
                                      height: 1,
                                      width: 250,
                                    ),

                                    //Spacer
                                    Container(height: 20),
                                    
                                    Container(
                                      width: 250,
                                      height: 180,
                                      child: Column(
                                        children: <Widget>[                     
                                                
                                          Text('Select a Sleep Detection Method:'),

                                          //Spacer
                                          Container(height: 5),

                                          Row(
                                            children: <Widget>[
                                              Radio(
                                                onChanged: (int e) => setDetectionMethod(e),
                                                activeColor: Colors.green,
                                                value: 0,
                                                groupValue: detectionMethod,                                          
                                              ),

                                              Text('Tap Screen'),
                                            ],
                                          ),

                                          Row(
                                            children: <Widget>[
                                              Radio(
                                                onChanged: (int e) => setDetectionMethod(e),
                                                activeColor: Colors.red,
                                                value: null,
                                                groupValue: detectionMethod,                                          
                                              ),

                                              Text(' Drop Phone ', style: TextStyle(decoration: TextDecoration.lineThrough),),
                                            ],
                                          ),

                                          //Spacer
                                          Container(height: 15),
                                          Container(
                                            width: 250,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                //Button One
                                                Container(
                                                  color: Colors.white,
                                                  height: 25,
                                                  width: 150,
                                                  child: RaisedButton(
                                                    color: Colors.white,
                                                    child: Text('Test Detection', style: TextStyle(color: Colors.black),),
                                                    onPressed: () => testDetectionMethod(detectionMethod)               
                                                  ),
                                                ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),                                  
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
  

                  //=========Spacer Division==========//
                  Container(height: 2,),

                  //=======Setting Card Number Three=======//
                  Card(
                    child: Container(
                      color: Color.fromRGBO(30, 30, 30, 0.45),

                      width: 300,
                      height: (settingCard3? 250 : 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              //==============Dropdown Button=================//
                              Container(
                                child: MaterialButton(
                                  minWidth: 250,
                                  height: 40,
                                  onPressed: (){
                                    setState(() {
                                      if(settingCard3)
                                      {
                                        settingCard3 = false;
                                      }
                                      else
                                      {
                                        settingCard1 = false;
                                        settingCard2 = false;
                                        settingCard3 = true;
                                        settingCard4 = false;
                                        settingCard5 = false;
                                        settingCard3NeedsAttention = false;

                                        if(!settingCard1NeedsAttention && !settingCard2NeedsAttention && !settingCard3NeedsAttention && !settingCard4NeedsAttention){
                                          noAttentionNeeded = true;
                                        }
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[                                    
                                      Text('Alarm Settings'),
                                      (settingCard3? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                                      (settingCard3NeedsAttention ? Icon(Icons.warning, color: Colors.orange,) : Icon(Icons.done, color: Colors.green,)),
                                    ],
                                  ),
                                )
                              ),       
                              //=================================================//

                              Visibility(
                                visible: settingCard3,
                                child: Column(
                                  children: <Widget>[

                                    //Line Division
                                    Container(
                                      color: Colors.white,
                                      height: 1,
                                      width: 250,
                                    ),

                                    //Spacer
                                    Container(height: 5),

                                    Container(
                                      //color: Colors.green,
                                      width: 200,
                                      height: 96,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text('Sound'),

                                              Switch(
                                                value: soundSwitch,
                                                onChanged: (value)
                                                {
                                                  setState(() {
                                                    soundSwitch = value;

                                                    if(!soundSwitch){
                                                      FlutterRingtonePlayer.stop();
                                                    }
                                                  });
                                                },

                                                activeColor: Colors.green,
                                                activeTrackColor: Colors.lightGreen,

                                                inactiveThumbColor: Colors.blueGrey,
                                                inactiveTrackColor: Colors.blueGrey,
                                              ),
                                              Container(
                                                width: 96,
                                                child: RaisedButton(
                                                  color: Colors.white,
                                                  child: tapPlay ? Text("Test Alarm", style: TextStyle(color: Colors.black, fontSize: 11),) : Text("Stop", style: TextStyle(color: Colors.black, fontSize: 11)),
                                                  onPressed: soundSwitch ? testAlarmSound : null
                                                ),
                                              ),
                                            ],
                                          ),                                  

                                          Row(
                                            children: <Widget>[
                                              Text(
                                                'Alarm Sound Choices',
                                                style: TextStyle(color: soundSwitch? Colors.white : Colors.grey),
                                              ),

                                              Container(width: 15),

                                              DropdownButton <int>(
                                                value: alarmSound,
                                                onChanged: (soundSwitch? (int newValue) {setState(() {alarmSound = newValue;}); } : null ),
                                                                                        
                                                items: <int>[(1), (2), (3), (4)]
                                                  
                                                .map<DropdownMenuItem<int>>((int value) {
                                                  return DropdownMenuItem<int>(
                                                    value: value,
                                                    child: Text('$value'),
                                                  );
                                                }) .toList(),
                                              )                              
                                        ],
                                      ),                                  
                                    ],
                                  )
                                ),

                                Container(
                                  //color: Colors.green,
                                  width: 200,
                                  height: 96,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text('Vibrate'),

                                          Switch(
                                            value: vibrateSwitch,
                                            onChanged: (value)
                                            {
                                              setState(() {
                                                vibrateSwitch = value;
                                              });
                                              
                                            },

                                            activeColor: Colors.green,
                                            activeTrackColor: Colors.lightGreen,

                                            inactiveThumbColor: Colors.blueGrey,
                                            inactiveTrackColor: Colors.blueGrey,
                                          ),
                                          Container(
                                            width: 96,
                                            child: RaisedButton(
                                              color: Colors.white,
                                              child: Text("Test Vibrate", style: TextStyle(color: Colors.black, fontSize: 11),),
                                              onPressed: vibrateSwitch ? testVibrate : null
                                            ),
                                          ),
                                        ],
                                      ),                                  

                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Vibrate Settings',
                                            style: TextStyle(color: vibrateSwitch? Colors.white : Colors.grey),
                                          ),

                                          Container(width: 15),

                                          DropdownButton <int>(
                                            value: vibratePower,
                                            onChanged: (vibrateSwitch? (int newValue) {setState(() {vibratePower = newValue;}); } : null ),
                                                                                    
                                            items: <int>[(1), (2), (3), (4), (5), (6), (7), (8)]
                                              
                                            .map<DropdownMenuItem<int>>((int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Text('$value'),
                                              );
                                            }) .toList(),
                                          )                              
                                    ],
                                  ),
                                                                      
                                ],
                              )
                            ),

                                   
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  //=========Spacer Division==========//
                  Container(height: 2,),

                  //=======Setting Card Number Four=======//
                  Card(
                    child: Container(
                      color: Color.fromRGBO(30, 30, 30, 0.45),

                      width: 300,
                      height: (settingCard4? 250 : 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              //==============Dropdown Button=================//
                              Container(
                                child: MaterialButton(
                                  minWidth: 250,
                                  height: 40,
                                  onPressed: (){
                                    setState(() {
                                      if(settingCard4)
                                      {
                                        settingCard4 = false;
                                      }
                                      else
                                      {
                                        settingCard1 = false;
                                        settingCard2 = false;
                                        settingCard3 = false;
                                        settingCard4 = true;
                                        settingCard5 = false;
                                        settingCard4NeedsAttention = false;

                                        if(!settingCard1NeedsAttention && !settingCard2NeedsAttention && !settingCard3NeedsAttention && !settingCard4NeedsAttention){
                                          noAttentionNeeded = true;
                                        }
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[                                    
                                      Text('Audio Assistance'),
                                      (settingCard4? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                                      (settingCard4NeedsAttention ? Icon(Icons.warning, color: Colors.orange,) : Icon(Icons.done, color: Colors.green,)),
                                    ],
                                  ),
                                )
                              ),       
                              //=================================================//

                              Visibility(
                                visible: settingCard4,
                                child: Column(
                                  children: <Widget>[

                                    //Line Division
                                    Container(
                                      color: Colors.white,
                                      height: 1,
                                      width: 250,
                                    ),

                                    //Spacer
                                    Container(height: 15),

                                    Container(
                                      width: 250,
                                      height: 180,
                                      child: Column(
                                        children: <Widget>[                                    
                                          Text('Audio Assistance:'),
                                          
                                          //TOGGLE SWITCH FOR WANTING TO LISTEN TO AUDIO DURING NAP
                                          Row(
                                            children: <Widget>[
                                              Text("Background Audio"),
                                              Switch(
                                                value: backgroundAudio,
                                                onChanged: (value)
                                                {
                                                  setState(() {
                                                    backgroundAudio = value;
                                                  });
                                                  
                                                },

                                                activeColor: Colors.green,
                                                activeTrackColor: Colors.lightGreen,

                                                inactiveThumbColor: Colors.blueGrey,
                                                inactiveTrackColor: Colors.blueGrey,
                                              ),
                                            ],
                                          ),

                                          //DROP DOWN MENU FOR AUDIO SELECTION
                                          Row(
                                            children: <Widget>[
                                              Text("Audio File"),
                                              
                                              Container(width: 15,),

                                              DropdownButton <String>(
                                                disabledHint: Text("Audio Disabled"),
                                                value: selectedAudioFile,
                                                onChanged: (String newValue){
                                                  setState(() {
                                                    selectedAudioFile = newValue;
                                                  });
                                                },
                                                items: backgroundAudio ? listOfFiles.map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                })
                                                .toList() : null,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  //=========Spacer Division==========//
                  Container(height: 2,),

                  //=======Setting Card Number Five=======//
                  Card(
                    child: Container(
                      color: Color.fromRGBO(30, 30, 30, 0.45),

                      width: 300,
                      height: (settingCard5? 250 : 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              //==============Dropdown Button=================//
                              Container(
                                child: MaterialButton(
                                  minWidth: 250,
                                  height: 40,
                                  onPressed: (){
                                    setState(() {
                                      if(settingCard5)
                                      {
                                        settingCard5 = false;
                                      }
                                      else
                                      {
                                        settingCard1 = false;
                                        settingCard2 = false;
                                        settingCard3 = false;
                                        settingCard4 = false;
                                        settingCard5 = true;
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[                                    
                                      Text('Volume Setting'),
                                      (settingCard5? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                                    ],
                                  ),
                                )
                              ),       
                              //=================================================//

                              Visibility(
                                visible: settingCard5,
                                child: Column(
                                  children: <Widget>[

                                    //Line Division
                                    Container(
                                      color: Colors.white,
                                      height: 1,
                                      width: 250,
                                    ),

                                    //Spacer
                                    Container(height: 20),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),        
        ),

        bottomNavigationBar: BottomAppBar(
          child:  RaisedButton(
                    color: noAttentionNeeded ? Colors.green : Colors.white,
                    textColor: Colors.black,
                    padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
                    child: Text('Start Nap'),
                    onPressed: () => navigateToNap()
                  ),
        ),
      ),
    );
  }

  testDetectionMethod(int methodSelected){
    Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => DetectionTest(detectionMethod: methodSelected,)                                
      ),
    ); 
  }

  navigateToNap(){
    Settings.NapSettingsData settingsObject = Settings.NapSettingsData(
      napLimit: napLimit, 
      napLength: napLength, 
      wantsAudio: backgroundAudio, 
      selectedAudioFile: selectedAudioFile, 
      wantsAlarmAudio: soundSwitch, 
      wantsAlarmVibrate: vibrateSwitch,
      selectedVibrate: selectedVibrate);
    Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => TestOutput.NapTracker(napSettings: settingsObject,)                                
      ),
    ); 
  }

  testVibrate(){
    setState(() {
      switch(vibratePower){
        case 1:
          Vibrate.feedback(FeedbackType.error);
          selectedVibrate = FeedbackType.error;
        break;

        case 2:
          Vibrate.feedback(FeedbackType.heavy);
          selectedVibrate = FeedbackType.heavy;
        break;

        case 3:
          Vibrate.feedback(FeedbackType.impact);
          selectedVibrate = FeedbackType.impact;
        break;

        case 4:
          Vibrate.feedback(FeedbackType.light);
          selectedVibrate = FeedbackType.light;
        break;

        case 5:
          Vibrate.feedback(FeedbackType.medium);
          selectedVibrate = FeedbackType.medium;
        break;

        case 6:
          Vibrate.feedback(FeedbackType.selection);
          selectedVibrate = FeedbackType.selection;
        break;

        case 7:
          Vibrate.feedback(FeedbackType.success);
          selectedVibrate = FeedbackType.success;
        break;

        case 8:
          Vibrate.feedback(FeedbackType.warning);
          selectedVibrate = FeedbackType.warning;
        break;
      }
    });
  }

  testAlarmSound(){
    setState(() {
      if(tapPlay){
        FlutterRingtonePlayer.playAlarm();
        tapPlay = false;
      }
      else{
        tapPlay = true;
        FlutterRingtonePlayer.stop();
      }
    });
  }

//Maps audio file assets in the /assets/ folder to a list.
  mapAssetsToList() async{
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final soundPaths = manifestMap.keys
      .where((String key) => key.contains('assets/'))
      .where((String key) => key.contains('.mp3'))
      .toList();

    for(String fileName in soundPaths){
      List<String> tmpList = fileName.split(RegExp("([./])"));
      listOfFiles.add(tmpList[1]);
    }

    print(listOfFiles);
  }

  void setDetectionMethod(int e){
    setState((){
      if (e == 0){detectionMethod = 0;}
      else if (e == 0){detectionMethod = 1;}
      else if (e == 0){detectionMethod = 2;}
    });
  }
  
 
  void setAudioSetting(int e){
    setState((){
      if (e == 0){audioAssistSetting = 0;}
      else if (e == 0){audioAssistSetting = 1;}
      else if (e == 0){audioAssistSetting = 2;}
    });
  }
}