import 'package:flutter/material.dart'; //Required for Flutter Widgets
import 'dart:async'; //Required for Timer

class TapMethod extends StatefulWidget {
  @override
  _TapMethodState createState() => _TapMethodState();
}

class _TapMethodState extends State<TapMethod> {
   bool _tapState = false;

//initstate required to create a timer to set the state of the _tapState bool to false.
  @override
  void initState() { 
    super.initState();
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _tapState = false;
        });
      });
  }

//method to invoke setstate to change the state of the _tapState bool.
  void _checkTap(){
    setState(() {
      _tapState = true;
    });
  }

//Column returned to the main dart file to build a UI for the tap-testing.
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => _checkTap(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0)
            ),
            padding: EdgeInsets.all(200),
            child: Text(_tapState.toString()),
          )
        )
      ],
    );
  }
}