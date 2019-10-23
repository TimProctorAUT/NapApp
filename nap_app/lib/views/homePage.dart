import 'package:first_app/fileOperations.dart';
import 'package:first_app/setting.dart';
import 'package:first_app/userNapData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'instructionPage.dart';
import 'napSettingPage.dart' as NapSettings;
import 'graphPage.dart' as GraphPage;
import 'aboutPage.dart' as AboutPage;
import 'tapPage.dart';

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState ();
}

class _HomeScreenState  extends State<HomeScreen> {

  FileOperations fileOps = FileOperations();
  NapSettingsData settingsObject;

  dialogBuilder(){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Looks like you don't have any saved settings!\n\nWe have tried to setup the app to work just for you!\n\nIf you wish to personalize your naps, please visit the 'Nap Setup' from the homepage!"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }

  loadSettingsForNap() async{
    settingsObject = await fileOps.readObjectFromFile("NapSettings");

    if(settingsObject.defaultSettings){
      Navigator.push(context,MaterialPageRoute(builder: (context) => SplashScreen(settings: settingsObject,)),); 
      dialogBuilder();
    }
    else if(settingsObject.dontDisplayInstructions){
      Navigator.push(context,MaterialPageRoute(builder: (context) => TapMethod(settings: settingsObject,)),); 
    }
    else{
      Navigator.push(context,MaterialPageRoute(builder: (context) => SplashScreen(settings: settingsObject,)),); 
    }
  }

  loadSettings() async{
    settingsObject = await fileOps.readObjectFromFile("NapSettings");

    Navigator.push(context,MaterialPageRoute(builder: (context) => NapSettings.NapSettings(napSettings: settingsObject,)),);
  }

  buildNapDataListForGraphs() async{
    int length = await fileOps.getVaildNaps();
    List<UserNapData> napList = List<UserNapData>();

    

    if(length == 0)
    {
     return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("No Naps currently present! \n\nPress 'Start Nap' to start your napping experience"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: (){
              Navigator.pop(context);
            }
          )
        ],
      )
    ); 
    }
    else
    {
      for(int i = 1; i <= length; i++){
        UserNapData napData = await fileOps.readObjectFromFile("UserNapData", napNumber: i);
        napList.add(napData);
      }

      Navigator.push(context,MaterialPageRoute(builder: (context) => GraphPage.PastNaps(napList: napList,)),);
    }
}

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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

              Spacer(),

              Text("NAP", style: TextStyle(fontSize: 65, fontFamily: 'Times New Roman', color: Color.fromRGBO(10, 86, 148, 1)),),
              Text("OPTIMIZER", style: TextStyle(fontSize: 30, fontFamily: 'Times New Roman', color: Color.fromRGBO(144, 144, 144, 1)),),
              
              Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  //====Button One====//
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Color.fromRGBO(50, 50, 50, 0.7),
                      boxShadow: [BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20
                      ),]
                    ),

                    width: 130,
                    height: 130,
                    child: MaterialButton(
                      onPressed: loadSettingsForNap,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 2.5,),

                          Image(image: AssetImage('assets/nap_icon.png'), height: 75, width: 75,),

                          Container(height: 10,),

                          Text('Start Nap', style: TextStyle(fontSize: 11),),
                        ],
                      ),
                    ),
                  ),

                  //=========Spacer Division==========//
                  Container(width: 35,),

                  //====Button Two====//
                  Container(
                    //color: Color.fromRGBO(100, 100, 100, 0.7),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Color.fromRGBO(50, 50, 50, 0.7),
                      boxShadow: [BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20
                      ),]
                    ),

                    width: 130,
                    height: 130,
                    child: MaterialButton(
                      onPressed: loadSettings,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 2.5,),

                          //Image(image: AssetImage('assets/lifespansmall.png'), height: 75, width: 75,),
                          Icon(Icons.settings, size: 75,),
                          Container(height: 10,),

                          Text('Nap Setup', style: TextStyle(fontSize: 11),),
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
                    //color: Color.fromRGBO(100, 100, 100, 0.7),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Color.fromRGBO(50, 50, 50, 0.7),
                      boxShadow: [BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20
                      ),]
                    ),

                    width: 130,
                    height: 130,
                    child: MaterialButton(
                      onPressed: buildNapDataListForGraphs,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 2.5,),

                          Image(image: AssetImage('assets/graph_icon.png'), height: 75, width: 75,),

                          Container(height: 10,),

                          Text('Previous Naps', style: TextStyle(fontSize: 11),),
                        ],
                      ),
                    ),
                  ),

                  //=========Spacer Division==========//
                  Container(width: 35,),

                  //====Button Four====//                  
                  Container(
                    //color: Color.fromRGBO(100, 100, 100, 0.7),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Color.fromRGBO(50, 50, 50, 0.7),
                      boxShadow: [BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20
                      ),]
                    ),

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

              Spacer(),

              Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(image: AssetImage('assets/lifespantrust.png'), height: 40, width: 300,),
                        ],
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              launchUrl("http://www.lifespantrust.com");
                            },
                            height: 50,
                            minWidth: 200,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Container(height: 20,)
            ],
          ),
        ),

        bottomNavigationBar: BottomAppBar(
        child:  RaisedButton(
                  color: Color.fromRGBO(50, 50, 50, 1),
                  padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
                  child: Text('Keep us Free'),
                  onPressed: (){
                    //TODO CHANGE URL TO BRIANS EMAIL
                    //launchUrl("https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=auminist3%40gmail.com&item_name=Keep+the+app+free%21&currency_code=NZD&amount=2&source=url");
                    launchUrl("http://www.lifespantrust.com/donations-and-payments/");
                  } 
                ),
      ),
      ),
    );   
  }
}