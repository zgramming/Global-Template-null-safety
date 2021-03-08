import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

enum TypeAction { deleteAndEdit, delete, edit, none }

class ActionModalBottomSheet extends StatelessWidget {
  final WrapAlignment align;
  final double spacing;
  final List<ActionCircleButton> children;
  final TypeAction typeAction;
  final TextDirection textDirection;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ActionModalBottomSheet({
    required this.typeAction,
    this.align = WrapAlignment.end,
    this.spacing = 20.0,
    this.children = const <ActionCircleButton>[],
    this.textDirection = TextDirection.ltr,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    bool deleteIsVisible;
    bool editIsVisible;

    switch (typeAction) {
      case TypeAction.delete:
        deleteIsVisible = true;
        editIsVisible = false;
        break;
      case TypeAction.edit:
        deleteIsVisible = false;
        editIsVisible = true;
        break;
      case TypeAction.none:
        deleteIsVisible = false;
        editIsVisible = false;
        break;
      default:
        deleteIsVisible = true;
        editIsVisible = true;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        alignment: align,
        spacing: spacing,
        textDirection: textDirection,
        children: [
          ActionCircleButton(
            isVisible: deleteIsVisible,
            backgroundColor: colorPallete.red,
            foregroundColor: colorPallete.white,
            onTap: onDelete,
          ),
          ActionCircleButton(
            isVisible: editIsVisible,
            backgroundColor: colorPallete.primaryColor,
            foregroundColor: colorPallete.white,
            icon: Icons.mode_edit,
            onTap: onEdit,
          ),
          ...children
        ],
      ),
    );
  }
}
