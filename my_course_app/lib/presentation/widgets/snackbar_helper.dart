import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
class SnackBarHelper {
  SnackBarHelper._();
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      AppColors.success,
      Icons.check_circle,
    );
  }
  static void showError(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      AppColors.error,
      Icons.error_outline,
    );
  }
  static void showInfo(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      AppColors.info,
      Icons.info_outline,
    );
  }
  static void _showSnackBar(
    BuildContext context,
    String message,
    Color backgroundColor,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: AppColors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}