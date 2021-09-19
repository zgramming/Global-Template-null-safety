import 'dart:developer';

import 'package:flutter/material.dart';

/// Reference [https://flutteragency.com/jumping-dots-animation-in-flutter-flutter-agency/]
class JumpingDot extends StatefulWidget {
  const JumpingDot({
    Key? key,
    required this.numberOfDot,
    this.jumpingY = -20,
    this.dotColor = Colors.grey,
    this.durationInMilisecond = 200,
    this.dotSize = 10.0,
  }) : super(key: key);

  final int numberOfDot;
  final double jumpingY;
  final Color dotColor;
  final int durationInMilisecond;
  final double dotSize;
  @override
  _JumpingDotState createState() => _JumpingDotState();
}

class _JumpingDotState extends State<JumpingDot> with TickerProviderStateMixin {
  late final List<AnimationController> _animationControllers;
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
      log('dispose');
    }
    super.dispose();
  }

  void _initAnimation() {
    _animationControllers = List.generate(widget.numberOfDot, (index) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.durationInMilisecond),
      );
    }).toList();

    for (int i = 0; i < widget.numberOfDot; i++) {
      _animations.add(
        Tween<double>(begin: 0, end: widget.jumpingY).animate(_animationControllers[i]),
      );
    }

    for (int j = 0; j < widget.numberOfDot; j++) {
      _animationControllers[j].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationControllers[j].reverse();

          if (j != (widget.numberOfDot - 1)) {
            _animationControllers[j + 1].forward();
          }
        }

        if (j == (widget.numberOfDot - 1) && status == AnimationStatus.dismissed) {
          _animationControllers[0].forward();
        }
      });
    }

    _animationControllers.first.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.numberOfDot, (index) {
        return AnimatedBuilder(
          animation: _animationControllers[index],
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.all(3.0),
              child: Transform.translate(
                offset: Offset(0, _animations[index].value),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: widget.dotColor),
                  height: widget.dotSize,
                  width: widget.dotSize,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
