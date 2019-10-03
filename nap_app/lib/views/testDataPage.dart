import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:first_app/setting.dart';
import 'package:first_app/setting.dart';

import 'package:wakelock/wakelock.dart';
import 'testDataPage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'aboutPage.dart' as AboutPage;



class TestData extends StatefulWidget
{
  
 final NapSettingsData settings;

  TestData({this.settings});
  
  
  
  @override
  _TestDataPageState createState() => _TestDataPageState();
}



class _TestDataPageState extends State<TestData> {
  
  @override
  Widget build(BuildContext context) {

    int  napLength = widget.settings.napLength;
    String napLength1 = napLength.toString();
    
    int elapsedTime =widget.settings.elapsedTime;
    String elapsedTime1 = elapsedTime.toString();

    var date2 = DateTime.now();
    String stringValue = date2.toString();



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
          
          title: Text('Summary Page'),
          
        ),
        body: Row(    
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: <Widget>[
        Column( 

          children: <Widget> [
            

            Text(
              'Your Nap Timeis: '+ napLength1,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

            ),
            Container(height: 20,),

            

            Container(
              height: 50,
              width: 100,
            ),

            Text(
              'Your Start Time ' + elapsedTime1,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

            ),
            Container(height: 20,),

     
            Container(
              height: 50,
              width: 100,
            ),

            Text(
              'Your End Time is:'+ stringValue,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

            ),
            Container(height: 20,),


          ],
        ),
      ],           
    ),
        ),
      );
  }
}