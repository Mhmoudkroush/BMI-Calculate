import 'package:bmi_calculate/core/color_manager.dart';
import 'package:bmi_calculate/core/responsive.dart';
import 'package:bmi_calculate/core/widgets/app_card.dart';
import 'package:flutter/material.dart';

class AgeAndWeightCard extends StatelessWidget {
  const AgeAndWeightCard({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: ColorManager.addAndRemove,
      shape: const CircleBorder(),
      padding: EdgeInsets.zero,
      minimumSize: Size.square(context.r(46)),
    );

    return AppCard(
      padding: EdgeInsets.all(context.r(10)),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: ColorManager.text, fontSize: context.r(20)),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: context.r(40),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: buttonStyle,
                onPressed: onIncrement,
                child: const Icon(Icons.add, color: Colors.white),
              ),
              ElevatedButton(
                style: buttonStyle,
                onPressed: onDecrement,
                child: const Icon(Icons.remove, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
