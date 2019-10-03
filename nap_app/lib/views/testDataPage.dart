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
    int  hello = widget.settings.napLength;
    String oneAsString = hello.toString();
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
          
          title: Text('Summary Page'+ oneAsString),
          
        ),
        body: Row(    
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: <Widget>[
        Column( 

          children: <Widget> [
            

            Text(
              'Your Nap Time',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

            ),
            Container(height: 20,),

            Text(       
              '[INSERT CONTENT]',
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.white),      
            ),

            Container(
              height: 50,
              width: 100,
            ),

            Text(
              'Your Start Time' ,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

            ),
            Container(height: 20,),

     
            Text(       
              
              '[INSERT CONTENT]',
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.white),      
            ),

            Container(
              height: 50,
              width: 100,
            ),

            Text(
              'Your End Time',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

            ),
            Container(height: 20,),

            Text(       
              '[INSERT CONTENT]',
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.white),      
            ),

          ],
        ),
      ],           
    ),
        ),
      );
  }
}