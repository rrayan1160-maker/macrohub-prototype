import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    this.title,
    this.actions,
  });

  final Widget child;
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title!, style: const TextStyle(fontWeight: FontWeight.w800)),
              actions: actions,
            ),
      body: Stack(
        children: [
          const _PremiumBackground(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width > 760 ? 720 : width),
                    child: child,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumBackground extends StatelessWidget {
  const _PremiumBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.8, -0.9),
          radius: 1.1,
          colors: [
            AppTheme.turquoise.withOpacity(0.18),
            AppTheme.navy.withOpacity(0.2),
            AppTheme.background,
          ],
        ),
      ),
      child: const SizedBox.expand(),
    );
  }
}
