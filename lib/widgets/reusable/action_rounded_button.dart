import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

class ActionRoundedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;
  final Widget icon;
  final String title;
  final double radius;
  final double size;

  /// Default 3 , Less than this make bigger
  final double textPadding;
  final bool isVisible;
  final Widget replacementWidgetIfInvisible;

  const ActionRoundedButton({
    required this.size,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.replacementWidgetIfInvisible = const SizedBox(),
    this.isVisible = true,
    this.title = '',
    this.radius = 10,
    this.textPadding = 3.0,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: isVisible,
          replacement: replacementWidgetIfInvisible,
          child: Container(
            height: sizes.width(context) / size,
            width: sizes.width(context) / size,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: backgroundColor ?? colorPallete.primaryColor,
              borderRadius: BorderRadius.circular(radius),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(3, 3),
                  color: Colors.black45,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(textPadding),
                    child: FittedBox(child: icon),
                  ),
                ),
                if (title.isEmpty) ...[
                  const SizedBox(),
                ] else ...[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style:
                        appTheme.caption(context)!.copyWith(color: foregroundColor ?? Colors.black),
                  ),
                ]
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: colorPallete.transparent,
            child: InkWell(onTap: onTap),
          ),
        )
      ],
    );
  }
}
