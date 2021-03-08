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
  });

  final int duration;
  final Widget image;
  final WidgetBuilder navigateAfterSplashScreen;
  final Color? backgroundColor;
  final CopyRightVersion copyRightVersion;

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
      color: widget.backgroundColor ?? Theme.of(context).primaryColor,
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
