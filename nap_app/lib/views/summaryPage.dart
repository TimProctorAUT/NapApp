import 'package:flutter/material.dart';

import 'package:first_app/setting.dart';



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

    //Data for the summary page (To be change cause write to file)
    int  napLength = widget.settings.napLength;
    String napLength1 = napLength.toString();
    
    int elapsedTime =widget.settings.elapsedTime;
    String elapsedTime1 = elapsedTime.toString();

    DateTime now = DateTime.now();
    var currentTime = new DateTime(now.hour, now.minute);
    String stringValue = currentTime.toString();


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

          children: <Widget>  [
            Container(
              height: 50,
              width: 100,
            ),
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
              'Your Start Time is: ' + elapsedTime1,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

            ),
            Container(height: 20,),

     
            Container(
              height: 50,
              width: 100,
            ),

            Text(
              'Your End Time is: '+ stringValue,
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