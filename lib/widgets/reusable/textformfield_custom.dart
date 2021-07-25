import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldCustom extends StatefulWidget {
  const TextFormFieldCustom({
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.minLines,
    this.maxLines,
    this.focusNode,
    this.borderColor,
    this.borderFocusColor,
    this.inputFormatter,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.hintText,
    this.labelText,
    this.labelStyle,
    this.hintStyle,
    this.errorBorder,
    this.errorStyle,
    this.errorMessage,
    this.onSaved,
    this.textStyle,
    this.prefixTextStyle,
    this.suffixTextStyle,
    this.onObsecurePasswordIcon,
    this.onObsecurePasswordColor,
    this.textCapitalization = TextCapitalization.none,
    this.errorMaxLines = 2,
    this.radius = 8,
    this.padding = const EdgeInsets.only(bottom: 14.0, left: 14.0, right: 14.0, top: 14.0),
    this.readOnly = false,
    this.autoFocus = false,
    this.centerText = false,
    this.isDone = false,
    this.isPassword = false,
    this.disableOutlineBorder = true,
    this.isEnabled = true,
    this.backgroundColor = Colors.white,
    this.activeColor,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onTap,
  });
  final bool isPassword;
  final bool isEnabled;
  final bool isDone;
  final bool centerText;
  final bool disableOutlineBorder;
  final bool autoFocus;
  final bool readOnly;

  final Color backgroundColor;
  final Color? activeColor;
  final Color? borderColor;
  final Color? borderFocusColor;

  final EdgeInsetsGeometry padding;

  /// Icon sebelah kiri
  final Widget? prefixIcon;

  /// Icon sebelah kanan
  final Widget? suffixIcon;

  final IconData Function(bool isObsecure)? onObsecurePasswordIcon;
  final Color Function(bool isObsecure)? onObsecurePasswordColor;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final String? errorMessage;

  final int? minLines;
  final int? maxLines;
  final int errorMaxLines;

  final double radius;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  final TextStyle? errorStyle;
  final TextStyle? textStyle;
  final TextStyle? prefixTextStyle;
  final TextStyle? suffixTextStyle;
  final TextStyle? labelStyle;

  final TextCapitalization textCapitalization;

  final InputBorder? errorBorder;

  final FocusNode? focusNode;

  final List<TextInputFormatter>? inputFormatter;

  final TextEditingController? controller;

  final TextStyle? hintStyle;

  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final VoidCallback? onTap;

  @override
  _TextFormFieldCustomState createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  bool _obsecurePassword = true;
  late bool _obsecureText;
  @override
  Widget build(BuildContext context) {
    if (widget.isPassword && _obsecurePassword) {
      _obsecureText = true;
    } else {
      _obsecureText = false;
    }
    return Stack(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            colorScheme:
                ThemeData().colorScheme.copyWith(primary: widget.activeColor ?? widget.borderColor),
          ),
          child: TextFormField(
            onTap: widget.onTap,
            style: widget.textStyle,
            readOnly: widget.readOnly,
            textCapitalization: widget.textCapitalization,
            autofocus: widget.autoFocus,
            controller: widget.controller,
            textAlign: widget.centerText ? TextAlign.center : TextAlign.left,
            obscureText: _obsecureText,
            enabled: widget.isEnabled,
            initialValue: widget.initialValue,
            minLines: widget.minLines,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            decoration: InputDecoration(
              suffixStyle: widget.suffixTextStyle,
              prefixStyle: widget.prefixTextStyle,
              isDense: true,
              fillColor: widget.disableOutlineBorder ? Colors.transparent : widget.backgroundColor,
              filled: true,
              hintStyle: widget.hintStyle,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        widget.onObsecurePasswordIcon != null
                            ? widget.onObsecurePasswordIcon!(_obsecurePassword)
                            : _obsecurePassword
                                ? Icons.lock
                                : Icons.lock_open,
                        color: _obsecurePassword ? Colors.grey[600] : widget.activeColor,
                      ),
                      onPressed: () => setState(() => _obsecurePassword = !_obsecurePassword),
                    )
                  : widget.suffixIcon,
              hintText: widget.hintText,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              errorMaxLines: widget.errorMaxLines,
              errorStyle: widget.errorStyle,
              errorBorder: widget.errorBorder,
              errorText: widget.errorMessage,
              border: widget.disableOutlineBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
              enabledBorder: widget.disableOutlineBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.borderColor ?? Colors.grey[400]!,
                      ),
                    ),
              focusedBorder: widget.disableOutlineBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.borderFocusColor ?? (widget.borderColor ?? Colors.grey[400]!),
                      ),
                    ),
              contentPadding: widget.padding,
            ),
            textInputAction: widget.isDone ? TextInputAction.done : widget.textInputAction,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatter,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            validator: widget.validator,
            onSaved: widget.onSaved,
          ),
        ),
      ],
    );
  }
}
