import 'package:flutter/material.dart';
import 'tapPage.dart';

class SplashScreen extends StatefulWidget {

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: RaisedButton(
         color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Sleep Detection Instruction", style: Theme.of(context).textTheme.title),
                Padding(
                  padding: EdgeInsets.all(16),
                ),
                Text("1. Tap Screen to Start", style: Theme.of(context).textTheme.body1,),
                Text("2. Wait for Vibration", style: Theme.of(context).textTheme.body1,),
                Text("3. Tap Screen Again", style: Theme.of(context).textTheme.body1,),
                Text("4. Repeat Until Asleep", style: Theme.of(context).textTheme.body1,),
                Padding(
                  padding: EdgeInsets.all(16),
                ),
                Text("Tap when you're ready to start tracking your nap!", style: Theme.of(context).textTheme.body1,),
              ],
            ),
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TapMethod())),
        ),
    );
  }
}
