import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import '../../../../core/constants/strings.dart';
import 'package:bloc_architecture_app/core/themes/app_theme.dart';

class CustomAnimatedBackground extends StatelessWidget {
  final TickerProvider tickerProvider;

  CustomAnimatedBackground({
    Key? key,
    required this.tickerProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int particleCount = 5;
    double particleSize = 150;
    double particleSpeed = 60;

    return AnimatedBackground(
      behaviour: RandomParticleBehaviour(
        options: ParticleOptions(
          baseColor: Theme.of(context).particlesColor,
          particleCount: particleCount,
          spawnMinRadius: particleSize,
          spawnMaxRadius: particleSize,
          spawnMinSpeed: particleSpeed,
          spawnMaxSpeed: particleSpeed,
        ),
      ),
      vsync: tickerProvider,
      child: SizedBox(),
    );
  }
}
