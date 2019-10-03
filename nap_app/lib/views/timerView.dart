import 'package:first_app/setting.dart';

import 'package:wakelock/wakelock.dart';
import 'testDataPage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';


//TODO: Line 116

class NapTimer extends StatefulWidget {

  final int napLength;
  final NapSettingsData settings;
  NapTimer({this.napLength, this.settings});

  @override
  _NapTimerState createState() => _NapTimerState();
}

class _NapTimerState extends State<NapTimer> with TickerProviderStateMixin {
  AnimationController controller;
  Stopwatch timeSlept = Stopwatch();

  @override
  void dispose(){
    Wakelock.disable();
    controller.dispose();
    super.dispose();
  }

  createAlertDialog(BuildContext context){

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Your Nap Has Finished!"),
          content: Text("Please press the button below to return home."),
            actions: <Widget>[
           MaterialButton(
             elevation: 5.0,
             child: Text("Return Home"),
             onPressed: (){
               timeSlept.stop();
               widget.settings.timeSleptInSeconds = timeSlept.elapsed.inSeconds;
               Navigator.popUntil(context, ModalRoute.withName('/'));
             },
           )
         ],
      );
    });
  }

  void startTimer(BuildContext context){
    controller.reverse(
      from: controller.value == 0.0
             ? 1.0
             : controller.value);
  }

  restfulWake(bool wakeType){}

  String get timerString {
    Duration duration = controller.duration * controller.value;

    if(duration.inSeconds == 1.0)
    {
      FlutterRingtonePlayer.playAlarm(volume: 1.0, looping: true);
    }
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();

    Wakelock.enable();
    timeSlept.start();

     WidgetsBinding.instance
      .addPostFrameCallback((_) => startTimer(context));
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: this.widget.napLength),
    );
  }

  navigateToSummary(){
    timeSlept.stop();
    widget.settings.timeSleptInSeconds = timeSlept.elapsed.inSeconds;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => TestData()), ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return CustomPaint(
                                painter: TimerPainter(
                              animation: controller,
                              backgroundColor: Colors.white,
                              color: Colors.red,                             //TODO: Set ALARM Colors to a Changeable Color 
                            ));
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Nap Timer",
                              style: themeData.textTheme.subhead,
                            ),
                            AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  return Text(
                                    timerString,
                                    style: themeData.textTheme.display4,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return Icon(controller.isAnimating
                            ? Icons.stop
                            : Icons.stop);
                      },
                    ),
                    onPressed: () {
                      if (controller.isAnimating){
                        createAlertDialog(context);
                        FlutterRingtonePlayer.stop();
                      }
                      else {
                        FlutterRingtonePlayer.stop();
                        createAlertDialog(context);
                      }
                    },
                  ),
                  FlatButton(
                    child: Text("See Summary"),
                    onPressed: () => navigateToSummary
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
