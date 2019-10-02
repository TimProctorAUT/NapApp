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

            Container(      
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: BoxDecoration(
                color: prefix0.Color.fromRGBO(50, 50, 50, 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.0, color: Colors.white),
              ),     
              child: Column(
                children: <Widget>[                
                  Text('Length of Successful Naps'),

                  Container(height: 15,),
                  
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(15),
                    height: 250,
                    width: 320,
                    child: lineChart.SimpleTimeSeriesChart.withSampleData(),
                  ),
                ],
              ),          
            ),        

            Container(height: 50,),
            
            Container(      
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: BoxDecoration(
                color: prefix0.Color.fromRGBO(50, 50, 50, 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.0, color: Colors.white),
              ),     
              child: Column(
                children: <Widget>[                
                  Text('Length of Successful Naps'),

                  Container(height: 15,),
                  
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(15),
                    height: 250,
                    width: 320,
                    child: donutChart.DonutAutoLabelChart.withSampleData(),
                  ),
                ],
              ),          
            ),  
            
            Container(height: 50,),

            Container(      
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: BoxDecoration(
                color: prefix0.Color.fromRGBO(50, 50, 50, 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.0, color: Colors.white),
              ),     
              child: Column(
                children: <Widget>[                
                  Text('Success Rate of Naps'),

                  Container(height: 15,),
                  
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(15),
                    height: 250,
                    width: 320,
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