/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../userNapData.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});
  factory SimpleTimeSeriesChart.withSampleData(List<UserNapData> napList) {
    return new SimpleTimeSeriesChart(
      _createSampleData(napList),
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      defaultRenderer: new charts.LineRendererConfig(
        includePoints: true,
        
      ),

      domainAxis: new charts.DateTimeAxisSpec(
        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                day: new charts.TimeFormatterSpec(
                    format: 'd', transitionFormat: 'dd/MM')),

        renderSpec: new charts.SmallTickRendererSpec(
          labelStyle: new charts.TextStyleSpec(
            color: charts.Color.white,
          ),

          axisLineStyle: new charts.LineStyleSpec(
            color: charts.Color.white,
          ),

          lineStyle: new charts.LineStyleSpec(
            color: charts.Color.white,
          )
        ),
      ),

      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec: new charts.BasicNumericTickProviderSpec(
          desiredTickCount: 5,
        ),

        renderSpec: new charts.GridlineRendererSpec(
          lineStyle: charts.LineStyleSpec(
            color: charts.Color.white,
            dashPattern: [4, 4],
          ),

          labelStyle: charts.TextStyleSpec(
            color: charts.Color.white,
          ),
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<NapDataset, DateTime>> _createSampleData(List<UserNapData> napList) {

    final List<NapDataset> data = List<NapDataset>();

    for(int i = 0; i < napList.length; i++)
    {
      if(napList[i].successfullSleep)
      {
        //Get Date and Time
        var str = napList[i].timeOfNap;

        var hour = str[13]+str[14];
        var minute = str[16]+str[17];

        var year = str[8]+str[9]+str[10]+str[11];
        var day = str[4]+str[5];
        
        var month = str[0]+str[1]+str[2];
        var monthNum = 1;

        //Converts STRING months into Numbers
        switch(month)
        {
          case 'Jan':
          {
            monthNum = 1;
          }
          break;

          case 'Feb':
          {
            monthNum = 2;
          }
          break;
          
          case 'Mar':
          {
            monthNum = 3;
          }
          break;
          
          case 'Apr':
          {
            monthNum = 4;
          }
          break;
          
          case 'May':
          {
            monthNum = 5;
          }
          break;
          
          case 'Jun':
          {
            monthNum = 6;
          }
          break;
          
          case 'Jul':
          {
            monthNum = 7;
          }
          break;
          
          case 'Aug':
          {
            monthNum = 8;
          }
          break;
          
          case 'Sep':
          {
            monthNum = 9;
          }
          break;

          case 'Oct':
          {
            monthNum = 10;
          }
          break;
          
          case 'Nov':
          {
            monthNum = 11;
          }
          break;
          
          case 'Dec':
          {
            monthNum = 12;
          }
          break;          
        }

        //Get TimeToSleep & Convert Seconds to Minutes
        var tempSleepTime = napList[i].timeToSleep;

        data.add(new NapDataset(new DateTime(int.parse(year), monthNum, int.parse(day), int.parse(hour), int.parse(minute)), tempSleepTime));
      }
    }

    return [
      new charts.Series<NapDataset, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (NapDataset sales, _) => sales.time,
        measureFn: (NapDataset sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class NapDataset {
  final DateTime time;
  final int sales;

  NapDataset(this.time, this.sales);
}