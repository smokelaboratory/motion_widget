import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'motion_widget.dart';
import 'welcome.dart';

void main() => runApp(MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Cabin"),
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MotionExitConfigurations motionExitConfigurations;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    motionExitConfigurations =
        MotionExitConfigurations(durationMs: 500, displacement: 50);

    Future.delayed(Duration(seconds: 2), () {
      motionExitConfigurations.controller.addStatusListener((status) {
        if (status == AnimationStatus.completed)
          Navigator.pushReplacement(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => WelcomeScreen()));
      });
      motionExitConfigurations.controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Motion<Row>(
      mainAxisSize: MainAxisSize.min,
      exitConfigurations: motionExitConfigurations,
      children: <Widget>[
        MotionElement(
          child: Text(
            "Introducing\nMotion Widget",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          orientation: MotionOrientation.RIGHT,
          interval: Interval(0.0, 0.5),
        ),
        SizedBox(
          width: 20,
        ),
        MotionElement(
          child: FlutterLogo(size: 50),
          interval: Interval(0.5, 1.0, curve: Curves.easeOutBack),
        )
      ],
    )));
  }
}
