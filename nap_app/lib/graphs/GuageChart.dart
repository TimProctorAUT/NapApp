/// Gauge chart example, where the data does not cover a full revolution in the
/// chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../userNapData.dart';

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GaugeChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData(List<UserNapData> napList) {
    return new GaugeChart(
      _createSampleData(napList),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        behaviors: [
          new charts.DatumLegend()
        ],
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 30, startAngle: 4 / 5 * 3.14159265, arcLength: 7 / 5 * 3.14159265));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData(List<UserNapData> napList) {
    var success = 0;
    var unsccessful = 0;

    for(int i = 0; i < napList.length; i++)
    {
      if(napList[i].successfullSleep)
      {
        success++;
      }
      else
      {
        unsccessful++;
      }
    }

    final List<GaugeSegment> data = List<GaugeSegment>();

    if(success != 0)
    {
      data.add(new GaugeSegment('Successful', success, Colors.green)); 
    }
    
    data.add(new GaugeSegment('Unsuccessful', unsccessful, Colors.red)); 

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}