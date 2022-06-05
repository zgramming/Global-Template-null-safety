import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InitialSplashTemplate extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    PackageInfo? applicationInfo,
  ) builder;

  const InitialSplashTemplate({required this.builder});
  @override
  _InitialSplashTemplateState createState() => _InitialSplashTemplateState();
}

class _InitialSplashTemplateState extends State<InitialSplashTemplate> {
  PackageInfo? _packageInfo;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      PackageInfo.fromPlatform().then((packageInfo) => setState(() => _packageInfo = packageInfo));
    });
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _packageInfo);
}
