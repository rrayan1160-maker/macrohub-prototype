import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../models/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/glass_card.dart';
import '../widgets/macro_chip.dart';
import '../widgets/meal_art.dart';
import '../widgets/section_title.dart';
import 'meal_details_screen.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.showBottomNav = false});

  static const route = '/meals';

  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    final content = AppShell(
      title: 'Meals',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'MacroHub Menu',
              subtitle: 'Ready meals from the real MacroHub menu. Sauces and sides are not listed as meals.',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: meals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 260 + (index * 45)),
                    tween: Tween(begin: 0, end: 1),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 18 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: MealCard(meal: meals[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    if (!showBottomNav) return content;
    return content;
  }
}

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => Navigator.pushNamed(
        context,
        MealDetailsScreen.route,
        arguments: meal,
      ),
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'meal-${meal.name}',
              child: MealArt(colors: meal.colors, imageAsset: meal.imageAsset),
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    meal.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.turquoise.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${meal.calories} kcal',
                    style: const TextStyle(color: AppTheme.turquoise, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withOpacity(0.06)),
                ),
                child: Text(
                  meal.category.label,
                  style: const TextStyle(color: AppTheme.turquoise, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: MacroChip(label: 'Protein', value: '${meal.protein}g')),
                const SizedBox(width: 8),
                Expanded(child: MacroChip(label: 'Carbs', value: '${meal.carbs}g')),
                const SizedBox(width: 8),
                Expanded(child: MacroChip(label: 'Fat', value: '${meal.fat}g')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
