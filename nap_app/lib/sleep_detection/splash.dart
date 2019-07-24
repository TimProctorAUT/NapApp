import 'package:flutter/material.dart';
import 'tap_method.dart';

class SplashScreen extends StatefulWidget {

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: RaisedButton(
         color: Colors.black,
          child: Text("Tap when you're ready to start tracking your nap!"),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TapMethod())),
        ),
    );
  }
}
