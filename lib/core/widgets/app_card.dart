import 'package:bmi_calculate/core/color_manager.dart';
import 'package:bmi_calculate/core/responsive.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.color = ColorManager.boxs,
    this.padding,
  });

  final Widget child;
  final Color color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(context.r(8)),
      padding: padding ?? EdgeInsets.all(context.r(16)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
