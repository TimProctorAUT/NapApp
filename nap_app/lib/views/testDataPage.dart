import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestData extends StatefulWidget
{
  @override
  _TestDataPageState createState() => _TestDataPageState();
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
          title: Text('Summary Page'),
        ),
        body: Row(    
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column( 

          children: <Widget> [
            

            Text(
              'Who Are We?',
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
              'Why Should you Nap?',
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
              'How Can this App Help?',
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