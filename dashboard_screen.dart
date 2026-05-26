import 'package:flutter/material.dart';

import '../models/mock_data.dart';
import '../models/nutrition_targets.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/macro_chip.dart';
import '../widgets/meal_art.dart';
import '../widgets/mh_logo.dart';
import 'meals_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const route = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomeDashboard(onEditMeals: () => setState(() => tab = 1)),
      const MealsScreen(showBottomNav: true),
      const _SubscriptionsScreen(),
      const _ProfileScreen(),
    ];

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.75, -0.85),
            radius: 1.15,
            colors: [
              AppTheme.turquoise.withOpacity(0.16),
              AppTheme.navy.withOpacity(0.18),
              AppTheme.background,
            ],
          ),
        ),
        child: IndexedStack(index: tab, children: pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        onTap: (value) => setState(() => tab = value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_rounded), label: 'Meals'),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium_rounded), label: 'Subscriptions'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard({required this.onEditMeals});

  final VoidCallback onEditMeals;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 420),
                tween: Tween(begin: 0, end: 1),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: _Header(),
              ),
              const SizedBox(height: 22),
              const _SubscriptionSummaryCard(),
              const SizedBox(height: 16),
              const _MacroProgressCard(),
              const SizedBox(height: 16),
              const _DeliveryStatusCard(),
              const SizedBox(height: 16),
              _TodaysMealsCard(onEditMeals: onEditMeals),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Home',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const Text('Your MacroHub day at a glance', style: TextStyle(color: AppTheme.textMuted)),
            ],
          ),
        ),
        const MhLogo(size: 54),
      ],
    );
  }
}

class _SubscriptionSummaryCard extends StatelessWidget {
  const _SubscriptionSummaryCard();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<NutritionTargets?>(
      valueListenable: nutritionTargets,
      builder: (context, targets, _) {
        return _DashboardCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.workspace_premium_rounded, color: AppTheme.turquoise),
                  SizedBox(width: 10),
                  Text('Client Subscription', style: TextStyle(color: AppTheme.textMuted)),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Chicken Plan', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text(
                targets == null
                    ? '150g protein - 2 meals daily - renews in 18 days'
                    : '${targets.goal} target - suggested ${targets.suggestedMealsPerDay} meals daily',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MacroProgressCard extends StatelessWidget {
  const _MacroProgressCard();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<NutritionTargets?>(
      valueListenable: nutritionTargets,
      builder: (context, targets, _) {
        final proteinTarget = targets?.protein ?? 150;
        final carbsTarget = targets?.carbs ?? 180;
        final fatTarget = targets?.fat ?? 55;

        return _DashboardCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Today Macros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              if (targets != null) ...[
                const SizedBox(height: 4),
                Text('${targets.calories} kcal estimated target', style: const TextStyle(color: AppTheme.textMuted)),
              ],
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: MacroChip(label: 'Protein', value: '119 / ${proteinTarget}g')),
                  const SizedBox(width: 8),
                  Expanded(child: MacroChip(label: 'Carbs', value: '136 / ${carbsTarget}g')),
                  const SizedBox(width: 8),
                  Expanded(child: MacroChip(label: 'Fat', value: '35 / ${fatTarget}g')),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: const LinearProgressIndicator(
                  value: 0.72,
                  minHeight: 10,
                  color: AppTheme.turquoise,
                  backgroundColor: AppTheme.surfaceLight,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DeliveryStatusCard extends StatelessWidget {
  const _DeliveryStatusCard();

  @override
  Widget build(BuildContext context) {
    return const _DashboardCard(
      child: Row(
        children: [
          Icon(Icons.local_shipping_rounded, color: AppTheme.turquoise),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Delivery Status', style: TextStyle(color: AppTheme.textMuted)),
                SizedBox(height: 4),
                Text('Preparing - arriving tomorrow 8:00 AM', style: TextStyle(fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TodaysMealsCard extends StatelessWidget {
  const _TodaysMealsCard({required this.onEditMeals});

  final VoidCallback onEditMeals;

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Today\'s Meals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 14),
          ...meals.take(3).map(
                (meal) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 76,
                        child: MealArt(
                          colors: meal.colors,
                          imageAsset: meal.imageAsset,
                          height: 56,
                          iconSize: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(meal.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                      ),
                      Text('${meal.calories} kcal', style: const TextStyle(color: AppTheme.textMuted)),
                    ],
                  ),
                ),
              ),
          OutlinedButton(
            onPressed: onEditMeals,
            child: const Text('Edit Meals'),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassCard(child: child);
  }
}

class _SubscriptionsScreen extends StatelessWidget {
  const _SubscriptionsScreen();

  @override
  Widget build(BuildContext context) {
    return const _SimpleTab(
      title: 'Subscriptions',
      icon: Icons.workspace_premium_rounded,
      body: 'Chicken Plan is active with 150g protein, 2 daily meals, and monthly renewal.',
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return const _SimpleTab(
      title: 'Profile',
      icon: Icons.person_rounded,
      body: 'Manage address, payment, preferences, and macro targets.',
    );
  }
}

class _SimpleTab extends StatelessWidget {
  const _SimpleTab({
    required this.title,
    required this.icon,
    required this.body,
  });

  final String title;
  final IconData icon;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppTheme.turquoise, size: 46),
              const SizedBox(height: 18),
              Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Text(body, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textMuted)),
            ],
          ),
        ),
      ),
    );
  }
}
