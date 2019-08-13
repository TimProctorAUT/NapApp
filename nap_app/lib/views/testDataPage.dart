import 'package:flutter/material.dart';
import 'package:first_app/views/napSettingPage.dart';


class TestData extends StatefulWidget
{
  @override
  _TestDataPageState createState() => _TestDataPageState();

   final int napLength;
  final int napLimit;
  final int vibrationInterval;

  const TestData({Key key, this.napLength, this.napLimit, this.vibrationInterval}):super(key: key);
}


class _TestDataPageState extends State<TestData> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       
      title: 'NapApp Menu Tests',
      theme: ThemeData(
        //Colors
        primaryColor: Color.fromRGBO(18, 18, 18, 1),
        scaffoldBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
        cardColor: Color.fromRGBO(18, 18, 18, 0.8),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nap Summary'),
          
        ),
             body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Your nap Length is: ${widget.napLength}"),
              Text("Your nap Length is: ${widget.napLimit}"),
            ]
        )
        ]
        ),
      ),
    );
  }
}