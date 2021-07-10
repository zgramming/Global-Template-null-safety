import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

class SplashScreenTemplate extends StatefulWidget {
  const SplashScreenTemplate({
    this.duration = 4,
    this.backgroundColor,
    this.gradient,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.onDoneTimer,
    required this.children,
  });

  final int duration;
  final Color? backgroundColor;
  final Gradient? gradient;
  final dynamic Function(bool isTimerDone) onDoneTimer;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  _SplashScreenTemplateState createState() => _SplashScreenTemplateState();
}

class _SplashScreenTemplateState extends State<SplashScreenTemplate> {
  bool _isTimerDone = false;
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timer.tick >= widget.duration) {
          setState(() {
            if (mounted) {
              _isTimerDone = true;
              Future.delayed(const Duration(milliseconds: 100), () {
                widget.onDoneTimer(_isTimerDone);
              });
            }
            log('done');
            timer.cancel();
          });
        } else {
          log('tick ${timer.tick}');
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (widget.gradient == null)
            ? widget.backgroundColor ?? Theme.of(context).primaryColor
            : null,
        gradient: widget.gradient,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: sizes.statusBarHeight(context)),
        child: Column(
          crossAxisAlignment: widget.crossAxisAlignment,
          children: widget.children,
        ),
      ),
    );
  }
}
