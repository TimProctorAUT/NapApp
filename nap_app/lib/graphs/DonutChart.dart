import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});

  factory DonutAutoLabelChart.withSampleData() {
    return new DonutAutoLabelChart(
      _createSampleData(),
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

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    //TODO: Implement FileOperations; Loop Till File doesn't Exist

    final data = [
      new LinearSales(0, 2, Colors.red),
      new LinearSales(1, 4, Colors.yellow),
      new LinearSales(2, 2, Colors.blue),
      new LinearSales(3, 5, Colors.orange),
      new LinearSales(4, 3, Colors.green),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year} Mins - ${row.sales}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final charts.Color color;

  LinearSales(this.year, this.sales, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}