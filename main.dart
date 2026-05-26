import 'package:flutter/material.dart';

import 'models/flow_args.dart';
import 'models/meal.dart';
import 'models/plan.dart';
import 'screens/checkout_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/goal_selection_screen.dart';
import 'screens/meal_details_screen.dart';
import 'screens/meals_per_day_screen.dart';
import 'screens/meals_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/plans_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MacroHubApp());
}

class MacroHubApp extends StatelessWidget {
  const MacroHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MacroHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      onGenerateRoute: (settings) {
        late final Widget page;

        switch (settings.name) {
          case SplashScreen.route:
            page = const SplashScreen();
          case OnboardingScreen.route:
            page = const OnboardingScreen();
          case GoalSelectionScreen.route:
            page = const GoalSelectionScreen();
          case MealsPerDayScreen.route:
            page = GoalSelectionArgs.scope(settings.arguments).buildMealsPerDay();
          case PlansScreen.route:
            page = MealsPerDayArgs.scope(settings.arguments).buildPlans();
          case MealsScreen.route:
            page = MealsScreen(showBottomNav: settings.arguments == true);
          case MealDetailsScreen.route:
            page = MealDetailsScreen(meal: settings.arguments as Meal);
          case CheckoutScreen.route:
            page = CheckoutScreen(plan: settings.arguments as MealPlan);
          case DashboardScreen.route:
            page = const DashboardScreen();
          default:
            page = const SplashScreen();
        }

        return PageRouteBuilder<void>(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 360),
          reverseTransitionDuration: const Duration(milliseconds: 260),
          pageBuilder: (_, animation, __) => page,
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.04, 0.02),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        );
      },
      initialRoute: SplashScreen.route,
    );
  }
}
