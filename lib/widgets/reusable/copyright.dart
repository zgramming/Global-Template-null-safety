import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:package_info/package_info.dart';

class CopyRightVersion extends StatefulWidget {
  const CopyRightVersion({
    Key? key,
    this.copyRight,
    this.colorText = Colors.white,
    this.showCopyRight = true,
    this.decoration,
    this.padding = const EdgeInsets.all(16.0),
    this.builder,
  }) : super(key: key);
  final String? copyRight;
  final Color colorText;
  final bool showCopyRight;
  final Decoration? decoration;
  final EdgeInsetsGeometry padding;
  final Widget Function(PackageInfo info, DateTime dateNow)? builder;
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
    Future.delayed(
      Duration.zero,
      () => GlobalFunction.packageInfo().then((value) => setState(() => packageInfo = value)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: widget.colorText),
      child: Container(
        decoration: widget.decoration,
        child: Padding(
          padding: widget.padding,
          child: widget.builder == null
              ? Column(
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
                )
              : widget.builder!(packageInfo, DateTime.now()),
        ),
      ),
    );
  }
}
