
import 'package:flutter/material.dart';

class  truebutton extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Container(
      child: RaisedButton(
        color: Colors.deepOrange, 
        child:Text("True"),
        elevation: 6.0,
        onPressed: (){
          calculateSleep(context);
 // final birthday = DateTime(2019, 07, 25);
 //final date2 = DateTime.now();
 //final difference = date2.difference(birthday).inMinutes;
 //print(difference);
          //action
        }),
    );

  }
}
void calculateSleep(BuildContext context){
 final birthday = DateTime(2019, 07, 25,10,30);
 final date2 = DateTime.now();
 final difference = date2.difference(birthday).inMinutes;
 String oneAsString = difference.toString();
  var alertDialog = AlertDialog(

    
    title: Text("You have taken a nap"),
    content: Text("YOur nap time is " + oneAsString),
    
  );
   
  showDialog(
    context: context,
    builder: (BuildContext context){
      return alertDialog;
    }
  );
}
class  falsebutton extends StatelessWidget{
  @override
  Widget build (BuildContext){
    return Container(
      child: RaisedButton(
        color: Colors.deepOrange,
        child:Text("false"),
        elevation: 6.0,
        onPressed: (){
          //action
        }),
    );

  }
}

