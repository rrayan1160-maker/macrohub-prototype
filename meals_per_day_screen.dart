import 'package:flutter/material.dart';

import '../models/flow_args.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/section_title.dart';
import 'plans_screen.dart';

class MealsPerDayScreen extends StatefulWidget {
  const MealsPerDayScreen({
    super.key,
    required this.goal,
    this.initialMealsPerDay = 3,
  });

  static const route = '/meals-per-day';

  final String goal;
  final int initialMealsPerDay;

  @override
  State<MealsPerDayScreen> createState() => _MealsPerDayScreenState();
}

class _MealsPerDayScreenState extends State<MealsPerDayScreen> {
  int selected = 3;

  @override
  void initState() {
    super.initState();
    selected = widget.initialMealsPerDay.clamp(1, 3).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Meals',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: 'How many meals per day?',
              subtitle: '${widget.goal} works best when your routine is easy to repeat.',
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: MediaQuery.sizeOf(context).width > 620 ? 3 : 1,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: MediaQuery.sizeOf(context).width > 620 ? 1.25 : 2.4,
                children: [1, 2, 3].map((count) {
                  final isSelected = selected == count;
                  return InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => setState(() => selected = count),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.turquoise : AppTheme.surface,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isSelected ? AppTheme.turquoise : Colors.white.withOpacity(0.06),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.restaurant_menu_rounded,
                            color: isSelected ? const Color(0xFF04252B) : AppTheme.turquoise,
                          ),
                          Text(
                            '$count meal${count == 1 ? '' : 's'} per day',
                            style: TextStyle(
                              color: isSelected ? const Color(0xFF04252B) : Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                PlansScreen.route,
                arguments: MealsPerDayArgs(goal: widget.goal, mealsPerDay: selected),
              ),
              child: const Text('View Plans'),
            ),
          ],
        ),
      ),
    );
  }
}
