import 'dart:math';

import 'package:flutter/material.dart';

import '../models/flow_args.dart';
import '../models/nutrition_targets.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';
import 'meals_per_day_screen.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({super.key, required this.goal});

  static const route = '/calorie-calculator';

  final String goal;

  @override
  State<CalorieCalculatorScreen> createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  String gender = 'Male';
  String activity = 'Moderate';
  String goal = 'Maintain';
  NutritionTargets? result;

  final activityMultipliers = const {
    'Sedentary': 1.2,
    'Light': 1.375,
    'Moderate': 1.55,
    'Active': 1.725,
    'Very Active': 1.9,
  };

  @override
  void initState() {
    super.initState();
    goal = widget.goal == 'Custom Macros' ? 'Maintain' : widget.goal;
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void calculate() {
    final age = int.tryParse(ageController.text);
    final height = double.tryParse(heightController.text);
    final weight = double.tryParse(weightController.text);
    if (age == null || height == null || weight == null || age <= 0 || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid age, height, and weight.')),
      );
      return;
    }

    final bmr = gender == 'Male'
        ? (10 * weight) + (6.25 * height) - (5 * age) + 5
        : (10 * weight) + (6.25 * height) - (5 * age) - 161;
    final tdee = bmr * activityMultipliers[activity]!;
    final calories = switch (goal) {
      'Lose Fat' => tdee - 400,
      'Build Muscle' => tdee + 300,
      _ => tdee,
    };
    final proteinPerKg = goal == 'Maintain' ? 1.8 : 2.0;
    final protein = weight * proteinPerKg;
    final proteinCalories = protein * 4;
    final fatCalories = calories * 0.25;
    final fat = fatCalories / 9;
    final carbs = max(0, (calories - proteinCalories - fatCalories) / 4);
    final roundedCalories = calories.round();
    final suggestedMeals = roundedCalories < 1800 ? 2 : (roundedCalories <= 2400 ? 2 : 3);

    setState(() {
      result = NutritionTargets(
        calories: roundedCalories,
        protein: protein.round(),
        carbs: carbs.round(),
        fat: fat.round(),
        suggestedMealsPerDay: suggestedMeals,
        goal: goal,
      );
    });
  }

  void useTargets() {
    final targets = result;
    if (targets == null) return;
    nutritionTargets.value = targets;
    Navigator.pushNamed(
      context,
      MealsPerDayScreen.route,
      arguments: CalculatorResultArgs(
        goal: widget.goal,
        suggestedMealsPerDay: targets.suggestedMealsPerDay,
      ),
    );
  }

  void skip() {
    Navigator.pushNamed(
      context,
      MealsPerDayScreen.route,
      arguments: CalculatorResultArgs(goal: widget.goal, suggestedMealsPerDay: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Calculator',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Calorie Calculator / حاسبة الاحتياج التقريبي',
              subtitle: 'Optional step to estimate calories and macro targets before choosing a subscription.',
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Segment<String>(
                          title: 'Gender / الجنس',
                          values: const ['Male', 'Female'],
                          selected: gender,
                          label: (value) => value == 'Male' ? 'Male / ذكر' : 'Female / أنثى',
                          onChanged: (value) => setState(() => gender = value),
                        ),
                        const SizedBox(height: 14),
                        _NumberField(label: 'Age / العمر', controller: ageController),
                        const SizedBox(height: 12),
                        _NumberField(label: 'Height / الطول cm', controller: heightController),
                        const SizedBox(height: 12),
                        _NumberField(label: 'Weight / الوزن kg', controller: weightController),
                        const SizedBox(height: 14),
                        _Segment<String>(
                          title: 'Activity Level / مستوى النشاط',
                          values: const ['Sedentary', 'Light', 'Moderate', 'Active', 'Very Active'],
                          selected: activity,
                          label: (value) => value,
                          onChanged: (value) => setState(() => activity = value),
                        ),
                        const SizedBox(height: 14),
                        _Segment<String>(
                          title: 'Goal / الهدف',
                          values: const ['Lose Fat', 'Maintain', 'Build Muscle'],
                          selected: goal,
                          label: (value) => value,
                          onChanged: (value) => setState(() => goal = value),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(onPressed: calculate, child: const Text('Calculate / احسب')),
                      ],
                    ),
                  ),
                  if (result != null) ...[
                    const SizedBox(height: 16),
                    _ResultCard(targets: result!, onUse: useTargets),
                  ],
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: skip, child: const Text('Skip / تخطي')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.targets, required this.onUse});

  final NutritionTargets targets;
  final VoidCallback onUse;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Estimated Targets / الأرقام التقريبية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 14),
          _Metric(label: 'Estimated Calories', value: '${targets.calories} kcal'),
          _Metric(label: 'Protein target', value: '${targets.protein}g'),
          _Metric(label: 'Carbs target', value: '${targets.carbs}g'),
          _Metric(label: 'Fat target', value: '${targets.fat}g'),
          const SizedBox(height: 12),
          Text(
            targets.calories < 1800
                ? 'Suggested plan: 1 or 2 meals per day'
                : 'Suggested plan: ${targets.suggestedMealsPerDay} meals per day',
            style: const TextStyle(color: AppTheme.turquoise, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          const Text(
            'This is an estimated calculation and may vary based on individual needs.\n'
            'هذا حساب تقريبي وقد يختلف حسب احتياج كل شخص.',
            style: TextStyle(color: AppTheme.textMuted),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onUse, child: const Text('Use These Targets / استخدم هذه الأرقام')),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: AppTheme.textMuted))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppTheme.surfaceLight,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({
    required this.title,
    required this.values,
    required this.selected,
    required this.label,
    required this.onChanged,
  });

  final String title;
  final List<T> values;
  final T selected;
  final String Function(T value) label;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: values.map((value) {
            final isSelected = selected == value;
            return ChoiceChip(
              label: Text(label(value)),
              selected: isSelected,
              selectedColor: AppTheme.turquoise,
              backgroundColor: AppTheme.surfaceLight,
              labelStyle: TextStyle(
                color: isSelected ? const Color(0xFF04252B) : Colors.white,
                fontWeight: FontWeight.w900,
              ),
              side: BorderSide(
                color: isSelected ? AppTheme.turquoise : Colors.white.withOpacity(0.06),
              ),
              onSelected: (_) => onChanged(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
