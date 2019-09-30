/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
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
  static List<charts.Series<NapDataset, DateTime>> _createSampleData() {
    final data = [
      new NapDataset(new DateTime(2019, 9, 19), 5),
      new NapDataset(new DateTime(2019, 9, 26), 20),
      new NapDataset(new DateTime(2019, 10, 3), 15),
      new NapDataset(new DateTime(2019, 10, 10), 10),
      new NapDataset(new DateTime(2019, 10, 12), 12),
    ];

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