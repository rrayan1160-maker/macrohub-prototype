import 'package:flutter/material.dart';

class MealArt extends StatelessWidget {
  const MealArt({
    super.key,
    required this.colors,
    this.imageAsset,
    this.height = 120,
    this.iconSize = 42,
  });

  final List<Color> colors;
  final String? imageAsset;
  final double height;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.last.withOpacity(0.24),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageAsset != null)
            Image.asset(
              imageAsset!,
              fit: BoxFit.cover,
            ),
          if (imageAsset != null)
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.06),
                    Colors.black.withOpacity(0.52),
                  ],
                ),
              ),
            ),
          if (imageAsset == null)
            Positioned(
              right: -26,
              top: -30,
              child: Container(
                width: height,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.16),
                ),
              ),
            ),
          if (imageAsset == null)
            Center(
              child: Icon(
                Icons.restaurant_rounded,
                size: iconSize,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
        ],
      ),
      ),
    );
  }
}
