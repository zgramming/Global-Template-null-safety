import 'dart:async';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

class SplashScreenTemplate extends StatefulWidget {
  const SplashScreenTemplate({
    this.duration = 4,
    this.backgroundColor,
    required this.image,
    required this.navigateAfterSplashScreen,
    required this.copyRightVersion,
    this.gradient,
  });

  final int duration;
  final Color? backgroundColor;
  final CopyRightVersion copyRightVersion;
  final Gradient? gradient;
  final Widget image;
  final WidgetBuilder navigateAfterSplashScreen;

  @override
  _SplashScreenTemplateState createState() => _SplashScreenTemplateState();
}

class _SplashScreenTemplateState extends State<SplashScreenTemplate> {
  Future<void> navigationPage() async {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: widget.navigateAfterSplashScreen),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final durations = Duration(seconds: widget.duration);
      Timer(
        durations,
        () => navigationPage(),
      );
    });
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: widget.image,
            ),
            // Spacer(),
            widget.copyRightVersion,
          ],
        ),
      ),
    );
  }
}
