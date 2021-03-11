import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ConfirmationDeleteDialog extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;
  final Widget? title;
  final Widget? content;
  final String? deleteText;

  /// Digunakan jika dalam kasus dialog berada di atas modalbottomsheet
  ///
  final int totalNavigatorPop;

  const ConfirmationDeleteDialog({
    this.onCancel,
    this.onDelete,
    this.content,
    this.title,
    this.deleteText,
    this.totalNavigatorPop = 1,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title ?? const Text('Konfirmasi hapus'),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            onDelete!();
            // Navigator.of(context).pop();
            var totalPop = 0;
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              Navigator.popUntil(context, (route) => totalPop++ == totalNavigatorPop);
            });
          },
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: Text(deleteText ?? 'Hapus'),
        )
      ],
      content: content,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
