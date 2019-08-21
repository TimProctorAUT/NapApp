
import 'package:flutter/material.dart';
import '../setting.dart';
import '../sleep_detection/tapInstruction.dart' as SleepDetection;
//import 'package:first_app/views/napSettingPage.dart';

class NapTracker extends StatefulWidget
{
  // final int napLength;
  // final int napLimit;
  
  // final int detectionMethod;
  // final int audioAssistOption;
  // final bool soundSwitch;
  // final bool vibrateSwitch;
  final NapSettingsData napSettings;

  //NapTracker({Key key, this.napLength, this.napLimit, this.detectionMethod, this.audioAssistOption, this.soundSwitch, this.vibrateSwitch});
  NapTracker({this.napSettings});

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

              Text("Nap Length: ${widget.napSettings.napLength}"),

              Text('Nap Limit: ${widget.napSettings.napLimit}'),
              
              Text('Background Audio: ${widget.napSettings.wantsAudio}'),

              Text('Audio File: ${widget.napSettings.selectedAudioFile}'),
              
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
                              builder: (context) => SleepDetection.SplashScreen(settings: widget.napSettings,)                                
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
