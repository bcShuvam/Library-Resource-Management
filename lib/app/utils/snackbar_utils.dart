import 'package:flutter/material.dart';
import 'package:library_resource_management/themes/custom_colors.dart';
import 'package:library_resource_management/widgets/texts/custom_text.dart';

class SnackBarUtils {
  static void showSuccessSnackbar(
      BuildContext context, {
        String title = 'Success',
        required String message,
        bool showOnTop = false, // New parameter
      }) {
    _showSnackbar(
      context,
      icon: Icons.check_circle,
      iconColor: Colors.white,
      backgroundColor: CustomColors.jadeGreen,
      title: title,
      message: message,
      showOnTop: showOnTop,
    );
  }

  static void showErrorSnackbar(
      BuildContext context, {
        String title = 'Error',
        required String message,
        bool showOnTop = false, // New parameter
      }) {
    _showSnackbar(
      context,
      icon: Icons.error_outline,
      iconColor: Colors.white,
      backgroundColor: CustomColors.lightRed,
      title: title,
      message: message,
      showOnTop: showOnTop,
    );
  }

  static void _showSnackbar(
      BuildContext context, {
        required IconData icon,
        required Color iconColor,
        required Color backgroundColor,
        required String title,
        required String message,
        bool showOnTop = false, // New parameter
      }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(3, 3), // Shadow only bottom & right
                blurRadius: 6,
              ),
            ],
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
        elevation: 0, // Shadow handled in BoxDecoration
        duration: const Duration(seconds: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: showOnTop
            ? const EdgeInsets.only(
            left: 16, right: 16, top: 12) // Top position
            : const EdgeInsets.only(
            left: 16, right: 16, bottom: 12), // Bottom position
      ),
    );
  }
}