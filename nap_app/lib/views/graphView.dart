import 'package:flutter/material.dart';

class PastNaps extends StatefulWidget
{
  @override 
  _PastNapsState createState() => _PastNapsState();
}

class _PastNapsState extends State<PastNaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Naps'),
      ),
    );
  }
}