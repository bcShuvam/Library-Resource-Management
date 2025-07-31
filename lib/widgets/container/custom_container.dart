import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.width = 0.95,
    this.color,
    this.borderColor,
    this.applyShadow = false,
    this.verticalPad = 16.0,
    this.horizontalPad = 16.0,
    this.verticalMargin = 0,
    this.horizontalMargin = 0,
  });

  final Widget child;
  final double width;
  final double borderRadius;
  final Color? color;
  final Color? borderColor;
  final bool applyShadow;
  final double verticalPad;
  final double horizontalPad;
  final double verticalMargin;
  final double horizontalMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPad, vertical: verticalPad),
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin, horizontal: horizontalMargin),
      decoration: BoxDecoration(
        color: color ?? (Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1E1E1E)
          : Colors.white),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          // borderRadius: BorderRadius.circular(borderRadius),
        ),
        boxShadow: applyShadow
            ? [
          BoxShadow(
            color:
            Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1E1E1E).withOpacity(0.1)
                : Colors.white.withOpacity(0.1),
            // Colors.black.withOpacity(0.1),
            spreadRadius: 2.0,
            blurRadius: 1.0,
            offset: const Offset(3, 3),
          )
        ]
            : null,
      ),
      child: child,
    );
  }
}