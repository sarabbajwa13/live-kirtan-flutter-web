import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NeumorphicButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Color? backgroundColor;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? shadows;

  const NeumorphicButton({
    Key? key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.isFullWidth = false,
    this.padding,
    this.shadows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: Container(
          padding: padding ?? const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.backgroundColor,
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ),
    );
  }
}