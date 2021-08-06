import 'package:flutter/material.dart';

class NotificationOverlay extends StatefulWidget {
  final String title;
  final TextStyle? style;
  final OverlayEntry overlayEntry;
  final Duration durationToClose;
  final AlignmentGeometry align;
  final Color? color;
  const NotificationOverlay({
    Key? key,
    required this.title,
    required this.overlayEntry,
    this.style,
    this.durationToClose = const Duration(seconds: 5),
    this.align = Alignment.topCenter,
    this.color,
  }) : super(key: key);

  @override
  _NotificationOverlayState createState() => _NotificationOverlayState();
}

class _NotificationOverlayState extends State<NotificationOverlay> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> position;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    position = Tween<Offset>(begin: const Offset(0, -4), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));
    controller.forward();

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        Future.delayed(widget.durationToClose, () => widget.overlayEntry.remove());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: widget.align,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SlideTransition(
              position: position,
              child: GestureDetector(
                onTap: () {
                  widget.overlayEntry.remove();
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: widget.color ?? Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(widget.title, style: widget.style),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
