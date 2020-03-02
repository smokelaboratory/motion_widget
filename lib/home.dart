import 'package:flutter/material.dart';
import 'package:motion_widget/showcase.dart';

import 'motion.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MotionExitConfigurations motionExitConfigurations;

  @override
  void initState() {
    super.initState();

    motionExitConfigurations = MotionExitConfigurations(
        displacement: 200,
        orientation: MotionOrientation.HORIZONTAL_LEFT,
        durationMs: 400);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      motionExitConfigurations.controller.addStatusListener((status) {
        if (status == AnimationStatus.completed)
          Navigator.pushReplacement(context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => ShowcaseScreen()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
            child: Motion<Column>(
              durationMs: 2500,
              crossAxisAlignment: CrossAxisAlignment.start,
              exitConfigurations: motionExitConfigurations,
              children: <Widget>[
                MotionElement(
                  interval: Interval(0.0, 0.30),
                  displacement: 20,
                  child: Text(
                    "Features",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
                SizedBox(height: 20),
                getFeatureItem(
                    Interval(0.3, 1.0), "Fine-grained control with Interval"),
                SizedBox(height: 10),
                getFeatureItem(
                    Interval(0.4, 1.0), "Lightweight & fully customizable"),
                SizedBox(height: 10),
                getFeatureItem(Interval(0.5, 1.0), "No boilerplate code"),
                SizedBox(height: 10),
                getFeatureItem(Interval(0.58, 1.0), "Works with Row & Column"),
                SizedBox(height: 10),
                getFeatureItem(
                    Interval(0.63, 1.0), "Support for Translate & Fade modes"),
                SizedBox(height: 10),
                getFeatureItem(
                    Interval(0.67, 1.0), "Provides Exit transitions"),
                SizedBox(height: 10),
                getFeatureItem(Interval(0.7, 1.0), "No code clean-up required"),
                SizedBox(height: 10),
                getFeatureItem(Interval(0.72, 1.0), "Looks very cool! ;)"),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FlatButton(
                onPressed: () {
                  motionExitConfigurations.controller.forward();
                },
                child: Text(
                  "Next",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
        )
      ],
    ));
  }

  MotionElement getFeatureItem(Interval interval, String text) {
    return MotionElement(
      interval: interval,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.check,
            color: Colors.blueAccent,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
