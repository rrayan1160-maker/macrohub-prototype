import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/glass_card.dart';
import '../widgets/macro_chip.dart';
import '../widgets/meal_art.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({super.key, required this.meal});

  static const route = '/meal-details';

  final Meal meal;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  int selectedProteinSize = 150;

  MacroSet get macros => widget.meal.macrosForProteinSize(selectedProteinSize);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Meal Details',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Hero(
                    tag: 'meal-${widget.meal.name}',
                    child: MealArt(
                      colors: widget.meal.colors,
                      imageAsset: widget.meal.imageAsset,
                      height: 230,
                      iconSize: 70,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.meal.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                      _CategoryPill(label: widget.meal.category.label),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 240),
                    child: Text(
                      '${macros.calories} calories',
                      key: ValueKey(macros.calories),
                      style: const TextStyle(
                        color: AppTheme.turquoise,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 240),
                    child: Row(
                      key: ValueKey('${macros.protein}-${macros.carbs}-${macros.fat}'),
                      children: [
                        Expanded(child: MacroChip(label: 'Protein', value: '${macros.protein}g')),
                        const SizedBox(width: 10),
                        Expanded(child: MacroChip(label: 'Carbs', value: '${macros.carbs}g')),
                        const SizedBox(width: 10),
                        Expanded(child: MacroChip(label: 'Fat', value: '${macros.fat}g')),
                      ],
                    ),
                  ),
                  if (widget.meal.supportsProteinSizing) ...[
                    const SizedBox(height: 22),
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Protein Size',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Available for this ready meal only. Sides and sauces are not customizable here.',
                            style: TextStyle(color: AppTheme.textMuted, height: 1.4),
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [100, 150, 200].map((size) {
                              final selected = selectedProteinSize == size;
                              return ChoiceChip(
                                label: Text('${size}g'),
                                selected: selected,
                                onSelected: (_) => setState(() => selectedProteinSize = size),
                                selectedColor: AppTheme.turquoise,
                                backgroundColor: AppTheme.surfaceLight,
                                labelStyle: TextStyle(
                                  color: selected ? const Color(0xFF04252B) : Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                                side: BorderSide(
                                  color: selected ? AppTheme.turquoise : Colors.white.withOpacity(0.06),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 22),
                  const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.meal.ingredients
                        .map(
                          (item) => Chip(
                            label: Text(item),
                            backgroundColor: AppTheme.surfaceLight,
                            side: BorderSide(color: Colors.white.withOpacity(0.06)),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 22),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.meal.name} added to your plan')),
              ),
              child: const Text('Add to Plan'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.turquoise.withOpacity(0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(color: AppTheme.turquoise, fontWeight: FontWeight.w900),
      ),
    );
  }
}
