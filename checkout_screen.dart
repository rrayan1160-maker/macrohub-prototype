import 'package:flutter/material.dart';

import '../models/plan.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_title.dart';
import 'dashboard_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.selection});

  static const route = '/checkout';

  final SubscriptionSelection selection;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Checkout',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Confirm subscription',
              subtitle: 'Review your MacroHub subscription before confirming.',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _SummaryTile(title: 'Subscription type', value: selection.planTitle, icon: Icons.inventory_2_rounded),
                  _SummaryTile(title: 'Protein size', value: '${selection.proteinSize}g', icon: Icons.fitness_center_rounded),
                  _SummaryTile(title: 'Meals per day', value: '${selection.mealsPerDay}', icon: Icons.restaurant_rounded),
                  _SummaryTile(
                    title: 'Add-ons',
                    value: selection.addOns.join('\n'),
                    icon: Icons.add_circle_rounded,
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Column(
                      children: [
                        _PriceRow(label: 'Base subscription', value: '${selection.basePrice} SAR'),
                        if (selection.addExtraCarbs) ...[
                          const SizedBox(height: 10),
                          _PriceRow(label: 'Extra carbs', value: '${selection.extraCarbsPrice} SAR'),
                        ],
                        if (selection.swapToSeafood) ...[
                          const SizedBox(height: 10),
                          _PriceRow(label: 'Seafood swap', value: '${selection.seafoodSwapFee} SAR'),
                        ],
                        const Divider(height: 28),
                        _PriceRow(
                          label: 'Final price',
                          value: '${selection.totalPrice} SAR',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                DashboardScreen.route,
                (route) => false,
              ),
              child: const Text('Pay / Confirm Subscription'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        radius: 20,
        child: Row(
          children: [
            Icon(icon, color: AppTheme.turquoise),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
                  const SizedBox(height: 3),
                  Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? Colors.white : AppTheme.textMuted,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? AppTheme.turquoise : Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: isTotal ? 20 : 15,
          ),
        ),
      ],
    );
  }
}
