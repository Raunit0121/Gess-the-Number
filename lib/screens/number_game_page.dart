import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/animated_star.dart';

class NumberGamePage extends StatefulWidget {
  @override
  _NumberGamePageState createState() => _NumberGamePageState();
}

class _NumberGamePageState extends State<NumberGamePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  int _randomNumber = Random().nextInt(100) + 1;
  int _attempts = 0;
  String _message = '';
  Color _messageColor = Colors.black;
  List<Widget> _stars = [];

  late AnimationController _animationController;
  double _messageOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  void _checkGuess() {
    final guessText = _controller.text;
    if (guessText.isEmpty) return;

    final guess = int.tryParse(guessText);
    if (guess == null || guess < 1 || guess > 100) {
      _updateMessage('🚫 Enter a number between 1 and 100!', Colors.deepPurple);
      return;
    }

    _attempts++;
    if (guess == _randomNumber) {
      _updateMessage('🎉 Correct in $_attempts tries! 🎉', Colors.green);
      _triggerStarAnimation();
    } else if (guess < _randomNumber) {
      _updateMessage('📉 Too low! Try higher 🔼', Colors.black87);
    } else {
      _updateMessage('📈 Too high! Try lower 🔽', Colors.black87);
    }
  }

  void _updateMessage(String message, Color color) {
    setState(() => _messageOpacity = 0);
    Future.delayed(const Duration(milliseconds: 250), () {
      setState(() {
        _message = message;
        _messageColor = color;
        _messageOpacity = 1;
      });
    });
  }

  void _resetGame() {
    setState(() {
      _randomNumber = Random().nextInt(100) + 1;
      _attempts = 0;
      _controller.clear();
      _message = '';
      _stars.clear();
      _messageOpacity = 1;
    });
  }

  void _triggerStarAnimation() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      _stars = List.generate(14, (index) {
        final randomLeft = Random().nextDouble() * screenWidth;
        final randomDelay = Random().nextDouble();
        return AnimatedStar(
          left: randomLeft,
          delay: randomDelay,
          animationController: _animationController,
        );
      });
    });
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 6,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
        foregroundColor: Colors.white,
      ),
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE3F2FD), Color(0xFFF6E9F0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.88),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 25, offset: Offset(10, 10)),
                    BoxShadow(color: Colors.white70, blurRadius: 20, offset: Offset(-10, -10)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '🎲 Number Guessing Game 🎲',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "I'm thinking of a number between 1 and 100...",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter your guess here',
                        filled: true,
                        fillColor: const Color(0xFFF6E9F0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 25),
                    buildButton('Guess!', Colors.deepPurple, _checkGuess),
                    const SizedBox(height: 12),
                    buildButton('New Game', Colors.purpleAccent, _resetGame),
                    const SizedBox(height: 30),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _messageOpacity,
                      child: Text(
                        _message,
                        style: TextStyle(
                          fontSize: 22,
                          color: _messageColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Floating stars
          ..._stars,
        ],
      ),
    );
  }
}
