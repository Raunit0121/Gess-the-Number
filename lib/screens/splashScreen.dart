import 'package:flutter/material.dart';

import 'dart:async';
import 'package:lottie/lottie.dart';

import 'number_game_page.dart';  // Don't forget to import Lottie package

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NumberGamePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centers the children vertically
          crossAxisAlignment: CrossAxisAlignment.center,  // Centers the children horizontally
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('assets/images/gesstheno.json'),  // Make sure the path is correct
            ),
            const SizedBox(height: 20),  // Adds space between the animation and text
            const Text(
              'Think fast, guess smart!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,  // You can change the text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
