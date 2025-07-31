import 'package:flutter/material.dart';
import 'package:library_resource_management/themes/custom_colors.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';

class SnackBarUtils {
  static void showSuccessSnackbar(
      BuildContext context, {
        String title = 'Success',
        required String message,
      }) {
    _showSnackbar(
      context,
      icon: Icons.check_circle,
      iconColor: Colors.white,
      backgroundColor: CustomColors.jadeGreen,
      title: title,
      message: message,
    );
  }

  static void showErrorSnackbar(
      BuildContext context, {
        String title = 'Error',
        required String message,
      }) {
    _showSnackbar(
      context,
      icon: Icons.error_outline,
      iconColor: Colors.white,
      backgroundColor: CustomColors.lightRed,
      title: title,
      message: message,
    );
  }

  static void _showSnackbar(
      BuildContext context, {
        required IconData icon,
        required Color iconColor,
        required Color backgroundColor,
        required String title,
        required String message,
      }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      isHeading: true,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: message,
                      isSubContent: true,
                      color: Colors.white,
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        duration: const Duration(seconds: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
