import 'package:flutter/material.dart';

import '../models/flow_args.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/section_title.dart';
import 'calorie_calculator_screen.dart';

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({super.key});

  static const route = '/goals';

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String selected = 'Maintain';

  final options = const [
    ('Lose Fat', Icons.local_fire_department_rounded),
    ('Maintain', Icons.balance_rounded),
    ('Build Muscle', Icons.fitness_center_rounded),
    ('Custom Macros', Icons.tune_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Choose Goal',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'What is your goal?',
              subtitle: 'MacroHub will tailor plans around the direction you choose.',
            ),
            const SizedBox(height: 22),
            Expanded(
              child: ListView.separated(
                itemCount: options.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isSelected = selected == option.$1;
                  return _SelectableCard(
                    title: option.$1,
                    icon: option.$2,
                    isSelected: isSelected,
                    onTap: () => setState(() => selected = option.$1),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                CalorieCalculatorScreen.route,
                arguments: GoalSelectionArgs(selected),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectableCard extends StatelessWidget {
  const _SelectableCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.turquoise.withOpacity(0.13) : AppTheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? AppTheme.turquoise : Colors.white.withOpacity(0.06),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? AppTheme.turquoise : AppTheme.surfaceLight,
              foregroundColor: isSelected ? const Color(0xFF04252B) : Colors.white,
              child: Icon(icon),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: isSelected ? AppTheme.turquoise : AppTheme.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
