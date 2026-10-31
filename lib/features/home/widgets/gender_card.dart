import 'package:bmi_calculate/core/color_manager.dart';
import 'package:bmi_calculate/core/responsive.dart';
import 'package:bmi_calculate/core/widgets/app_card.dart';
import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  const GenderCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        color: isSelected ? ColorManager.button : ColorManager.boxs,
        padding: EdgeInsets.symmetric(
          vertical: context.r(20),
          horizontal: context.r(10),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Icon(icon, size: context.r(80), color: Colors.white),
              Text(
                label,
                style: TextStyle(
                  color: ColorManager.text,
                  fontSize: context.r(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
