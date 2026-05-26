import 'package:flutter/material.dart';

class MhLogo extends StatelessWidget {
  const MhLogo({super.key, this.size = 104});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        'assets/images/macrohub_logo_transparent.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
