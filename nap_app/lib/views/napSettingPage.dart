import 'package:flutter/material.dart';
import '../sleep_detection/tapInstruction.dart' as SleepDetection;
import '../views/SettingOutputTest.dart' as TestOutput;

enum AUDIO_SETTINGS{no_sound, white_noise, breathing_exercise}

enum DETECTION_METHODS{tap_method, drop_method, shake_method}

class NapSettings extends StatefulWidget
{
  @override 
  _NapSettingsState createState() => _NapSettingsState();
}

class _NapSettingsState extends State<NapSettings> {
  bool _isDroppedDown1 = true;
  bool _isDroppedDown2 = false;
  bool _isDroppedDown3 = false;
  bool _isDroppedDown4 = false;

  int napLengthValue = 10;
  int napLimitValue = 20;

  int alarmSound = 1;
  int vibratePower = 1;

  DETECTION_METHODS detectionMethod = DETECTION_METHODS.tap_method;
  AUDIO_SETTINGS audioAssistOption = AUDIO_SETTINGS.no_sound;
  
  bool soundSwitch = true;
  bool vibrateSwitch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  height: 30,
                ),

                Text('Nap Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
                      
                //Space      
                Container(
                  height: 10,
                ),

                //Line Divider
                Container(
                  color: Colors.white,
                  height: 2,
                  width: 300,
                ),

                //Spacer
                Container(
                  height: 15,
                ),

                //===========================================================Time Settings===================================================================//

                Container(
                  color: Color.fromRGBO(30, 30, 30, 0.8),
                  height: (_isDroppedDown1? 255 : 50),
                  width: 300,

                  child: Column(
                    children: <Widget>[

                      Row(          
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,              
                        children: <Widget>[
                          Container(                            
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: MaterialButton(
                              onPressed: (){
                                    setState(() {
                                    if(_isDroppedDown1)
                                    {
                                      _isDroppedDown1 = false;
                                    } 
                                    else
                                    {
                                      _isDroppedDown1 = true;
                                      _isDroppedDown2 = false;
                                      _isDroppedDown3 = false;
                                      _isDroppedDown4 = false;
                                    }
                                  });
                              },

                              child: Row(
                                children: <Widget>[

                                  Text('Time Settings', style: TextStyle(color: Colors.white)),
                          
                                  (_isDroppedDown1? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                              ],
                            )
                            ),
                            
                          ),                   
                        ],
                      ),     

                      Visibility(
                        visible: _isDroppedDown1,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              //Line Divider
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: 250,
                              ),

                              //Spacer
                              Container(
                                height: 15,
                              ),                                     

                              Container(
                                width: 250,
                                height: 75,
                                child: Column(
                                  children: <Widget>[
                                    Text('How Long Would you Like to Nap? '), 

                                    DropdownButton <int>(
                                      value: napLengthValue,
                                      onChanged: (int newValue) {
                                        setState(() {
                                          napLengthValue = newValue;
                                          napLimitValue = newValue + 10;
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

                              //Spacer
                              Container(
                                height: 15,
                              ),

                              Container(
                                width: 250,
                                height: 75,
                                child: Column(
                                  children: <Widget>[
                                    Text('How Long do you have to try and nap?'),    

                                    DropdownButton <int>(
                                      value: napLimitValue,
                                      onChanged: (int newValue) {
                                        setState(() {
                                          napLimitValue = newValue;
                                        });
 
                                      },
                                      
                                        items: <int>[(napLengthValue + 5), (napLengthValue + 10), (napLengthValue + 15), (napLengthValue + 20)]
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
                            ],
                          ),
                        ),                     
                      ),
                      
                    ],  
                  ),
                ),

                //===========================================================================================================================================//

                Container(
                  child: Column(
                    children: <Widget>[
                      //Spacer
                      Container(
                        height: 10,
                      ),

                      //Line Divider
                      Container(
                        color: Colors.white,
                        height: 2,
                        width: 280,
                      ),
                      
                      //Spacer
                      Container(
                        height: 15,
                      ),
                    ],
                  )
                ),
                //===========================================================Alarm Settings===================================================================//

                Container(
                  color: Color.fromRGBO(30, 30, 30, 0.8),
                  height: (_isDroppedDown2? 260 : 50),
                  width: 300,

                  child: Column(
                    children: <Widget>[

                      Row(          
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,              
                        children: <Widget>[
                          Container(                            
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: MaterialButton(
                              onPressed: (){
                                    setState(() {
                                    if(_isDroppedDown2)
                                    {
                                      _isDroppedDown2 = false;
                                    } 
                                    else
                                    {
                                      _isDroppedDown1 = false;
                                      _isDroppedDown2 = true;
                                      _isDroppedDown3 = false;
                                      _isDroppedDown4 = false;
                                    }
                                  });
                              },

                              child: Row(
                                children: <Widget>[

                                  Text('Alarm Settings', style: TextStyle(color: Colors.white)),
                          
                                  (_isDroppedDown2? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                              ],
                            )
                            ),
                            
                          ),                   
                        ],
                      ),     

                      Visibility(
                        visible: _isDroppedDown2,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              //Line Divider
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: 250,
                              ),
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
                                            });
                                            
                                          },

                                          activeColor: Colors.green,
                                          activeTrackColor: Colors.lightGreen,

                                          inactiveThumbColor: Colors.blueGrey,
                                          inactiveTrackColor: Colors.blueGrey,
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

                              //Spacer
                              Container(
                                height: 15,
                              ),

                              Container(
                                //color: Colors.yellow,
                                width: 200,
                                height: 96 ,
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
                                      ],
                                    ),                                               

                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Vibrate Power',
                                          style: TextStyle(color: vibrateSwitch? Colors.white : Colors.grey),
                                        ),

                                        Container(width: 15),

                                        DropdownButton <int>(
                                          value: vibratePower,
                                          onChanged: (vibrateSwitch? (int newValue) {setState(() {vibratePower = newValue;}); } : null ),
                                          

                                        
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
                            ],
                          ),
                        ),                     
                      ),

                    ],  
                  ),
                ),

                //===========================================================================================================================================//
                
                 //Spacer
                Container(
                  height: 10,
                ),

                //Line Divider
                Container(
                  color: Colors.white,
                  height: 2,
                  width: 280,
                ),
                
                //Spacer
                Container(
                  height: 15,
                ),

                //==========================================================Sleep Detection==================================================================//

                Container(
                  color: Color.fromRGBO(30, 30, 30, 0.8),
                  height: (_isDroppedDown3? 255 : 50),
                  width: 300,

                  child: Column(
                    children: <Widget>[

                      Row(          
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,              
                        children: <Widget>[
                          Container(                            
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: MaterialButton(
                              onPressed: (){
                                    setState(() {
                                    if(_isDroppedDown3)
                                    {
                                      _isDroppedDown3 = false;
                                    } 
                                    else
                                    {
                                      _isDroppedDown1 = false;
                                      _isDroppedDown2 = false;
                                      _isDroppedDown3 = true;
                                      _isDroppedDown4 = false;
                                    }
                                  });
                              },

                              child: Row(
                                children: <Widget>[

                                  Text('Nap Detection', style: TextStyle(color: Colors.white)),
                          
                                  (_isDroppedDown3? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                              ],
                            )
                            ),                            
                          ),                   
                        ],
                      ),     

                      Visibility(
                        visible: _isDroppedDown3,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              //Line Divider
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: 250,
                              ),

                              //Spacer
                              Container(
                                height: 20,
                              ),                        

                              Container(
                                width: 250,
                                height: 112,
                                child: Column(
                                  children: <Widget>[                                    
                                    Text('Select a Sleep Detection Method:'),

                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          onChanged: (DETECTION_METHODS e) => setDetectionMethod(e),
                                          activeColor: Colors.green,
                                          value: DETECTION_METHODS.tap_method,
                                          groupValue: detectionMethod,                                          
                                        ),

                                        Text('Tap Screen'),
                                      ],
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          onChanged: (DETECTION_METHODS e) => setDetectionMethod(e),
                                          activeColor: Colors.red,
                                          value: null,
                                          groupValue: detectionMethod,                                          
                                        ),

                                        Text('Drop Phone', style: TextStyle(decoration: TextDecoration.lineThrough),),
                                      ],
                                    ),

                                  ],
                                ),

                              ),

                              //Spacer
                              Container(
                                height: 25,
                              ),

                              Container(
                                width: 250,
                                height: 25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //Button One
                                    Container(
                                      color: Colors.white,
                                      height: 30,
                                      width: 150,
                                      child: MaterialButton(
                                        child: Text('Test Detection', style: TextStyle(color: Colors.black),),
                                        onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SleepDetection.SplashScreen()                                
                                                
                                                ),
                                            );
                                        }                 
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),                     
                      ),
                    ],  
                  ),

                ),

                //===========================================================================================================================================//

                //Spacer
                Container(
                  height: 10,
                ),

                //Line Divider
                Container(
                  color: Colors.white,
                  height: 2,
                  width: 280,
                ),
                
                //Spacer
                Container(
                  height: 15,
                ),

                //==============================================================Audio Setting===========================================================================//

                Container(
                  color: Color.fromRGBO(30, 30, 30, 0.8),
                  height: (_isDroppedDown4? 255 : 50),
                  width: 300,

                  child: Column(
                    children: <Widget>[

                      Row(          
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,              
                        children: <Widget>[
                          Container(                            
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: MaterialButton(
                              onPressed: (){
                                    setState(() {
                                    if(_isDroppedDown4)
                                    {
                                      _isDroppedDown4 = false;
                                    } 
                                    else
                                    {
                                      _isDroppedDown1 = false;
                                      _isDroppedDown2 = false;
                                      _isDroppedDown3 = false;
                                      _isDroppedDown4 = true;
                                    }
                                  });
                              },

                              child: Row(
                                children: <Widget>[

                                  Text('Audio Settings', style: TextStyle(color: Colors.white)),
                          
                                  (_isDroppedDown4? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                              ],
                            )
                            ),                            
                          ),                   
                        ],
                      ),     

                      Visibility(
                        visible: _isDroppedDown4,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              //Line Divider
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: 250,
                              ),

                              //Spacer
                              Container(
                                height: 20,
                              ),                        

                              Container(
                                width: 250,
                                height: 180,
                                child: Column(
                                  children: <Widget>[                                    
                                    Text('Audio Assistance:'),

                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          onChanged: (AUDIO_SETTINGS e) => setAudioSetting(e),
                                          activeColor: Colors.green,
                                          value: AUDIO_SETTINGS.breathing_exercise,
                                          groupValue: audioAssistOption,                                          
                                        ),

                                        Text('Breathing Exercise'),
                                      ],
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          onChanged: (AUDIO_SETTINGS e) => setAudioSetting(e),
                                          activeColor: Colors.green,
                                          value: AUDIO_SETTINGS.white_noise,
                                          groupValue: audioAssistOption,                                          
                                        ),

                                        Text('White Noise'),
                                      ],
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          onChanged: (AUDIO_SETTINGS e) => setAudioSetting(e),
                                          activeColor: Colors.green,
                                          value: AUDIO_SETTINGS.no_sound,
                                          groupValue: audioAssistOption,                                          
                                        ),

                                        Text('No Sound'),
                                      ],
                                    ),

                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),                     
                      ),
                    ],  
                  ),

                ),

                //=======================================================================================================================================================

                //Spacer
                Container(
                  height: 10,
                ),

                //Line Divider
                Container(
                  color: Colors.white,
                  height: 2,
                  width: 280,
                ),
                
                //Spacer
                Container(
                  height: 15,
                ),
                Container(
                  color: Colors.white,
                  width: 200,

                  child: MaterialButton(
                    child: Text('Start Nap', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)),
                    onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                //builder: (context) => SleepDetection.SplashScreen()                              
                                builder: (context) => TestOutput.NapTracker(napLength: napLengthValue, napLimit: napLimitValue, detectionMethod: detectionMethod, audioAssistOption: audioAssistOption, soundSwitch: soundSwitch, vibrateSwitch: vibrateSwitch,)
                                ),
                            );
                    }                 

                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //METHODS 

  void setDetectionMethod(DETECTION_METHODS e)
  {
    setState((){
      if (e == DETECTION_METHODS.tap_method){detectionMethod = DETECTION_METHODS.tap_method;}
      else if (e == DETECTION_METHODS.drop_method){detectionMethod = DETECTION_METHODS.drop_method;}
      else if (e == DETECTION_METHODS.shake_method){detectionMethod = DETECTION_METHODS.shake_method;}
    });
  }

  void setAudioSetting(AUDIO_SETTINGS e)
  {
    setState((){
      if (e == AUDIO_SETTINGS.no_sound){audioAssistOption = AUDIO_SETTINGS.no_sound;}
      else if (e == AUDIO_SETTINGS.white_noise){audioAssistOption = AUDIO_SETTINGS.white_noise;}
      else if (e == AUDIO_SETTINGS.breathing_exercise){audioAssistOption = AUDIO_SETTINGS.breathing_exercise;}
    });
  }
}