import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    Key? key,
    this.titleAlign = Alignment.center,
    this.titlePadding = const EdgeInsets.all(8),
    this.subtitleAlign,
    this.subtitlePadding,
    this.logo,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final AlignmentGeometry titleAlign;
  final EdgeInsetsGeometry titlePadding;
  final AlignmentGeometry? subtitleAlign;
  final EdgeInsetsGeometry? subtitlePadding;
  final Widget? logo;
  final Widget? title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 6,
          child: Center(
            child: logo ??
                Icon(
                  Icons.design_services,
                  size: sizes.width(context),
                ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: titlePadding,
            alignment: titleAlign,
            child: title,
          ),
        ),
        Expanded(
          child: Container(
            padding: subtitlePadding,
            alignment: subtitleAlign,
            child: subtitle,
          ),
        ),
      ],
    );
  }
}
