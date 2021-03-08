import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

class TabBarWithoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TabBarWithoutAppBar({this.colorTabBar, this.tabBar});

  final Color? colorTabBar;
  final TabBar? tabBar;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: sizes.statusBarHeight(context)),
      color: colorTabBar,
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => tabBar!.preferredSize;
}
