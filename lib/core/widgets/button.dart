import 'package:bmi_calculate/core/color_manager.dart';
import 'package:bmi_calculate/core/responsive.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.r(10)),
      child: SizedBox(
        width: double.infinity,
        height: context.r(70),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          onPressed: onPressed,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: TextStyle(
                fontSize: context.r(28),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
