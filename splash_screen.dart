import 'package:flutter/material.dart';

import '../widgets/mh_logo.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              const MhLogo(size: 118),
              const SizedBox(height: 24),
              Text(
                'MacroHub',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Premium healthy meals built around your macros.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF9BB0B5), fontSize: 16),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, OnboardingScreen.route),
                child: const Text('Start Your Plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
