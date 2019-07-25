import 'package:flutter/material.dart';
import '../sleep_detection/splash.dart' as SleepDetection;

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
        title: Text('Setting Parse Test'),
      ),
      body: Container(
        height: 50,
        width: 300,
        color: Colors.green,

        child: MaterialButton(
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
    );
  }
}