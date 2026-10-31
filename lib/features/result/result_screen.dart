import 'package:bmi_calculate/core/color_manager.dart';
import 'package:bmi_calculate/core/responsive.dart';
import 'package:bmi_calculate/core/widgets/app_card.dart';
import 'package:bmi_calculate/core/widgets/bmi_app_bar.dart';
import 'package:bmi_calculate/core/widgets/button.dart';
import 'package:bmi_calculate/features/result/cubit/result_cubit.dart';
import 'package:bmi_calculate/features/result/cubit/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = context.watch<ResultCubit>().state;

    final categoryColor = switch (result) {
      ResultSuccess(:final category) => switch (category) {
          BmiCategory.underweight => const Color(0xFFF5A623),
          BmiCategory.normal => const Color(0xFF24D876),
          BmiCategory.overweight || BmiCategory.obese => const Color(0xFFE83D67),
        },
      _ => Colors.white,
    };

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: const BmiAppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: ResponsiveContext.contentNarrow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(context.r(16)),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Result',
                      style: TextStyle(
                        fontSize: context.r(40),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AppCard(
                    child: switch (result) {
                      ResultInitial() => const SizedBox.shrink(),
                      ResultSuccess(:final bmi, :final category) => Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  category.label,
                                  style: TextStyle(
                                    color: categoryColor,
                                    fontSize: context.r(22),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: context.r(24)),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    bmi.toStringAsFixed(1),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: context.r(80),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: context.r(24)),
                                Text(
                                  category.description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF8D8E98),
                                    fontSize: context.r(18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ResultFailure(:final message) => Center(
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: context.r(18),
                            ),
                          ),
                        ),
                    },
                  ),
                ),
                Button(
                  text: 'Re - Calculate',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}