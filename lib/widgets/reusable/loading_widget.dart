import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final Curve? curve;
  final List<Color>? colorGradient;
  const LoadingWidget({
    Key? key,
    required this.child,
    this.duration,
    this.curve,
    this.colorGradient,
  }) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(seconds: 1),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        Positioned.fill(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return FractionallySizedBox(
                widthFactor: .3,
                alignment: AlignmentGeometryTween(
                      begin: const Alignment(-2, 0),
                      end: const Alignment(2, 0),
                    )
                        .chain(CurveTween(curve: widget.curve ?? Curves.easeOutSine))
                        .evaluate(controller) ??
                    Alignment.center,
                child: child,
              );
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // begin: Alignment.topLeft,
                  // end: Alignment.bottomRight,
                  colors: widget.colorGradient ??
                      [
                        Colors.white.withOpacity(.0),
                        Colors.white.withOpacity(.8),
                      ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
