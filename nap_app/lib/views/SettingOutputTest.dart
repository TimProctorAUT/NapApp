import 'package:flutter/material.dart';
import '../sleep_detection/splash.dart' as SleepDetection;

class NapTracker extends StatefulWidget
{
  final int napLength;
  final int napLimit;

  NapTracker({Key key, this.napLength, this.napLimit});

  @override 
  _NapTrackerState createState() => _NapTrackerState();
}


class _NapTrackerState extends State<NapTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Parse Test'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[

              Text("Nap Length: ${widget.napLength}"),

              Text('Nap Limit: ${widget.napLimit}'),

              //Buffer
              Container(height:20),

              Container(
                height: 50,
                width: 300,
                color: Colors.green,        
                  child:  MaterialButton(
                      child: Text('Parse To Nap Tracker'),
                      onPressed: () {            
                        Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => SleepDetection.SplashScreen()                                
                              //builder: (context) => TestOutput.NapTracker()
                              ),
                          );
                      },
                    ),
                ),
          ],)
      ],)
      
      
    );
  }
}
