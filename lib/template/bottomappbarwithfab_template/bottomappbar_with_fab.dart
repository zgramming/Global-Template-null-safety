import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

class BottomAppBarWithFAB extends StatefulWidget {
  final List<BottomAppBarItem> items;
  final NotchedShape? notchedShape;
  final double notchedMargin;
  final double elevation;
  final double? iconSize;
  final double height;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final ValueChanged<int> onTap;
  final MainAxisAlignment alignment;

  const BottomAppBarWithFAB({
    required this.items,
    required this.onTap,
    this.notchedShape,
    this.notchedMargin = 4.0,
    this.elevation = 8.0,
    this.iconSize,
    this.height = 56,
    this.backgroundColor,
    this.selectedColor,
    this.unSelectedColor,
    this.alignment = MainAxisAlignment.spaceAround,
  }) : assert(items.length % 2 == 0 && items.length <= 4,
            "Items length must be divided by 2 & Maximum 4 Icon");

  @override
  _BottomAppBarWithFABState createState() => _BottomAppBarWithFABState();
}

class _BottomAppBarWithFABState extends State<BottomAppBarWithFAB> {
  int _selectedIndex = 0;

  void _updateIndex(int index) {
    widget.onTap(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = List.generate(
      widget.items.length,
      (int index) => _buildItem(
        index: index,
        item: widget.items[index],
        onPressed: _updateIndex,
      ),
    );

    return BottomAppBar(
      key: widget.key,
      color: widget.backgroundColor ?? colorPallete.accentColor,
      shape: widget.notchedShape,
      elevation: widget.elevation,
      notchMargin: widget.notchedMargin,
      child: Row(
        mainAxisAlignment: widget.alignment,
        children: items,
      ),
    );
  }

  Widget _buildItem({
    required BottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    final Color? color = (_selectedIndex == index) ? widget.selectedColor : widget.unSelectedColor;
    return SizedBox(
      height: widget.height,
      child: InkWell(
        onTap: () => onPressed(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(
                item.iconData,
                size: widget.iconSize ?? sizes.width(context) / 14,
              ),
              color: color,
              onPressed: () => onPressed(index),
            )
          ],
        ),
      ),
    );
  }
}

class BottomAppBarItem {
  BottomAppBarItem({required this.iconData, this.text = ''});
  IconData iconData;
  String text;
}
