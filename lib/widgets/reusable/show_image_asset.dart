import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

class ShowImageAsset extends StatelessWidget {
  const ShowImageAsset({
    required this.imageUrl,
    this.imageSize,
    this.imageCircleRadius = 35,
    this.isCircle = false,
    this.circleBacgroundColor,
    this.circleBorderColor,
    this.circleBorderThick = 1.0,
    this.color,
    this.padding = const EdgeInsets.all(0),
    this.alignment = Alignment.center,
    this.fit,
    this.onErrorImage,
    this.scale,
  });

  final String imageUrl;

  ///! Setting size image
  final double? imageSize;

  ///! Setting Jika Ingin Image Lingkaran
  final bool isCircle;

  ///! Setting Image Circle Radius
  final double imageCircleRadius;

  ///! Setting Padding Image
  final EdgeInsetsGeometry padding;

  ///! Setting Align Image
  final AlignmentGeometry alignment;

  ///! Settings fit Image
  final BoxFit? fit;

  ///! Setting Color Image
  final Color? color;

  ///! Setting Circle Color Image
  final Color? circleBacgroundColor;

  ///! Setting Border Color Image
  final Color? circleBorderColor;

  ///! Setting thick circle border image
  final double circleBorderThick;

  final double? scale;

  ///! Handle Error Image
  final Widget Function(BuildContext context, Object exception, StackTrace? stackTrace)? onErrorImage;
  @override
  Widget build(BuildContext context) {
    final image = Container(
      padding: padding,
      child: Image.asset(
        imageUrl,
        color: color,
        height: sizes.height(context) / (imageSize ?? double.infinity),
        width: sizes.width(context) / (imageSize ?? double.infinity),
        scale: scale,
        fit: fit,
        alignment: alignment,
        errorBuilder: onErrorImage ??
            (context, error, stackTrace) {
              return Center(
                child: IconButton(
                  icon: const Icon(Icons.error),
                  onPressed: () {
                    debugPrint('Error $error || stackTrace $stackTrace');
                  },
                ),
              );
            },
      ),
    );
    return isCircle
        ? Container(
            padding: padding,
            child: ClipOval(
              // child: image,
              child: Image.asset(
                imageUrl,
                height: sizes.height(context) / (imageSize ?? double.infinity),
                width: sizes.width(context) / (imageSize ?? double.infinity),
                fit: fit,
                scale: scale,
                alignment: alignment,
                errorBuilder: onErrorImage ??
                    (context, error, stackTrace) {
                      debugPrint('Error $error || stackTrace $stackTrace');
                      return Center(
                          child: IconButton(icon: const Icon(Icons.error), onPressed: () => ''));
                    },
              ),
            ),
          )
        : image;
  }
}
