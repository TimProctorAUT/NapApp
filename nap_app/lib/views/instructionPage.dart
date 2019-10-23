import 'dart:convert';

import 'package:first_app/fileOperations.dart';
import 'package:first_app/setting.dart';
import 'package:flutter/material.dart';
import 'tapPage.dart';

class SplashScreen extends StatefulWidget {

  final NapSettingsData settings;

  const SplashScreen({this.settings});

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FileOperations fileOps = FileOperations();

  saveToFile() async{
    fileOps.writeSettings(jsonEncode(widget.settings));
  }

  dialogBuilder(){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("You have opted to not display the instructions anymore.\n\nTo enable the instructions again, please visit the 'Nap Setup' from the homepage and re-enable from the accessibility tab."),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Don't Display Again", style: Theme.of(context).textTheme.body1,),
            ],
          ),
          
          Switch(
            value: widget.settings.dontDisplayInstructions,
            onChanged: (value){
              setState(() {
                widget.settings.dontDisplayInstructions = value;
                saveToFile();



                print(value);

                if(value){
                  dialogBuilder();
                }
              });
            },

            activeColor: Colors.green,
            activeTrackColor: Colors.lightGreen,

            inactiveThumbColor: Colors.blueGrey,
            inactiveTrackColor: Colors.blueGrey,
          )
        ],
      ),
      body: Container(
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Sleep Detection Instructions", style: Theme.of(context).textTheme.title),
                Padding(
                  padding: EdgeInsets.all(16),
                ),
                Text("1. Tap Screen to Start", style: Theme.of(context).textTheme.title,),
                Text("2. Place Finger on the 'TAP' Text in the center of the Screen.", style: Theme.of(context).textTheme.title,),
                Text("2. Wait for Vibration", style: Theme.of(context).textTheme.title,),
                Text("3. Tap Screen and Leave Finger on the Screen.", style: Theme.of(context).textTheme.title,),
                Text("4. Repeat Until Asleep", style: Theme.of(context).textTheme.title,),
                Padding(
                  padding: EdgeInsets.all(16),
                ),
                Text("Tap Anywhere to Start or Back Arrow to Exit.", style: Theme.of(context).textTheme.title,),
              ],
            ),
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: 
          (BuildContext context) => 
          TapMethod(settings: widget.settings,))),
        ),
      ),
    );
  }
}
