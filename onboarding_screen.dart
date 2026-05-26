import 'package:flutter/material.dart';

import '../widgets/app_shell.dart';
import '../widgets/mh_logo.dart';
import '../widgets/section_title.dart';
import 'goal_selection_screen.dart';
import 'meals_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const route = '/onboarding';

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            const MhLogo(size: 92),
            const SizedBox(height: 34),
            const SectionTitle(
              title: 'Your macros. Your meals. Made simple.',
              subtitle:
                  'Choose your goal, set your meals per day, and get chef-built healthy meals calculated around your lifestyle.',
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF0E2025),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.06)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome_rounded, color: Color(0xFF02C3A6)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Fresh meals, clear macros, no guesswork.',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, GoalSelectionScreen.route),
              child: const Text('Start Your Plan'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, MealsScreen.route),
              child: const Text('View Meals'),
            ),
          ],
        ),
      ),
    );
  }
}
