import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math' show pi;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //provides the ticker , like one milisocond is 1 tick
  Animation<double> catAnimation; //contains a double value that changes
  AnimationController catController; // changes that value
  Animation<double> boxAnimation; //contains a double value that changes
  AnimationController boxController; // changes that value

  //settting up intial state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupAnimations();
    boxController
        .forward(); // starts the box animation whiile the cat is in the box
  }

  //setting up the animation
  void _setupAnimations() {
    _setupBoxAnimation();
    _setupCatAnimation();
  }

  void _setupBoxAnimation() {
    boxController = AnimationController(
      vsync: this, // vsync this is provided by the TickerProviderStateMixin
      duration: Duration(
        milliseconds: 800, // was micrrosecond instead of milisond
      ),
    );

    //Tween stands for between it sets up the value for animation ending and stuff
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
        CurvedAnimation(curve: Curves.easeInOut, parent: boxController));

    // creates the flappy effect
    boxAnimation.addListener(() {
      if (boxAnimation.status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (boxAnimation.status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
  }

  void _setupCatAnimation() {
    catController = AnimationController(
      vsync: this, // vsync this is provided by the TickerProviderStateMixin
      duration: Duration(
        milliseconds: 200, // was micro second instead of milisecond
      ),
    );
    catAnimation = Tween(
      begin: -35.0,
      end: -80.0, // this was int instead of double , that caused the bug
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
          title: Text("Cat animation"),
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
              angle: -boxAnimation
                  .value, // have to put negatice for the right flap
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
