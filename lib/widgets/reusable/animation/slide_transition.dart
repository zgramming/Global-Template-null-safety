import 'package:flutter/material.dart';

enum AnimateFrom { fromLeft, fromRight, fromTop, fromBottom }

class GSlideTransition extends StatefulWidget {
  const GSlideTransition({
    required this.child,
    this.curve = Curves.fastOutSlowIn,
    this.duration = const Duration(seconds: 2),
    this.position = AnimateFrom.fromRight,
  });
  final Duration duration;
  final Widget child;
  final Curve curve;
  final AnimateFrom position;
  @override
  GSlideTransitionState createState() => GSlideTransitionState();
}

class GSlideTransitionState extends State<GSlideTransition> with TickerProviderStateMixin {
  late Animation<Offset> slide;
  late AnimationController slideController;
  @override
  void initState() {
    Offset offset;
    if (widget.position == AnimateFrom.fromBottom) {
      offset = const Offset(0.0, -100);
    } else if (widget.position == AnimateFrom.fromTop) {
      offset = const Offset(0.0, 100);
    } else if (widget.position == AnimateFrom.fromLeft) {
      offset = const Offset(100.0, 0.0);
    } else if (widget.position == AnimateFrom.fromRight) {
      offset = const Offset(-100, 0.0);
    } else {
      offset = const Offset(0.0, -100);
    }
    debugPrint('$offset');
    slideController = AnimationController(vsync: this, duration: widget.duration);
    slide = Tween<Offset>(begin: offset, end: Offset.zero)
        .animate(CurvedAnimation(parent: slideController, curve: widget.curve));
    slideController.forward();
    super.initState();
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) => Transform.translate(
        offset: slide.value,
        child: child,
      ),
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('${widget.position}');
    return buildAnimation();
  }
}
