import 'package:flutter/material.dart';

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

          fontFamily: "Montserrat",

          textTheme: TextTheme(
            title: TextStyle(color: Colors.white, fontSize: 50, ),
            body1: TextStyle(color: Colors.white, fontSize: 25)
          )
          

        ),
        home:  HomePage.HomeScreen());
  }
}