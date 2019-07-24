import 'package:flutter/material.dart';

import 'napTrackerPage.dart' as NapPage;

class NapSettings extends StatefulWidget
{
  @override 
  _NapSettingsState createState() => _NapSettingsState();
}

class _NapSettingsState extends State<NapSettings> {
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
                      
                Container(
                  height: 15,
                ),

                Container(
                  color: Colors.white,
                  height: 2,
                  width: 250,
                ),


                //Spacer
                Container(
                  height: 50,
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