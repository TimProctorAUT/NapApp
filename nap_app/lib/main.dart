import 'package:flutter/material.dart';
import 'package:nap_app/sleep_detection/splash.dart';

import 'views/homePage.dart' as HomePage;

void main(List<String> args) => runApp(NapApp());

class NapApp extends StatefulWidget
{
  @override
  _NapAppState createState() => _NapAppState();
}


class _NapAppState extends State<NapApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NapApp Menu Tests',
        theme: ThemeData(
          //Colors
          primaryColor: Color.fromRGBO(18, 18, 18, 1),
          scaffoldBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
          cardColor: Color.fromRGBO(18, 18, 18, 0.8),


          //Text Themes

         

        ),
        home:  HomePage.HomeScreen());
  }
}