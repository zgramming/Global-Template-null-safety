import 'package:flutter/material.dart';

class ActionCircleButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isVisible;
  final EdgeInsetsGeometry padding;

  const ActionCircleButton({
    this.radius = 25.0,
    this.icon = Icons.delete,
    this.backgroundColor = Colors.grey,
    this.foregroundColor = Colors.black,
    this.padding = const EdgeInsets.all(6.0),
    this.onTap,
    this.isVisible = true,
  });
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          child: FittedBox(
            child: Padding(
              padding: padding,
              child: Icon(icon),
            ),
          ),
        ),
      ),
    );
  }
}
