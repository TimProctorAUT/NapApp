import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import '../graphs/LineChart.dart' as lineChart;
import '../graphs/DonutChart.dart' as donutChart;
import '../graphs/GuageChart.dart' as guageChart;

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
      //Insert Content
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 25,),

            Container(
              child: Column(
                children: <Widget>[                
                  Text('Time Taken to Fall Asleep'),

                  Container(height: 25,),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: prefix0.Color.fromRGBO(50, 50, 50, 0.7),
                    ),
                    padding: EdgeInsets.all(15),
                    height: 250,
                    width: 300,
                    child: lineChart.SimpleTimeSeriesChart.withSampleData(),
                  ),
                ],
              ),          
            ),          

            Container(height: 50,),
            
            Container(
              child: Column(
                children: <Widget>[                
                  Text('Length of Successful Naps Taken'),

                  Container(height: 25,),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: prefix0.Color.fromRGBO(50, 50, 50, 0.7),
                    ),
                    padding: EdgeInsets.all(15),
                    height: 290,
                    width: 300,
                    child: donutChart.DonutAutoLabelChart.withSampleData(),
                  ),
                ],
              ),          
            ),  
            
            Container(height: 50,),
            
            Container(           
              child: Column(
                children: <Widget>[                
                  Text('Success Rate of Naps'),

                  Container(
                    height: 25,),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: prefix0.Color.fromRGBO(50, 50, 50, 0.7),
                    ),
                    padding: EdgeInsets.all(15),
                    height: 290,
                    width: 300,
                    child: guageChart.GaugeChart.withSampleData(),
                  ),
                ],
              ),          
            ),  
            
            Container(height: 50,),
          ],
        ),
      ),
    
    );
  }
}