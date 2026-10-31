import 'package:bmi_calculate/core/color_manager.dart';
import 'package:bmi_calculate/core/responsive.dart';
import 'package:bmi_calculate/core/widgets/app_card.dart';
import 'package:bmi_calculate/core/widgets/bmi_app_bar.dart';
import 'package:bmi_calculate/core/widgets/button.dart';
import 'package:bmi_calculate/features/home/cubit/home_cubit.dart';
import 'package:bmi_calculate/features/home/cubit/home_state.dart';
import 'package:bmi_calculate/features/home/widgets/age_and_weight.dart';
import 'package:bmi_calculate/features/home/widgets/gender_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final input = context.watch<HomeCubit>().state;
    final cubit = context.read<HomeCubit>();

    final genderRow = Row(
      children: [
        Expanded(
          child: GenderCard(
            label: 'Male',
            icon: Icons.male,
            isSelected: input.gender == Gender.male,
            onTap: () => cubit.selectGender(Gender.male),
          ),
        ),
        Expanded(
          child: GenderCard(
            label: 'Female',
            icon: Icons.female,
            isSelected: input.gender == Gender.female,
            onTap: () => cubit.selectGender(Gender.female),
          ),
        ),
      ],
    );

    final heightCard = AppCard(
      padding: EdgeInsets.symmetric(
        vertical: context.r(24),
        horizontal: context.r(20),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'Height',
              style: TextStyle(
                color: ColorManager.text,
                fontSize: context.r(20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${input.height.toInt()}',
                  style: TextStyle(
                    fontSize: context.r(40),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' cm',
                  style: TextStyle(
                    fontSize: context.r(20),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Slider(
              activeColor: ColorManager.button,
              min: HomeCubit.minHeight,
              max: HomeCubit.maxHeight,
              value: input.height,
              onChanged: cubit.setHeight,
            ),
          ],
        ),
      ),
    );

    final weightCard = AgeAndWeightCard(
      label: 'Weight',
      value: input.weight,
      onIncrement: cubit.incrementWeight,
      onDecrement: cubit.decrementWeight,
    );

    final ageCard = AgeAndWeightCard(
      label: 'Age',
      value: input.age,
      onIncrement: cubit.incrementAge,
      onDecrement: cubit.decrementAge,
    );

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: const BmiAppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(context.r(8)),
                    child: context.isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [genderRow, heightCard],
                                ),
                              ),
                              Expanded(
                                child: Column(children: [weightCard, ageCard]),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              genderRow,
                              heightCard,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: weightCard),
                                  Expanded(child: ageCard),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
                Button(
                  text: 'Calculate',
                  onPressed: () {
                    final current = cubit.state;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => ResultCubit()
                            ..calculate(
                              height: current.height,
                              weight: current.weight.toDouble(),
                            ),
                          child: const ResultScreen(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
