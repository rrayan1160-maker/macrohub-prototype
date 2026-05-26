import 'package:flutter/material.dart';

import '../models/nutrition_targets.dart';
import '../models/plan.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';
import 'checkout_screen.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({
    super.key,
    required this.goal,
    required this.mealsPerDay,
  });

  static const route = '/plans';

  final String goal;
  final int mealsPerDay;

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  SubscriptionType type = SubscriptionType.chicken;
  int proteinSize = 150;
  int mealsPerDay = 2;
  bool addExtraCarbs = false;
  bool swapToSeafood = false;

  SubscriptionSelection get selection => SubscriptionSelection(
        type: type,
        proteinSize: proteinSize,
        mealsPerDay: mealsPerDay,
        addExtraCarbs: addExtraCarbs,
        swapToSeafood: swapToSeafood,
      );

  @override
  void initState() {
    super.initState();
    mealsPerDay = widget.mealsPerDay.clamp(1, 3).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Subscriptions',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Subscriptions / الاشتراكات',
              subtitle: 'Choose your MacroHub subscription. All subscriptions include 100-200g carbs.',
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  ValueListenableBuilder<NutritionTargets?>(
                    valueListenable: nutritionTargets,
                    builder: (context, targets, _) {
                      if (targets == null) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Calculator Targets / نتائج الحاسبة',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                              const SizedBox(height: 8),
                              Text(
                                '${targets.calories} kcal - Protein ${targets.protein}g - Carbs ${targets.carbs}g - Fat ${targets.fat}g',
                                style: const TextStyle(color: AppTheme.textMuted),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                targets.calories < 1800
                                    ? 'Suggested: 1 or 2 meals per day'
                                    : 'Suggested: ${targets.suggestedMealsPerDay} meals per day',
                                style: const TextStyle(color: AppTheme.turquoise, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  _TypeSelector(
                    selected: type,
                    onChanged: (value) => setState(() => type = value),
                  ),
                  const SizedBox(height: 16),
                  _Segment<int>(
                    title: 'Protein size / حجم البروتين',
                    values: const [100, 150, 200],
                    selected: proteinSize,
                    label: (value) => '${value}g',
                    onChanged: (value) => setState(() => proteinSize = value),
                  ),
                  const SizedBox(height: 16),
                  _Segment<int>(
                    title: 'Meals per day / عدد الوجبات يوميًا',
                    values: const [1, 2, 3],
                    selected: mealsPerDay,
                    label: (value) => '$value',
                    onChanged: (value) => setState(() => mealsPerDay = value),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add-ons / الإضافات',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 12),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: addExtraCarbs,
                          activeColor: AppTheme.turquoise,
                          title: const Text('Add extra carbs / إضافة كارب'),
                          subtitle: Text('+${extraCarbPrices[mealsPerDay]} SAR'),
                          onChanged: (value) => setState(() => addExtraCarbs = value),
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          value: swapToSeafood,
                          activeColor: AppTheme.turquoise,
                          title: const Text('Swap to seafood meal / تبديل إلى وجبة بحرية'),
                          subtitle: Text('+${seafoodSwapFees[type]![proteinSize]} SAR'),
                          onChanged: (value) => setState(() => swapToSeafood = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'جميع الاشتراكات تشمل 100-200 جرام كارب.',
                          style: TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 16),
                        _PriceLine(label: 'Base subscription', value: selection.basePrice),
                        if (selection.addExtraCarbs) _PriceLine(label: 'Extra carbs', value: selection.extraCarbsPrice),
                        if (selection.swapToSeafood) _PriceLine(label: 'Seafood swap', value: selection.seafoodSwapFee),
                        const Divider(height: 28),
                        Row(
                          children: [
                            const Text('Final price', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                            const Spacer(),
                            Text(
                              '${selection.totalPrice} SAR',
                              style: const TextStyle(
                                color: AppTheme.turquoise,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                CheckoutScreen.route,
                arguments: selection,
              ),
              child: const Text('Continue to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeSelector extends StatelessWidget {
  const _TypeSelector({
    required this.selected,
    required this.onChanged,
  });

  final SubscriptionType selected;
  final ValueChanged<SubscriptionType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: SubscriptionType.values.map((type) {
        final isSelected = selected == type;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            opacity: isSelected ? 0.78 : 0.5,
            onTap: () => onChanged(type),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                  color: isSelected ? AppTheme.turquoise : AppTheme.textMuted,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(type.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 4),
                      Text(type.arabicTitle, style: const TextStyle(color: AppTheme.textMuted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
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
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Row(
            children: values.map((value) {
              final isSelected = selected == value;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: ChoiceChip(
                    label: Center(child: Text(label(value))),
                    selected: isSelected,
                    onSelected: (_) => onChanged(value),
                    selectedColor: AppTheme.turquoise,
                    backgroundColor: AppTheme.surfaceLight,
                    labelStyle: TextStyle(
                      color: isSelected ? const Color(0xFF04252B) : Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                    side: BorderSide(
                      color: isSelected ? AppTheme.turquoise : Colors.white.withOpacity(0.06),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PriceLine extends StatelessWidget {
  const _PriceLine({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textMuted)),
          const Spacer(),
          Text('$value SAR', style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
