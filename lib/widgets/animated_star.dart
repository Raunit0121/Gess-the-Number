import 'package:flutter/material.dart';

class AnimatedStar extends StatelessWidget {
  final double left;
  final double delay;
  final AnimationController animationController;

  const AnimatedStar({
    required this.left,
    required this.delay,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Tween(
      begin: MediaQuery.of(context).size.height,
      end: -50.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(delay, 1, curve: Curves.easeInOut),
      ),
    );

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Positioned(
          left: left,
          top: animation.value,
          child: const Text(
            '⭐',
            style: TextStyle(fontSize: 24),
          ),
        );
      },
    );
  }
}
