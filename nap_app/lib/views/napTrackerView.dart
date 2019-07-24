import 'package:flutter/material.dart';

class NapTracker extends StatefulWidget
{
  @override 
  _NapTrackerState createState() => _NapTrackerState();
}

class _NapTrackerState extends State<NapTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nap Tracker'),
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
                    onPressed: (){},                 

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