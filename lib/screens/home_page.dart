import 'package:flutter/material.dart';
import '../widgets/cat.dart';

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
