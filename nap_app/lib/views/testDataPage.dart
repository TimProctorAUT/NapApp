import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestData extends StatefulWidget
{
  @override
  _TestDataPageState createState() => _TestDataPageState();
}


class _TestDataPageState extends State<TestData> {
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
        body: Container(
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
                      margin: EdgeInsets.all(15)
                  ),
        ),
      );
  }
}