// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:first_app/fileOperations.dart';
// import 'package:first_app/userNapData.dart';
// import 'package:flutter/material.dart';

// class DonutChart extends StatefulWidget {

//   @override
//   _DonutChartState createState() => _DonutChartState();
// }

// class _DonutChartState extends State<DonutChart> {
//   List<charts.Series<LinearSales, int>> seriesList;
//   bool animate;

//   @override
//   void initState() {
//     setState(() {
//       _createSampleData().then((value) {
//       seriesList = value;
//       animate = true;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new charts.PieChart(
//         seriesList,
//         animate: animate,
//         defaultRenderer: new charts.ArcRendererConfig(
//             arcWidth: 50,
//             arcRendererDecorators: [
//               new charts.ArcLabelDecorator(
//                 outsideLabelStyleSpec: new charts.TextStyleSpec(
//                   color: charts.Color.white,
//                   fontSize: 12,
//                   )
//               )
//               ]
//         )
//       );
//   }

//   static Future<List<charts.Series<LinearSales, int>>> _createSampleData() async{
//     //TODO: Implement FileOperations; Loop Till File doesn't Exist
//     //Create new Linear

//     FileOperations fileOps = FileOperations();

//       final List<LinearSales> dataset = List<LinearSales>();

//       var totalNaps = await fileOps.getVaildNaps();
//       var fiveMins = 3;
//       var tenMins = 5;
//       var fifteenMins = 7;
//       var twentyMins = 1;
//       var twentyfiveMins = 12;
//       var thirtyMins = 0;

//       //Checks if no Naps Present
//       if (totalNaps == 0)
//       {
//         //Load no-data Content
//       }
//       else
//       {
//         //Loop Through totalValidNaps
//         for(int i = 1; i <= totalNaps; i++)
//         {
//           await fileOps.readNapData(i);
//           UserNapData nap = UserNapData(
//             timeSleptInSeconds: FileOperations.decodedNapData['timeSleptInSeconds'],
//             napNumber: FileOperations.decodedNapData['napNumber'],
//             successfullSleep: FileOperations.decodedNapData['successfullSleep'],
//             timeOfNap: FileOperations.decodedNapData['timeOfNap'],
//             timeToSleep: FileOperations.decodedNapData['timeToSleep'],
//           );
//           print(nap.timeSleptInSeconds);

//           //TODO: Case Switch what Time was Set
//         }
//       }
//       dataset.add(new LinearSales(5, fiveMins, Colors.red));
//       dataset.add(new LinearSales(10, tenMins, Colors.yellow));
//       dataset.add(new LinearSales(15, fifteenMins, Colors.blue));
//       dataset.add(new LinearSales(20, twentyMins, Colors.green));
//       dataset.add(new LinearSales(25, twentyfiveMins, Colors.purple));
//       dataset.add(new LinearSales(30, thirtyMins, Colors.orange));

//       return [
//         new charts.Series<LinearSales, int>(
//           id: 'Sales',
//           domainFn: (LinearSales sales, ) => sales.year,
//           measureFn: (LinearSales sales, ) => sales.sales,
//           colorFn: (LinearSales sales, ) => sales.color,
//           data: dataset,
//           // Set a label accessor to control the text of the arc label.
//           labelAccessorFn: (LinearSales row, ) => '${row.year} : ${row.sales}',
//         )
//       ];
//     } 
// }

// class LinearSales {
//   final int year;
//   final int sales;
//   final charts.Color color;

//   LinearSales(this.year, this.sales, Color color)
//       : this.color = new charts.Color(
//             r: color.red, g: color.green, b: color.blue, a: color.alpha);
// }