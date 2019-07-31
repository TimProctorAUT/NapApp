import 'package:first_app/views/napSettingPage.dart';
import 'package:flutter/material.dart';
//import '../sleep_detection/splash.dart' as SleepDetection;

class NapTracker extends StatefulWidget
{
  final int napLength;
  final int napLimit;

  final DETECTION_METHODS detectionMethod;
  final AUDIO_SETTINGS audioAssistOption;
  final bool soundSwitch;
  final bool vibrateSwitch;

  NapTracker({Key key, this.napLength, this.napLimit, this.detectionMethod, this.audioAssistOption, this.soundSwitch, this.vibrateSwitch});

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
              
              Text('Detection Method: ${widget.detectionMethod}'),

              Text('Audio Assist Option: ${widget.audioAssistOption}'),
              
              Text('Sound Switch: ${widget.soundSwitch}'),
              
              Text('Vibrate Switch: ${widget.vibrateSwitch}'),

              //Buffer
              Container(height:20),

              Container(
                height: 50,
                width: 300,
                color: Colors.green,        
                  child:  MaterialButton(
                      child: Text('Parse To Nap Tracker'),
                      onPressed: () {            
                        // Navigator.push(context,
                        //   MaterialPageRoute(
                        //       //builder: (context) => SleepDetection.SplashScreen()                                
                        //       //builder: (context) => TestOutput.NapTracker()
                        //       ),
                        //   );
                      },
                    ),
                ),
          ],)
      ],)
      
      
    );
  }
}
