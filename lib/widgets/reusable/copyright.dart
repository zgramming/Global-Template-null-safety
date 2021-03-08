import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:package_info/package_info.dart';

class CopyRightVersion extends StatefulWidget {
  const CopyRightVersion({
    this.copyRight,
    this.colorText = Colors.white,
    this.backgroundColor,
    this.showCopyRight = true,
    this.padding = const EdgeInsets.all(16.0),
  });
  final String? copyRight;
  final Color colorText;
  final Color? backgroundColor;
  final bool showCopyRight;
  final EdgeInsetsGeometry padding;
  @override
  _CopyRightVersionState createState() => _CopyRightVersionState();
}

class _CopyRightVersionState extends State<CopyRightVersion> {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    buildNumber: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
  );
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,
        () => GlobalFunction.packageInfo().then((value) => setState(() => packageInfo = value)));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: widget.colorText),
      child: Container(
        color: widget.backgroundColor,
        child: Padding(
          padding: widget.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                '${packageInfo.appName} | Version ${packageInfo.version}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              if (widget.showCopyRight)
                Text(
                  widget.copyRight ??
                      'Copyright ${GlobalFunction.formatY(DateTime.now())} \u00a9 Zeffry Reynando',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
