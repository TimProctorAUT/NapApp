import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nap Summary'),
          
        ),
        body: Center(
        child: Text("Your nap Length is: ${widget.napLength}"),
        )
        ),
      );
  }
}