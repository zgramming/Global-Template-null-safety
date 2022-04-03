import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../global_template.dart';

class ShowImageNetwork extends StatelessWidget {
  const ShowImageNetwork({
    Key? key,
    required this.imageUrl,
    this.isCircle = false,
    this.imageCircleRadius = 35,
    this.imageCircleElevation = 0,
    this.imageBorderRadius,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.fit,
    this.blendMode,
    this.onErrorImage,
    this.loadingBuilder,
    this.width,
    this.height,
  }) : super(key: key);

  final String imageUrl;

  ///! Setting height
  final double? height;

  ///! Setting width
  final double? width;

  ///! Setting Jika Ingin Image Lingkaran
  final bool isCircle;

  ///! Setting Image Circle Radius
  final double imageCircleRadius;

  ///! Image Circle Elevation
  final double imageCircleElevation;

  ///! Setting Image Border Radius
  final BorderRadius? imageBorderRadius;

  ///! Setting Padding Image
  final EdgeInsetsGeometry padding;

  ///! Setting Align Image
  final AlignmentGeometry alignment;

  ///! Settings fit Image
  final BoxFit? fit;

  ///! Blendmode
  final BlendMode? blendMode;

  ///! Handle Error Image
  final Widget Function(BuildContext context, String url, dynamic error)? onErrorImage;

  ///! Handle when image loading
  final Widget Function(BuildContext context, String imageUrl)? loadingBuilder;
  @override
  Widget build(BuildContext context) {
    final image = Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: imageBorderRadius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          colorBlendMode: blendMode,
          imageUrl: imageUrl,
          height: sizes.height(context) / (height ?? 5),
          width: sizes.width(context) / (width ?? 5),
          errorWidget: onErrorImage ??
              (BuildContext context, String url, dynamic error) {
                return Center(
                  child: IconButton(
                    icon: const Icon(Icons.error),
                    onPressed: () {
                      debugPrint('${error.runtimeType}');
                      debugPrint(url);
                    },
                  ),
                );
              },
          placeholder: loadingBuilder ??
              (ctx, url) => CircularProgressIndicator(
                    backgroundColor: colorPallete.accentColor,
                  ),
          fit: fit,
          alignment: alignment as Alignment,
        ),
      ),
    );

    if (isCircle) {
      return Padding(
        padding: padding,
        child: Card(
          margin: EdgeInsets.zero,
          shape: const CircleBorder(),
          elevation: imageCircleElevation,
          clipBehavior: Clip.antiAlias,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: sizes.width(context) / imageCircleRadius,
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
        ),
      );
    } else {
      return image;
    }
  }
}
