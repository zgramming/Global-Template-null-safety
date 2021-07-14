import 'package:flutter/material.dart';

enum BorderType { outline, underline }

class DropdownFormFieldCustom<T> extends StatelessWidget {
  final List<T?> items;
  final Widget Function(T? item) itemBuilder;
  final VoidCallback? onTapItem;
  final AutovalidateMode? autoValidateMode;
  final T? selectedItem;
  final String? Function(T? value)? validator;
  final void Function(T? value)? onChanged;
  final void Function(T? value)? onSaved;
  final void Function(List<T?> items)? onTapDropdown;
  final void Function(List<T?> items)? onLongpressDropdown;
  final bool isExpanded;
  final Widget Function(BuildContext context, T? value)? selectedItemBuilder;
  final TextStyle? textStyle;
  final TextStyle? labelTextStyle;
  final double? itemHeight;
  final String labelText;
  final String hintText;
  final String? prefixText;
  final String? suffixText;
  final EdgeInsetsGeometry? padding;
  final Widget? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BorderType borderType;
  final BorderSide borderSide;
  final BorderRadius borderRadius;
  final Color? borderColor;
  const DropdownFormFieldCustom({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.onTapItem,
    this.onTapDropdown,
    this.onLongpressDropdown,
    this.autoValidateMode,
    this.selectedItem,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.isExpanded = true,
    this.selectedItemBuilder,
    this.textStyle,
    this.labelTextStyle,
    this.itemHeight,
    this.labelText = 'Label Text',
    this.hintText = 'Hint Text',
    this.prefixText,
    this.suffixText,
    this.padding,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.borderType = BorderType.outline,
    this.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
      bottomLeft: Radius.circular(4.0),
      bottomRight: Radius.circular(4.0),
    ),
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputBorder? border;
    switch (borderType) {
      case BorderType.outline:
        border = OutlineInputBorder(borderRadius: borderRadius, borderSide: borderSide);
        break;
      default:
        border = UnderlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
        );
        break;
    }
    return InkWell(
      onTap: onTapDropdown == null ? null : () => onTapDropdown!(items),
      onLongPress: onLongpressDropdown == null ? null : () => onLongpressDropdown!(items),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelTextStyle,
          suffixIcon: suffixIcon,
          prefixText: prefixText,
          suffixText: suffixText,
          prefixIcon: prefixIcon,
          contentPadding: padding ?? const EdgeInsets.all(14.0),
          hintText: hintText,
          border: border,
          enabledBorder: border.copyWith(
            borderSide: borderSide.copyWith(color: borderColor ?? Colors.grey[400]!),
          ),
        ),
        autovalidateMode: autoValidateMode,
        value: selectedItem,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        hint: hint,
        isExpanded: isExpanded,
        selectedItemBuilder: selectedItemBuilder == null
            ? null
            : (context) => items.map((e) => selectedItemBuilder!(context, e)).toList(),
        style: textStyle,
        itemHeight: itemHeight,
        items: items
            .map((e) => DropdownMenuItem<T>(
                  value: e,
                  onTap: onTapItem,
                  child: itemBuilder(e),
                ))
            .toList(),
      ),
    );
  }
}
