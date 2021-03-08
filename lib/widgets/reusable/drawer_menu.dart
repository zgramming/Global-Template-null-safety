import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Widget trailing;
  final bool showDivider;
  const DrawerMenu({
    this.title = 'Menu',
    this.trailing = const Icon(Icons.home),
    this.showDivider = false,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(title),
          trailing: trailing,
        ),
        if (showDivider) const Divider(),
      ],
    );
  }
}
