import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///TODO: Bug When textformfield show message error
/// When message error show, position of SuffixIcon still same and make weird look.
/// Planning : Check if textformfield has error validate, then position suffix icon should be increase
class TextFormFieldCustom extends StatefulWidget {
  const TextFormFieldCustom({
    Key? key,
    this.isPassword = false,
    this.isEnabled = true,
    this.isDone = false,
    this.centerText = false,
    this.disableOutlineBorder = true,
    this.autoFocus = false,
    this.readOnly = false,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.only(bottom: 14.0, left: 14.0, right: 14.0, top: 14.0),
    this.errorMaxLines = 2,
    this.radius = 8,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.suffixIcon = const [],
    this.suffixIconConfiguration = const SuffixIconConfiguration(),
    this.textCapitalization = TextCapitalization.none,
    this.activeColor,
    this.prefixIcon,
    this.focusedErrorBorderStyle,
    this.focusedBorderStyle,
    this.disabledBorderStyle,
    this.enabledBorderStyle,
    this.defaultBorderStyle,
    this.errorBorderStyle,
    this.onObsecurePasswordIcon,
    this.onObsecurePasswordColor,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.errorMessage,
    this.minLines,
    this.maxLines,
    this.errorStyle,
    this.textStyle,
    this.prefixTextStyle,
    this.suffixTextStyle,
    this.labelStyle,
    this.focusNode,
    this.inputFormatter,
    this.controller,
    this.hintStyle,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.onSaved,
    this.onTap,
  }) : super(key: key);
  final bool isPassword;
  final bool isEnabled;
  final bool isDone;
  final bool centerText;
  final bool disableOutlineBorder;
  final bool autoFocus;
  final bool readOnly;

  final Color backgroundColor;
  final Color? activeColor;

  final EdgeInsetsGeometry padding;

  /// Icon sebelah kiri
  final Widget? prefixIcon;

  /// Icon sebelah kanan
  final List<Widget> suffixIcon;
  final SuffixIconConfiguration suffixIconConfiguration;

  final InputBorderStyle? focusedErrorBorderStyle;
  final InputBorderStyle? focusedBorderStyle;
  final InputBorderStyle? disabledBorderStyle;
  final InputBorderStyle? enabledBorderStyle;
  final InputBorderStyle? defaultBorderStyle;
  final InputBorderStyle? errorBorderStyle;

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
      alignment: Alignment.bottomRight,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: widget.activeColor,
                ),
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
              hintText: widget.hintText,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              errorMaxLines: widget.errorMaxLines,
              errorStyle: widget.errorStyle,
              errorText: widget.errorMessage,
              focusedBorder: widget.disableOutlineBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.focusedBorderStyle?.color ?? Colors.grey[400]!,
                        width: widget.focusedBorderStyle?.width ?? 1.0,
                      ),
                    ),
              disabledBorder: widget.disableOutlineBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.disabledBorderStyle?.color ?? Colors.grey[400]!,
                        width: widget.disabledBorderStyle?.width ?? 1.0,
                      ),
                    ),
              enabledBorder: widget.disableOutlineBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.enabledBorderStyle?.color ?? Colors.grey[400]!,
                        width: widget.enabledBorderStyle?.width ?? 1.0,
                      ),
                    ),
              border: widget.disableOutlineBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.defaultBorderStyle?.color ?? Colors.grey[400]!,
                        width: widget.defaultBorderStyle?.width ?? 1.0,
                      ),
                    ),
              errorBorder: widget.disableOutlineBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.errorBorderStyle?.color ?? Colors.grey[400]!,
                        width: widget.errorBorderStyle?.width ?? 1.0,
                      ),
                    ),
              focusedErrorBorder: widget.disableOutlineBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius),
                      borderSide: BorderSide(
                        color: widget.focusedErrorBorderStyle?.color ?? Colors.grey[400]!,
                        width: widget.focusedErrorBorderStyle?.width ?? 1.0,
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
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(
              top: widget.suffixIconConfiguration.topPosition,
              bottom: widget.suffixIconConfiguration.bottomPosition,
              right: widget.suffixIconConfiguration.rightPosition,
            ),
            child: widget.isPassword
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
                : Wrap(
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: widget.suffixIconConfiguration.runSpacing,
                    spacing: widget.suffixIconConfiguration.spacing,
                    children: widget.suffixIcon,
                  ),
          ),
        )
      ],
    );
  }
}

class InputBorderStyle {
  final Color? color;
  final double width;
  InputBorderStyle({
    this.color,
    this.width = 1.0,
  });
}

class SuffixIconConfiguration {
  final double topPosition;
  final double bottomPosition;
  final double rightPosition;
  final double spacing;
  final double runSpacing;
  const SuffixIconConfiguration({
    this.topPosition = 0,
    this.bottomPosition = 0,
    this.rightPosition = 0,
    this.spacing = 10,
    this.runSpacing = 0,
  });
}
