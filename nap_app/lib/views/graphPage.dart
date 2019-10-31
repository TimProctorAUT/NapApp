import 'package:first_app/fileOperations.dart';
import 'package:first_app/userNapData.dart';
import 'package:first_app/views/homePage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart' as prefix0;
import '../graphs/LineChart.dart' as lineChart;
import '../graphs/DonutChart.dart' as donutChart;
import '../graphs/GuageChart.dart' as guageChart;

class PastNaps extends StatefulWidget
{
  final List<UserNapData> napList;
  PastNaps({this.napList});

  @override 
  _PastNapsState createState() => _PastNapsState();
}

class _PastNapsState extends State<PastNaps> {

  FileOperations fileOps = FileOperations();

  dialogBuilder(){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Do you wish to delete ALL currently saved Nap Data files?\n\nA maximum of 500 files can be stored."),
        actions: <Widget>[
          RaisedButton(
            child: Text("Ok", style: TextStyle(color: Colors.white),),
            onPressed: (){
              deleteNapData();
            },
          ),
          FlatButton(
            child: Text("Cancel"),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      )
    );
  }

  deleteNapData(){
    fileOps.deleteAllNapData();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), ModalRoute.withName('/'));
  }

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
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: BoxDecoration(
                color: prefix0.Color.fromRGBO(50, 50, 50, 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.0, color: Colors.white),
              ),     
              child: Column(
                children: <Widget>[         
                  Text('Time Taken to fall Asleep'),

                  Container(height: 15,),
                  
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(15),
                    height: 250,
                    width: 320,
                    child: lineChart.SimpleTimeSeriesChart.withSampleData(widget.napList),
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
                    child: donutChart.DonutAutoLabelChart.withSampleData(widget.napList),
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
                    child: guageChart.GaugeChart.withSampleData(widget.napList),
                  ),
                ],
              ),          
            ),  
            
            Container(height: 50,),

            RaisedButton(
            onPressed: (){
              dialogBuilder();
            },
            child: Text("Delete All Nap Data"),
          ),
          ],
        ),
      ),
    );
  }
}