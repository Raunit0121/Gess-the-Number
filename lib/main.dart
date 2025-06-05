import 'package:flutter/material.dart';
import 'package:gessthenumber/screens/splashScreen.dart';


void main() {
  runApp( NumberGuessingGame());
}

class NumberGuessingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guessing Game',
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}
