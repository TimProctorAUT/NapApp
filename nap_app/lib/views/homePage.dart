import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'aboutPage.dart' as AboutPage;
import 'napSettingPage.dart' as NapPage;
import 'sleepPage.dart' as SleepPage;
import 'graphPage.dart' as GraphPage;

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NapApp Menu Tests',
      theme: ThemeData(
        //Colors
        primaryColor: Color.fromRGBO(18, 18, 18, 1),
        scaffoldBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
        cardColor: Color.fromRGBO(18, 18, 18, 0.8),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Card(
          child: Column(
            children: <Widget>[
              Container(
                height: 140,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Nap Button
                  Container(
                      child: MaterialButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/nap_icon.png'),
                              width: 90,
                              height: 90,
                            ),
                            Text(
                              'Nap Tracker',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NapPage.NapSettings()),
                          );
                        },
                      ),
                      color: Color.fromRGBO(30, 30, 30, 0.8),
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.all(15)),

                  //Sleep Training
                  Container(
                      child: MaterialButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/sleep_icon.png'),
                              width: 90,
                              height: 90,
                            ),
                            Text(
                              'Sleep Training',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SleepPage.SleepTraining()),
                          );
                        },
                      ),
                      color: Color.fromRGBO(30, 30, 30, 0.8),
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.all(15)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Graphing Data
                  Container(
                      child: MaterialButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/graph_icon.png'),
                              width: 90,
                              height: 90,
                            ),
                            Text(
                              'Past Nap',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GraphPage.PastNaps()),
                          );
                        },
                      ),
                      color: Color.fromRGBO(30, 30, 30, 0.8),
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.all(15)),

                  //About Us
                  Container(
                      child: MaterialButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/about_icon.png'),
                              width: 90,
                              height: 90,
                            ),
                            Text(
                              'Why Should I Nap?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AboutPage.AboutUs()),
                          );
                        },
                      ),
                      color: Color.fromRGBO(30, 30, 30, 0.8),
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.all(15)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Exit
                  Container(
                      child: MaterialButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/exit_icon.png'),
                              width: 60,
                              height: 60,
                            ),
                            Text(
                              'Exit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                      color: Color.fromRGBO(30, 30, 30, 0.8),
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(15)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}