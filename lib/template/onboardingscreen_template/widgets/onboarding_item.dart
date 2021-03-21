import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    Key? key,
    this.titlePadding = const EdgeInsets.symmetric(horizontal: 12),
    this.subtitlePadding = const EdgeInsets.symmetric(horizontal: 12),
    this.logo,
    this.title = 'Default title',
    this.subtitle = 'Default Subtitle',
    this.textTitleAlign = TextAlign.center,
    this.textSubtitleAlign = TextAlign.center,
    this.titleStyle,
    this.subtitleStyle,
    this.titleAlign = Alignment.center,
    this.subtitleAlign = Alignment.center,
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
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 8,
          child: Center(
            child: logo ?? Icon(Icons.design_services, size: sizes.width(context)),
          ),
        ),
        Expanded(
          child: Container(
            padding: titlePadding,
            alignment: titleAlign,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: textTitleAlign,
              style: titleStyle,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: subtitlePadding,
            alignment: subtitleAlign,
            child: Text(
              subtitle,
              textAlign: textSubtitleAlign,
              style: subtitleStyle,
            ),
          ),
        ),
      ],
    );
  }
}
