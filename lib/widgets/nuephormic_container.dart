import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final List<BoxShadow>? shadows;
  final Color? backgroundColor;

  const NeumorphicContainer({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius,
    this.shadows,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: Container(
        margin: margin,
        padding: padding ?? EdgeInsets.all(AppConfig.defaultPadding),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppConfig.defaultBorderRadius,
          ),
        ),
        child: child,
      ),
    );
  }
} 