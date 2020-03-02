import 'package:flutter/material.dart';
import 'home.dart';
import 'motion.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  MotionExitConfigurations motionExitConfigurations;
  int animDuration = 2000;

  @override
  void initState() {
    super.initState();

    motionExitConfigurations =
        MotionExitConfigurations(durationMs: 500, mode: MotionMode.FADE);

    Future.delayed(Duration(milliseconds: animDuration + 1000), () {
      motionExitConfigurations.controller.addStatusListener((status) {
        if (status == AnimationStatus.completed)
          Navigator.pushReplacement(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => HomeScreen()));
      });
      motionExitConfigurations.controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Motion<Column>(
      exitConfigurations: motionExitConfigurations,
      mainAxisSize: MainAxisSize.min,
      durationMs: animDuration,
      children: <Widget>[
        MotionElement(
          mode: MotionMode.FADE,
          interval: Interval(0.0, 0.5),
          child: Text(
            "Transitions",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
        MotionElement(
          mode: MotionMode.FADE,
          interval: Interval(0.5, 1.0),
          child: Text(
            "now easier than ever",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
          ),
        )
      ],
    )));
  }
}
