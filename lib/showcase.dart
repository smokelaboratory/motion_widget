import 'package:flutter/material.dart';
import 'motion_widget.dart';

class ShowcaseScreen extends StatefulWidget {
  @override
  _ShowcaseScreenState createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<ShowcaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Motion<Column>(
      shouldRepeat: true,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
         FlutterLogo(size: 120),
        SizedBox(height: 10),
        MotionElement(
          mode: MotionMode.FADE,
          child: Text(
            "Motion Widget",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        )
      ],
    )));
  }
}
