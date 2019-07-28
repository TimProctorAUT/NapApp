import 'package:flutter/material.dart';
import '../sleep_detection/tapInstruction.dart' as SleepDetection;
import '../views/SettingOutputTest.dart' as TestOutput;

class NapSettings extends StatefulWidget
{
  @override 
  _NapSettingsState createState() => _NapSettingsState();
}

class _NapSettingsState extends State<NapSettings> {
  bool _isDroppedDown1 = true;
  bool _isDroppedDown2 = false;
  bool _isDroppedDown3 = false;

  int napLengthValue = 10;
  int napLimitValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nap Settings'),
      ),

      body: Card(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[            
                Container(
                  height: 50,
                ),

                Text('Nap Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
                      
                //Space      
                Container(
                  height: 15,
                ),

                //Line Divider
                Container(
                  color: Colors.white,
                  height: 2,
                  width: 300,
                ),

                //Spacer
                Container(
                  height: 30,
                ),

                //===========================================================Time Settings===================================================================//

                Container(
                  color: Color.fromRGBO(30, 30, 30, 0.8),
                  height: (_isDroppedDown1? 240 : 50),
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
                                //color: Colors.red,
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
                                //color: Colors.blue,
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
                        height: 20,
                      ),

                      //Line Divider
                      Container(
                        color: Colors.white,
                        height: 2,
                        width: 280,
                      ),
                      
                      //Spacer
                      Container(
                        height: 20,
                      ),
                    ],
                  )
                ),

                

                //===========================================================Alarm Settings===================================================================//

                Container(
                  color: Color.fromRGBO(30, 30, 30, 0.8),
                  height: (_isDroppedDown2? 200 : 50),
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

                              //Spacer
                              Container(
                                height: 20,
                              ),                                     

                              Container(
                                color: Colors.green,
                                width: 150,
                                height: 20,
                              ),

                              //Spacer
                              Container(
                                height: 25,
                              ),

                              Container(
                                color: Colors.yellow,
                                width: 150,
                                height: 20,
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
                  height: 20,
                ),

                //Line Divider
                Container(
                  color: Colors.white,
                  height: 2,
                  width: 280,
                ),
                
                //Spacer
                Container(
                  height: 20,
                ),

                //==========================================================Sleep Detection==================================================================//

                Container(
                  color: Color.fromRGBO(30, 30, 30, 0.8),
                  height: (_isDroppedDown3? 200 : 50),
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
                                    }
                                  });
                              },

                              child: Row(
                                children: <Widget>[

                                  Text('Nap Detection', style: TextStyle(color: Colors.white)),
                          
                                  (_isDroppedDown1? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
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
                                color: Colors.orange,
                                width: 150,
                                height: 20,
                              ),

                              //Spacer
                              Container(
                                height: 25,
                              ),

                              Container(
                                color: Colors.pink,
                                width: 150,
                                height: 20,
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
                  height: 20,
                ),

                //Line Divider
                Container(
                  color: Colors.white,
                  height: 2,
                  width: 280,
                ),
                
                //Spacer
                Container(
                  height: 60,
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
                                builder: (context) => TestOutput.NapTracker(napLength: napLengthValue, napLimit: napLimitValue,)
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
}