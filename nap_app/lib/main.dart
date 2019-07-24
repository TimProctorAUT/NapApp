import 'package:flutter/material.dart';
import 'package:nap_app/sleep_detection/splash.dart';

//Entry point for the program
main(List<String> args) => runApp(NapApp());

//Stateful Widget builder, creates the initial state of the application.
//Might need to change this to stateless later on.
class NapApp extends StatefulWidget {
  @override
  _NapAppState createState() => _NapAppState();
}

//This is the state of the widget
//Changes here will result in visible changes on the application.
//Dynamic changes must be made through the setState() method.
class _NapAppState extends State<NapApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Builder(
        builder: (context) => Center(
          child: RaisedButton(
            child: Text("Sleep Detection"),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SplashScreen())),
          ),
        ),
      ),
    );
  }
}