import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "kitty in cartoon",
      home: HomePage(),
    );
  }
}
