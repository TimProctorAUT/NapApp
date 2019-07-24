import 'package:flutter/material.dart';

import 'napTrackerPage.dart' as NapPage;

class NapSettings extends StatefulWidget
{
  @override 
  _NapSettingsState createState() => _NapSettingsState();
}

class _NapSettingsState extends State<NapSettings> {
  bool _isDroppedDown1 = false;
  bool _isDroppedDown2 = false;
  bool _isDroppedDown3 = false;

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
                  height: (_isDroppedDown1? 100 : 50),
                  width: 300,

                  child: Row(                    
                    children: <Widget>[

                      Text('Time Settings', style: TextStyle(color: Colors.white)),
                      
                      IconButton(
                        onPressed: (){
                          
                          setState(() {
                           if(_isDroppedDown1)
                           {
                             _isDroppedDown1 = false;
                           } 
                           else
                           {
                             _isDroppedDown1 = true;
                           }

                          });
                        },
                        icon: (_isDroppedDown1? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                      )
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

                //===========================================================Alarm Settings===================================================================//

                Container(
                  color: Color.fromRGBO(30, 30, 30, 0.8),
                  height: (_isDroppedDown2? 100 : 50),
                  width: 300,

                  child: Row(
                    children: <Widget>[

                      Text('Alarm Settings', style: TextStyle(color: Colors.white)),
                      
                      IconButton(
                        onPressed: (){
                          
                          setState(() {
                           if(_isDroppedDown2)
                           {
                             _isDroppedDown2 = false;
                           } 
                           else
                           {
                             _isDroppedDown2 = true;
                           }

                          });
                        },
                        icon: (_isDroppedDown2? Icon(Icons.arrow_drop_down, color: Colors.white) : Icon(Icons.arrow_left, color: Colors.white)),
                      )
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
                  height: (_isDroppedDown3? 100 : 50),
                  width: 300,

                  child: Row(
                    children: <Widget>[

                      Text('Sleep Detection', style: TextStyle(color: Colors.white)),
                      
                      IconButton(
                        onPressed: (){
                          
                          setState(() {
                           if(_isDroppedDown3)
                           {
                             _isDroppedDown3 = false;
                           } 
                           else
                           {
                             _isDroppedDown3 = true;
                           }

                          });
                        },
                        icon: (_isDroppedDown3? Icon(Icons.arrow_drop_down, color: Colors.white,) : Icon(Icons.arrow_left, color: Colors.white)),
                      )
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
                                builder: (context) => NapPage.NapTracker()),
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