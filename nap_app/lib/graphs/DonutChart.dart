//Donut Graph Widget. This Graph Shows Times taken to get to sleep

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../userNapData.dart';

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});

  factory DonutAutoLabelChart.withSampleData(List<UserNapData> napList) {
    return new DonutAutoLabelChart(
      _createSampleData(napList),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 50,
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                outsideLabelStyleSpec: new charts.TextStyleSpec(
                  color: charts.Color.white,
                  fontSize: 12,
                  )
              )
              ]
        )
      );
  }

  //Method that retrieves and Populates the Graph
  static List<charts.Series<NapData, int>> _createSampleData(List<UserNapData> napList) {

    var fiveMins = 0;
    var tenMins = 0;
    var fifteenMins = 0;
    var twentyMins = 0;
    var twentyfiveMins = 0;
    var thirtyMins = 0;

    //If Else statements which add a count to the values if the time is within that range - Going to the nearest 5 minutes
    for(int i = 0; i < napList.length; i++)
    {
      if(napList[i].successfullSleep)
      {
        print(napList[i].timeSleptInSeconds);
        if(napList[i].timeSleptInSeconds <= 350 && napList[i].timeSleptInSeconds > 0)
        {
          fiveMins++;
        }
        else if(napList[i].timeSleptInSeconds <= 650  && napList[i].timeSleptInSeconds > 350)
        {
          tenMins++;
        }
        else if(napList[i].timeSleptInSeconds <= 950  && napList[i].timeSleptInSeconds > 650)
        {
          fifteenMins++;
        }
        else if(napList[i].timeSleptInSeconds <= 1250  && napList[i].timeSleptInSeconds > 950)
        {
          twentyMins++;
        }
        else if(napList[i].timeSleptInSeconds <= 1550  && napList[i].timeSleptInSeconds > 1250)
        {
          twentyfiveMins++;
        }
        else if(napList[i].timeSleptInSeconds < 1850  && napList[i].timeSleptInSeconds > 1550)
        {
          thirtyMins++;
        }      
      }      
    }

    final List<NapData> data = List<NapData>();

      //Check if the Value is not Zero then Adding to the graph if thats true
      if(fiveMins != 0)
      {
        data.add(new NapData(5, fiveMins, Colors.red)); 
      }
      if(tenMins != 0)
      {
        data.add(new NapData(10, tenMins, Colors.green)); 
      }
      if(fifteenMins != 0)
      {
        data.add(new NapData(15, fifteenMins, Colors.blue)); 
      }
      if(twentyMins != 0)
      {
        data.add(new NapData(20, twentyMins, Colors.orange));
      }
      if(twentyfiveMins != 0)
      {
        data.add(new NapData(25, twentyfiveMins, Colors.purple)); 
      }
      if(thirtyMins != 0)
      {
        data.add(new NapData(30, thirtyMins, Colors.pink)); 
      }       
    
    return [
      new charts.Series<NapData, int>(
        id: 'Sales',
        domainFn: (NapData sales, _) => sales.year,
        measureFn: (NapData sales, _) => sales.sales,
        colorFn: (NapData sales, _) => sales.color,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (NapData row, _) => '${row.year} mins : ${row.sales}',
      )
    ];
  }
}

/// NapData data type.
class NapData {
  final int year;
  final int sales;
  final charts.Color color;

  NapData(this.year, this.sales, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}