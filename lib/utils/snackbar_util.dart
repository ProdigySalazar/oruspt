import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType { success, error, info, warning }

void showSnackbar({
  required String title,
  required String message,
  SnackbarType type = SnackbarType.success,
}) {
  Color bgColor;
  Color textColor;
  IconData iconData;

  switch (type) {
    case SnackbarType.error:
      bgColor = Colors.red.shade50;
      textColor = Colors.red.shade800;
      iconData = Icons.error_outline;
      break;
    case SnackbarType.info:
      bgColor = Colors.blue.shade50;
      textColor = Colors.blue.shade800;
      iconData = Icons.info_outline;
      break;
    case SnackbarType.warning:
      bgColor = Colors.orange.shade50;
      textColor = Colors.orange.shade800;
      iconData = Icons.warning_amber_outlined;
      break;
    case SnackbarType.success:
      bgColor = Colors.green.shade50;
      textColor = Colors.green.shade800;
      iconData = Icons.check_circle_outline;
  }

  Get.snackbar(
    title,
    message,
    backgroundColor: bgColor,
    colorText: textColor,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    borderRadius: 12,
    icon: Icon(iconData, color: textColor),
    duration: const Duration(seconds: 2),
  );
}
