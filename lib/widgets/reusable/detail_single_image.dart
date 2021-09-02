import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailSingleImage extends StatefulWidget {
  const DetailSingleImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final Widget image;

  @override
  _DetailSingleImageState createState() => _DetailSingleImageState();
}

class _DetailSingleImageState extends State<DetailSingleImage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              panEnabled: false,
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: widget.image,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const CircleAvatar(
                child: Icon(Icons.arrow_back),
              ),
            ),
          )
        ],
      ),
    );
  }
}
