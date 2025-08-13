import 'package:flutter/material.dart';

class CustomElevatedIconButton extends StatelessWidget {
  const CustomElevatedIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.borderColor,
    this.width = 0.25,
    this.height = 40,
    this.borderRadius,
  });

  final Function() onPressed;
  final Widget icon;
  final Widget label;
  final Color? backgroundColor;
  final Color? borderColor;
  final double width;
  final double height;
  final double? borderRadius;
  // final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0.0,
        minimumSize: Size(
          MediaQuery.of(context).size.width * width,
          height,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 8.0),
          ),
        ),
        side: BorderSide(
          color: borderColor ?? Colors.transparent,
          style: BorderStyle.solid,
        ),
      ),
      icon: icon,
      label: label,
    );
  }
}
