import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget
{
  @override 
  _AboutUsState createState() => _AboutUsState();
}


class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Why Should I Nap?'),
      ),
    body: Row(    
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column( 

          children: <Widget> [
            Container(
              height: 50,
              width: 100,
            ),

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
    );
  }
}