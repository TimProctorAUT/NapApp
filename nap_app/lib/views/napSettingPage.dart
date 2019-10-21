import 'dart:convert';
import 'package:first_app/fileOperations.dart';
import 'package:first_app/views/homePage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../setting.dart' as Settings;

class NapSettings extends StatefulWidget
{
  final Settings.NapSettingsData napSettings;
  NapSettings({this.napSettings});

  @override 
  _NapSettingsState createState() => _NapSettingsState();
}

class _NapSettingsState extends State<NapSettings> {

  bool settingCard1 = true;
  bool settingCard2 = false;
  bool settingCard3 = false;
  bool settingCard4 = false;
  bool settingCard5 = false;

  int napLimit = 10;
  int napLength = 20;

  bool gentleWake = false;
  bool showInstructions = true;
  bool tapPlay = true;
  bool colorblindMode = false;

  bool backgroundAudio;
  String selectedAudioFile = "Meditation";

  List<String> listOfFiles = List<String>();
  Settings.NapSettingsData settingsObject;
  dynamic napSettings;

  FileOperations fileOps = FileOperations();

  @override
  void initState() {
    super.initState();
    mapAssetsToList();
    loadSettings();
  }

  loadSettings(){
    napLimit = widget.napSettings.napLimit;
    napLength = widget.napSettings.napLength;
    showInstructions = widget.napSettings.dontDisplayInstructions;
    backgroundAudio = widget.napSettings.wantsAudio;
    colorblindMode = widget.napSettings.wantColourblindMode;
    
    print(widget.napSettings.wantsAlarmAudio);
    print(widget.napSettings.wantsGentleWake);

    if(widget.napSettings.wantsAlarmAudio == null){
      gentleWake = true;
    }
    else{
      gentleWake = widget.napSettings.wantsGentleWake;
    }
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
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[                                    
                                      Text('Nap Times'),
                                      (settingCard1? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),                                    ],
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
                                          Text('Desired Nap Length'), 

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
                                          Text('Time Available for Nap'),    

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
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[                                    
                                      Text('Accessibility Options'),
                                      (settingCard2? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
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

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('View Instruction\'s Page'),

                                              Switch(
                                                value: !showInstructions,
                                                onChanged: (value)
                                                {
                                                  setState(() {
                                                    showInstructions = !value;
                                                  });
                                                  
                                                },

                                                activeColor: Colors.green,
                                                activeTrackColor: Colors.lightGreen,

                                                inactiveThumbColor: Colors.blueGrey,
                                                inactiveTrackColor: Colors.blueGrey,
                                              ),
                                            ],
                                          ), 

                                          //Spacer
                                          Container(height: 15),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('Colourblind Mode'),

                                              Switch(
                                                value: colorblindMode,
                                                onChanged: (value)
                                                {
                                                  setState(() {
                                                    colorblindMode = value;
                                                  });
                                                  
                                                },

                                                activeColor: Colors.green,
                                                activeTrackColor: Colors.lightGreen,

                                                inactiveThumbColor: Colors.blueGrey,
                                                inactiveTrackColor: Colors.blueGrey,
                                              ),
                                            ],
                                          ),

                                          //Spacer
                                          Container(height: 15),
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
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[                                    
                                      Text('Alarm Settings'),
                                      (settingCard3? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
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
                                    Container(height: 15),

                                    Container(
                                      width: 200,
                                      height: 150,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 96,
                                                child: RaisedButton(
                                                  color: Colors.white,
                                                  child: tapPlay ? Text("Test Alarm", style: TextStyle(color: Colors.black, fontSize: 11),) : Text("Stop", style: TextStyle(color: Colors.black, fontSize: 11)),
                                                  onPressed: testAlarmSound
                                                ),
                                              ),
                                            ],
                                          ),

                                      //Container(height: 5,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('Gentle Wake'),
                                          Text("*", style: TextStyle(color: Colors.red),),

                                          Switch(
                                            value: gentleWake,
                                            onChanged: (value)
                                            {
                                              setState(() {                                              
                                                gentleWake = value;
                                              });
                                            },

                                            activeColor: Colors.green,
                                            activeTrackColor: Colors.lightGreen,

                                            inactiveThumbColor: Colors.blueGrey,
                                            inactiveTrackColor: Colors.blueGrey,
                                          ),
                                        ],
                                      ),
                                      
                                      Spacer(),
                                      //TODO update this message once testing on this has concluded.
                                      Text("*Gentle Wake option only works on android version 9 and above.", style: TextStyle(color: Colors.red, fontSize: 10),)
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
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[                                    
                                      Text('Background Audio'),
                                      (settingCard4? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
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
                                              backgroundAudio ? Text("Audio File") : Container(),
                                              
                                              Container(width: 15,),

                                              backgroundAudio ? DropdownButton <String>(
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
                                              ) : Container()
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
                  
                  Spacer(),
                  Spacer(),
                  Spacer(),

                  RaisedButton(
                    color: Colors.green,
                    textColor: Colors.black,
                    padding: EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                    child: Text('Save Settings'),
                    onPressed: () => saveToFile()
                  ),

                  Spacer(),

                  FlatButton(
                    color: Color.fromRGBO(30, 30, 30, 0.45),
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
                    child: Text('Default Settings'),
                    onPressed: () => deleteDialog()
                  ),

                  Spacer(),
                ],
              ),
            ],
          ),        
        ),
      ),
    );
  }

  deleteDialog(){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("You are about to reset your saved settings.\n\nAre you sure you wish to continue?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: (){
              deleteSettings();
            }
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }

  deleteSettings(){
    fileOps.deleteFile();

    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
          builder: (context) => HomeScreen()                              
      ), ModalRoute.withName('/')
    );
  }

  saveToFile() async{
    settingsObject = Settings.NapSettingsData(
      napLimit: napLimit, 
      napLength: napLength, 
      wantsAudio: backgroundAudio, 
      selectedAudioFile: selectedAudioFile, 
      wantsGentleWake: gentleWake, 
      dontDisplayInstructions: showInstructions,
      vibrationInterval: 30,
      hasSavedSettings: true,
      wantColourblindMode: colorblindMode,
    );

    fileOps.writeSettings(jsonEncode(settingsObject));

    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
          builder: (context) => HomeScreen()                              
      ), ModalRoute.withName('/')
    );
    
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Your settings have been saved!\n\nThese settings will be used anytime you start a quick nap. \n\nTo change these settings please tap on the 'Nap Setup' button and reconfigure your nap!."),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: (){
              Navigator.pop(context);
            }
          )
        ],
      )
    );
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
}