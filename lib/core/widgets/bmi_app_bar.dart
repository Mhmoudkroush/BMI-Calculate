import 'package:bmi_calculate/core/color_manager.dart';
import 'package:bmi_calculate/core/responsive.dart';
import 'package:flutter/material.dart';

class BmiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BmiAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'BMI Calculator',
        style: TextStyle(
          color: Colors.white,
          fontSize: context.r(24),
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: ColorManager.secondClor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }
}
