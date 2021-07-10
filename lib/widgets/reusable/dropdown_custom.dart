import 'package:flutter/material.dart';

class DropddownCustom<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;

  final bool isExpanded;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Decoration? border;
  final TextStyle? hintTextStyle;
  final String hintText;
  final Color? backgroundColor;
  final ValueChanged<T?>? onChanged;
  final Function(T? value)? onTapItem;
  final Widget Function(T? value) builder;
  final Widget? icon;
  final Widget? underline;
  const DropddownCustom({
    Key? key,
    required this.items,
    this.selectedItem,
    this.isExpanded = false,
    this.height,
    this.padding,
    this.border,
    this.hintTextStyle,
    this.hintText = 'Pilih item dibawah',
    this.backgroundColor,
    required this.onChanged,
    this.onTapItem,
    required this.builder,
    this.icon,
    this.underline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: border ??
          BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(10.0),
          ),
      child: DropdownButton<T>(
        onChanged: onChanged,
        value: selectedItem,
        hint: Text(
          hintText,
          style: hintTextStyle,
        ),
        dropdownColor: backgroundColor,
        icon: icon,
        isExpanded: isExpanded,
        itemHeight: height,
        underline: underline ?? const SizedBox(),
        items: items
            .map(
              (e) => DropdownMenuItem<T>(
                value: e,
                onTap: onTapItem != null ? () => onTapItem!(e) : null,
                child: builder(e),
              ),
            )
            .toList(),
      ),
    );
  }
}
