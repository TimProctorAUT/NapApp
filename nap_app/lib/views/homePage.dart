import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'napSettingPage.dart' as NapSettings;
import 'graphPage.dart' as GraphPage;
import 'aboutPage.dart' as AboutPage;

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState ();
}

class _HomeScreenState  extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Napping Superpowers',
      theme: ThemeData(
        brightness: Brightness.dark,

        //Colors
        primaryColor: Color.fromRGBO(18, 18, 18, 1),
        scaffoldBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
        cardColor: Color.fromRGBO(18, 18, 18, 1),

        //Text

      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ), 

        body: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  //====Button One====//
                  Container(
                    color: Color.fromRGBO(30, 30, 30, 0.7),

                    width: 130,
                    height: 130,
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => NapSettings.NapSettings()),);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 2.5,),

                          Image(image: AssetImage('assets/nap_icon.png'), height: 75, width: 75,),

                          Container(height: 10,),

                          Text('Take a Nap', style: TextStyle(fontSize: 11),),
                        ],
                      ),
                    ),
                  ),

                  //=========Spacer Division==========//
                  Container(width: 35,),

                  //====Button Two====//
                  Container(
                    color: Color.fromRGBO(30, 30, 30, 0.7),

                    width: 130,
                    height: 130,
                    child: MaterialButton(
                      onPressed: (){

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 2.5,),

                          Image(image: AssetImage('assets/sleep_icon.png'), height: 75, width: 75,),

                          Container(height: 10,),

                          Text('Sleep Training', style: TextStyle(fontSize: 11),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //=========Spacer Division==========//
              Container(height: 35,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  //====Button Three====//
                  Container(
                    color: Color.fromRGBO(30, 30, 30, 0.7),

                    width: 130,
                    height: 130,
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => GraphPage.PastNaps()),);                        
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 2.5,),

                          Image(image: AssetImage('assets/graph_icon.png'), height: 75, width: 75,),

                          Container(height: 10,),

                          Text('Past Naps', style: TextStyle(fontSize: 11),),
                        ],
                      ),
                    ),
                  ),

                  //=========Spacer Division==========//
                  Container(width: 35,),

                  //====Button Four====//                  
                  Container(
                    color: Color.fromRGBO(30, 30, 30, 0.7),

                    width: 130,
                    height: 130,
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => AboutPage.AboutUs()),);                        
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 2.5,),

                          Image(image: AssetImage('assets/about_icon.png'), height: 75, width: 75,),

                          Container(height: 10,),

                          Text('Why should I Nap?', style: TextStyle(fontSize: 11),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        bottomNavigationBar: BottomAppBar(
        child:  RaisedButton(
                  color: Color.fromRGBO(18, 18, 18, 1),
                  padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
                  child: Text('Keep us Free'),
                  onPressed: (){},
                ),
      ),
      ),
    );   
  }
}