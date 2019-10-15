import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget
{
  @override 
  _AboutUsState createState() => _AboutUsState();
}

//Converts hex code to dart color object
Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

class _AboutUsState extends State<AboutUs> {

  //Text for Who Are We section
  final aboutUsString = '''
  Lifespan Trust is a non-profit organisation 
  aimed at educating and coaching healthy 
  relationships with sleep, stress, weight 
  and mental wellbeing.
  ''';

  //Test for Why Should You Nap section
  final whyNapString = '''
  Naps have been shown to benefit the learning 
  process, helping us take in and retain 
  information better. Taking a nap also helps 
  to clear information out of your brain’s 
  temporary storage areas, getting it ready 
  for new information to be absorbed. These 
  benefits are similar to those experienced 
  after consuming caffeine (or other stimulant 
  medications), but without the side effects.
  
  ''';

  //Test for Why This App section
  final thisAppString = '''
  10 to 15 minutes of sleep seems to be the optimum 
  period in terms of improving mental operations,
  performance, reaction times and subjective feelings
  of alertness.
  This app is built with all the research behind 
  it, and we'veended up with the perfect solution 
  to your future naps.
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Why Should I Nap?'),
      ),
    body: Row(    
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget> [
            Container(
              height: 50,
              width: 100,
            ),

            Text('Who Are We',
            style: new TextStyle(color: hexToColor("#3DA8F7"), fontSize: 25.0),),

            Text(       
              aboutUsString,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
              maxLines: 10,),
             
             Container(
              height: 20,
              width: 100,
            ),

            Text('Why Should You Nap',
            style: new TextStyle(color: hexToColor("#3DA8F7"), fontSize: 25.0),),
            
            Text(       
              whyNapString,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
              maxLines: 10,),
              
              Container(
              height: 20,
              width: 100,
            ),

            Text('Why Use This App',
            style: new TextStyle(color: hexToColor("#3DA8F7"), fontSize: 25.0),),

            Text(       
              thisAppString,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
              maxLines: 10,),

         ],
        ),
      ],           
     ),
   );
  }
}