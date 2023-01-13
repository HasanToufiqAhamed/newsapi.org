import 'package:get/get.dart';
import 'package:flutter/material.dart';

void showBasicSnackBar({
  required String message,
  required bool success,
}) {
  if (Get.isSnackbarOpen) {
    return;
  }
  Get.rawSnackbar(
    snackPosition: SnackPosition.TOP,
    icon: success
        ? const Icon(
            Icons.task_alt_rounded,
            color: Colors.white,
          )
        : const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
    margin: const EdgeInsets.all(16),
    borderRadius: 10,
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
