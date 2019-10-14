import 'package:first_app/fileOperations.dart';
import 'package:first_app/setting.dart';
import 'package:first_app/sleep_detection/tapInstruction.dart';
import 'package:first_app/sleep_detection/tapPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'napSettingPage.dart' as NapSettings;
import 'graphPage.dart' as GraphPage;
import 'aboutPage.dart' as AboutPage;

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

//TODO REVISE DEFAULT SETTINGS FOR QUICK NAPS
  loadSettingsForNap() async{
    await fileOps.readSettings();

    setState(() {
      try{
        settingsObject = NapSettingsData(
          vibrationInterval: FileOperations.decodedObject['vibrateInterval'],
          napLimit: FileOperations.decodedObject['napLimit'],
          napLength: FileOperations.decodedObject['napLength'],
          selectedVibrate: FileOperations.decodedObject['selectedVibrate'],
          wantsAudio: FileOperations.decodedObject['wantsAudio'],
          wantsAlarmAudio: FileOperations.decodedObject['wantsAlarmAudio'],
          wantsAlarmVibrate: FileOperations.decodedObject['wantsAlarmVibrate'],
          selectedAudioFile: FileOperations.decodedObject['selectedAudioFile'],
          selectedAlarmSound: FileOperations.decodedObject['selectedAlarmSound'],
          dontDisplayInstructions: FileOperations.decodedObject['dontDisplayInstructions'],
          hasSavedSettings: FileOperations.decodedObject['hasSavedSettings'],
          wantsGentleWake: FileOperations.decodedObject['gentleWake']
        );

        if(settingsObject.dontDisplayInstructions){
          Navigator.push(context,MaterialPageRoute(builder: (context) => TapMethod(settings: settingsObject,)),); 
        }
        else{
          Navigator.push(context,MaterialPageRoute(builder: (context) => SplashScreen(settings: settingsObject,)),); 
        }

      }
      catch(e){
        settingsObject = NapSettingsData(
          vibrationInterval: 2,
          napLength: 1,
          napLimit: 1,
          dontDisplayInstructions: false,
          wantsAudio: false,
          wantsGentleWake: true
        );

        Navigator.push(context,MaterialPageRoute(builder: (context) => SplashScreen(settings: settingsObject,)),); 

        dialogBuilder();

        print("file doesnt exist");
      }  
    });     
  }

  loadSettings() async{
    await fileOps.readSettings();

    setState(() {
      try{
        settingsObject = NapSettingsData(
          vibrationInterval: FileOperations.decodedObject['vibrateInterval'],
          napLimit: FileOperations.decodedObject['napLimit'],
          napLength: FileOperations.decodedObject['napLength'],
          selectedVibrate: FileOperations.decodedObject['selectedVibrate'],
          wantsAudio: FileOperations.decodedObject['wantsAudio'],
          wantsAlarmAudio: FileOperations.decodedObject['wantsAlarmAudio'],
          wantsAlarmVibrate: FileOperations.decodedObject['wantsAlarmVibrate'],
          selectedAudioFile: FileOperations.decodedObject['selectedAudioFile'],
          selectedAlarmSound: FileOperations.decodedObject['selectedAlarmSound'],
          dontDisplayInstructions: FileOperations.decodedObject['dontDisplayInstructions'],
          hasSavedSettings: FileOperations.decodedObject['hasSavedSettings'],
          wantsGentleWake: FileOperations.decodedObject['gentleWake']
        );
      }
      catch(e){
        print("file doesnt exists");
        settingsObject = NapSettingsData(
          napLength: 10,
          napLimit: 20,
          dontDisplayInstructions: false,
          wantsAudio: false,
          wantsAlarmAudio: true,
          wantsGentleWake: false
        );
      }
    });


    Navigator.push(context,MaterialPageRoute(builder: (context) => NapSettings.NapSettings(napSettings: settingsObject,)),);
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

              Text("Nap", style: TextStyle(fontSize: 55),),
              Text("Optimizer", style: TextStyle(fontSize: 20),),
              
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
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => GraphPage.PastNaps()),);                        
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(height: 2.5,),

                          Image(image: AssetImage('assets/graph_icon.png'), height: 75, width: 75,),

                          Container(height: 10,),

                          Text('Last Nap', style: TextStyle(fontSize: 11),),
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
                              launchUrl("https://www.lifespantrust.com");
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
                    launchUrl("https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=auminist3%40gmail.com&item_name=Keep+the+app+free%21&currency_code=NZD&amount=2&source=url");
                  } 
                ),
      ),
      ),
    );   
  }
}