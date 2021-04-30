import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

// ignore: constant_identifier_names
enum OnboardingItemAnimationType { NONE, RTL, LTR }

class OnboardingItem extends StatefulWidget {
  const OnboardingItem({
    Key? key,
    required this.title,
    this.titlePadding = const EdgeInsets.symmetric(horizontal: 12),
    this.subtitlePadding = const EdgeInsets.symmetric(horizontal: 12),
    this.textTitleAlign = TextAlign.center,
    this.textSubtitleAlign = TextAlign.center,
    this.titleAlign = Alignment.center,
    this.subtitleAlign = Alignment.center,
    this.logo,
    this.titleStyle,
    this.subtitleStyle,
    this.subtitle,
    this.flexLogo = 4,
    this.flexTitle = 4,
    this.flexSubtitle = 4,
    this.animationType = OnboardingItemAnimationType.RTL,
  }) : super(key: key);

  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry subtitlePadding;
  final TextAlign textTitleAlign;
  final TextAlign textSubtitleAlign;
  final AlignmentGeometry? titleAlign;
  final AlignmentGeometry? subtitleAlign;
  final Widget? logo;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final String title;
  final String? subtitle;
  final int flexLogo;
  final int flexTitle;
  final int flexSubtitle;
  final OnboardingItemAnimationType animationType;

  @override
  _OnboardingItemState createState() => _OnboardingItemState();
}

class _OnboardingItemState extends State<OnboardingItem> with SingleTickerProviderStateMixin {
  /// Initialize Animation
  late final AnimationController animationController;
  late final Animation<Offset> translateAnimation;
  late final Animation<double> scaleAnimation;
  late final Animation<double> rotateAnimation;

  Offset _offsetValue = const Offset(0, 0);

  @override
  void initState() {
    switch (widget.animationType) {
      case OnboardingItemAnimationType.NONE:
        _offsetValue = const Offset(0, 0);
        break;
      case OnboardingItemAnimationType.LTR:
        _offsetValue = const Offset(-200, 0);
        break;
      case OnboardingItemAnimationType.RTL:
        _offsetValue = const Offset(200, 0);
        break;
    }

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    translateAnimation = Tween<Offset>(begin: _offsetValue, end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: animationController, curve: const Interval(0.1, 1)));

    scaleAnimation = Tween<double>(begin: 1, end: 1.5)
        .animate(CurvedAnimation(parent: animationController, curve: const Interval(0.7, 1)));

    rotateAnimation = Tween<double>(begin: 0, end: -0.25)
        .animate(CurvedAnimation(parent: animationController, curve: const Interval(0.9, 1)));

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: widget.flexLogo,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: translateAnimation.value,
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: Transform.rotate(
                    angle: rotateAnimation.value,
                    child: Center(
                      child: widget.logo ?? Icon(Icons.design_services, size: sizes.width(context)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: widget.flexTitle,
          child: Container(
            padding: widget.titlePadding,
            alignment: widget.titleAlign,
            child: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: widget.textTitleAlign,
              style: widget.titleStyle,
            ),
          ),
        ),
        if (widget.subtitle != null || (widget.subtitle ?? '').isNotEmpty)
          Expanded(
            flex: widget.flexSubtitle,
            child: Container(
              padding: widget.subtitlePadding,
              alignment: widget.subtitleAlign,
              child: Text(
                widget.subtitle!,
                textAlign: widget.textSubtitleAlign,
                style: widget.subtitleStyle,
              ),
            ),
          ),
      ],
    );
  }
}
