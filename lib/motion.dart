import 'package:flutter/material.dart';

class Motion<T extends Flex> extends StatefulWidget {
  final List<Widget> children;
  final int durationMs;
  final bool isAutomatic, shouldRepeat;
  AnimationController motionController;
  final MotionExitConfigurations exitConfigurations;

  final Key key;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;

  Motion(
      {this.key,
      @required this.children,
      this.durationMs = 1000,
      this.isAutomatic = true,
      this.shouldRepeat = false,
      this.exitConfigurations,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.textDirection,
      this.verticalDirection = VerticalDirection.down,
      this.textBaseline}) {
    if (T != Row && T != Column) {
      throw FlutterError(
          "Motion widget can be of type Row or Column. $T is not allowed");
    }
  }

  @override
  _MotionState<T> createState() => _MotionState<T>();
}

class _MotionState<T extends Flex> extends State<Motion<T>>
    with TickerProviderStateMixin {
  List<Widget> processedChildren = List();

  @override
  void initState() {
    super.initState();

    widget.exitConfigurations?.controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.exitConfigurations.durationMs));

    widget.motionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.durationMs));

    processChildren();

    if (widget.isAutomatic) {
      if (widget.shouldRepeat)
        widget.motionController.repeat(reverse: true);
      else
        widget.motionController.forward();
    }
  }

  void processChildren() {
    widget.children.forEach((child) {
      if (child is MotionElement)
        processedChildren.add(getMotionBuilder(child, widget.motionController));
      else
        processedChildren.add(child);
    });
  }

  Widget getMotionBuilder(MotionElement child, AnimationController animCont,
      {bool isExit = false}) {
    Animation transAnim;

    Widget builder;
    switch (child.mode) {
      case MotionMode.TRANSLATE_FADE:
        transAnim = getTransAnim(child, animCont, isExit);
        builder = FadeTransition(
          opacity: getOpacAnim(child, animCont, isExit),
          child: AnimatedBuilder(
              animation: transAnim,
              builder: (_, __) {
                return Transform.translate(
                  offset: getTransOffset(
                      child.orientation, transAnim.value, isExit),
                  child: child.child,
                );
              }),
        );
        break;
      case MotionMode.FADE:
        builder = FadeTransition(
          opacity: getOpacAnim(child, animCont, isExit),
          child: child.child,
        );
        break;
      default:
        transAnim = getTransAnim(child, animCont, isExit);
        builder = AnimatedBuilder(
            animation: transAnim,
            builder: (_, __) {
              return Transform.translate(
                offset:
                    getTransOffset(child.orientation, transAnim.value, isExit),
                child: child.child,
              );
            });
    }
    return builder;
  }

  Animation getTransAnim(
      MotionElement child, AnimationController animCont, bool isExit) {
    return (isExit
            ? Tween(begin: 0.0, end: child.displacement)
            : Tween(begin: child.displacement, end: 0.0))
        .animate(CurvedAnimation(curve: child.interval, parent: animCont));
  }

  Animation getOpacAnim(
      MotionElement child, AnimationController animCont, bool isExit) {
    return (isExit ? Tween(begin: 1.0, end: 0.0) : Tween(begin: 0.0, end: 1.0))
        .animate(CurvedAnimation(curve: child.interval, parent: animCont));
  }

  Offset getTransOffset(
      MotionOrientation orientation, double animValue, bool isExit) {
    switch (orientation) {
      case MotionOrientation.VERTICAL_UP:
        return Offset(0.0, (isExit ? -1 : 1) * animValue);
        break;
      case MotionOrientation.VERTICAL_DOWN:
        return Offset(0.0, (isExit ? 1 : -1) * animValue);
        break;
      case MotionOrientation.HORIZONTAL_LEFT:
        return Offset((isExit ? -1 : 1) * animValue, 0.0);
        break;
      default:
        return Offset((isExit ? 1 : -1) * animValue, 0.0);
    }
  }

  @override
  void dispose() {
    widget.motionController.dispose();
    widget.exitConfigurations?.controller?.dispose();

    super.dispose();
  }

  Widget getBaseWidget() {
    return T == Row
        ? Row(
            key: widget.key,
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            crossAxisAlignment: widget.crossAxisAlignment,
            textBaseline: widget.textBaseline,
            textDirection: widget.textDirection,
            verticalDirection: widget.verticalDirection,
            children: processedChildren)
        : Column(
            key: widget.key,
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: widget.mainAxisSize,
            crossAxisAlignment: widget.crossAxisAlignment,
            textBaseline: widget.textBaseline,
            textDirection: widget.textDirection,
            verticalDirection: widget.verticalDirection,
            children: processedChildren);
  }

  @override
  Widget build(BuildContext context) {
    return widget.exitConfigurations == null
        ? getBaseWidget()
        : getMotionBuilder(
            MotionElement(
                displacement: widget.exitConfigurations?.displacement,
                mode: widget.exitConfigurations?.mode,
                orientation: widget.exitConfigurations?.orientation,
                child: getBaseWidget()),
            widget.exitConfigurations?.controller,
            isExit: true);
  }
}

class MotionElement extends Widget {
  final Widget child;
  final double displacement;
  final MotionOrientation orientation;
  final Interval interval;
  // final Function(MotionState) controller;
  final MotionMode mode;
  //todo : controller

  MotionElement({
    @required this.child,
    this.displacement = 100.0,
    this.mode = MotionMode.TRANSLATE_FADE,
    this.orientation = MotionOrientation.VERTICAL_UP,
    this.interval = const Interval(0.0, 1.0),
    // this.controller
  });

  @override
  Element createElement() {
    return null;
  }
}

class MotionExitConfigurations {
  final int durationMs;
  AnimationController controller;
  final MotionOrientation orientation;
  final double displacement;
  final MotionMode mode;

  MotionExitConfigurations(
      {this.mode = MotionMode.TRANSLATE_FADE,
      this.durationMs = 1000,
      this.displacement = 100,
      this.orientation = MotionOrientation.VERTICAL_UP});
}

enum MotionState { STARTED, ENDED }

enum MotionOrientation {
  HORIZONTAL_LEFT,
  HORIZONTAL_RIGHT,
  VERTICAL_UP,
  VERTICAL_DOWN
}

enum MotionMode { TRANSLATE, FADE, TRANSLATE_FADE }
