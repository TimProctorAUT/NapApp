import 'package:flutter/material.dart';

class NapTracker extends StatefulWidget
{
  @override 
  _NapTrackerState createState() => _NapTrackerState();
}

class _NapTrackerState extends State<NapTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nap Tracker'),
      ),
    );
  }
}