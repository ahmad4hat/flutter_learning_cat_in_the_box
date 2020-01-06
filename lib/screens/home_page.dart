import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math' show pi;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //provides the ticker , like one milisocond is 1 tick
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _setUpCatAnimation();
    _boxAnimationSetup();
  }

  _boxAnimationSetup() {
    boxController = AnimationController(
      vsync: this, // vsync this is provided by the TickerProviderStateMixin
      duration: Duration(
        microseconds: 800,
      ),
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 1.2).animate(
      CurvedAnimation(curve: Curves.easeInOut, parent: boxController),
    );

    boxAnimation.addListener(() {
      if (boxAnimation.status == AnimationStatus.completed) {
        boxController.forward();
      } else if (boxAnimation.status == AnimationStatus.dismissed) {
        boxController.reverse();
      }
    });
  }

  _setUpCatAnimation() {
    catController = AnimationController(
      vsync: this, // vsync this is provided by the TickerProviderStateMixin
      duration: Duration(
        microseconds: 200,
      ),
    );
    catAnimation = Tween(
      begin: -40.0,
      end: -80,
    ).animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
      ),
      body: Stack(
        children: <Widget>[Cat(), _buildBox()],
      ),
    );
  }

  Widget _buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }
}
