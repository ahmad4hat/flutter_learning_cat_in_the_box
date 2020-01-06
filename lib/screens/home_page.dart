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
    boxController.forward();
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

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(curve: Curves.easeInOut, parent: boxController),
    );

    boxAnimation.addListener(() {
      if (boxAnimation.status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (boxAnimation.status == AnimationStatus.dismissed) {
        boxController.forward();
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
      begin: -35.0,
      end: -80,
    ).animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  void _startAnimation() {
    if (catController.isCompleted) {
      boxController.forward();
      catController.reverse();
    } else if (catController.isDismissed) {
      boxController.stop();
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
        ),
        body: GestureDetector(
          onTap: _startAnimation,
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                _buildCatAnimation(),
                _buildBox(),
                _buildLeftFlap(),
                _buildRightFlap()
              ],
            ),
          ),
        ));
  }

  Widget _buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget _buildCatAnimation() => AnimatedBuilder(
        animation: catAnimation,
        builder: (context, child) => Positioned(
            child: child, top: catAnimation.value, right: 0, left: 0),
        child: Cat(),
      );

  Widget _buildLeftFlap() => Positioned(
        left: 3.0,
        child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: boxAnimation.value,
              alignment: Alignment.topLeft,
              child: child,
            );
          },
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
        ),
      );

  Widget _buildRightFlap() => Positioned(
        right: 3.0,
        child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: boxAnimation.value,
              alignment: Alignment.topRight,
              child: child,
            );
          },
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
        ),
      );
}
