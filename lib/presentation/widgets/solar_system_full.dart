import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tres_astronautas/data/models/planet.dart';

class SolarSystemFull extends StatefulWidget {
  const SolarSystemFull({super.key});

  @override
  State<SolarSystemFull> createState() => _SolarSystemFullState();
}

class _SolarSystemFullState extends State<SolarSystemFull>
    with TickerProviderStateMixin {
  late List<Planet> _planets;
  late List<AnimationController> _planetControllers;
  late AnimationController _sunAnimationController;

  @override
  void initState() {
    _sunAnimationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 10), upperBound: 2 * pi);

    // Planetas con tamaño igual, menos el sol ligeramente más grande
    _planets = [
      Planet(
          planetName: 'Mercury',
          radius: 2.0,
          orbitRadius: 6.0,
          color: Colors.white),
      Planet(
          planetName: 'Venus',
          radius: 2.0,
          orbitRadius: 11.0,
          color: Colors.white),
      Planet(
          planetName: 'Earth',
          radius: 2.0,
          orbitRadius: 16.0,
          color: Colors.white),
      Planet(
          planetName: 'Mars',
          radius: 2.0,
          orbitRadius: 21.0,
          color: Colors.white),
      Planet(
          planetName: 'Jupiter',
          radius: 2.0,
          orbitRadius: 26.0,
          color: Colors.white),
      Planet(
          planetName: 'Saturn',
          radius: 2.0,
          orbitRadius: 31.0,
          color: Colors.white),
      Planet(
          planetName: 'Uranus',
          radius: 2.0,
          orbitRadius: 36.0,
          color: Colors.white),
      Planet(
          planetName: 'Neptune',
          radius: 2.0,
          orbitRadius: 41.0,
          color: Colors.white),
    ];

    _planetControllers = [
      _createController(88),
      _createController(224.7),
      _createController(365),
      _createController(687),
      _createController(4333),
      _createController(10759),
      _createController(30685),
      _createController(60190),
    ];

    _sunAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _sunAnimationController.repeat();
      }
    });
    _sunAnimationController.forward();

    for (AnimationController controller in _planetControllers) {
      addRepeatListener(controller);
    }

    super.initState();
  }

  addRepeatListener(AnimationController controller) {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
    controller.forward();
  }

  AnimationController _createController(double durationInDays) {
    return AnimationController(
        vsync: this,
        duration:
            Duration(milliseconds: ((durationInDays / 365) * 1000).floor()),
        upperBound: 2 * pi)
      ..forward();
  }

  @override
  void dispose() {
    for (AnimationController c in _planetControllers) {
      c.dispose();
    }
    _sunAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 50, // Tamaño reducido
      height: 50, // Tamaño reducido
      child: AnimatedBuilder(
          animation: _sunAnimationController,
          builder: (context, child) {
            for (int i = 0; i < _planets.length; i++) {
              _planets[i].angle = _planetControllers[i].value;
            }
            return CustomPaint(
              painter: SolarSystemFullPainter(_planets),
              child: Container(),
            );
          }),
    );
  }
}

class SolarSystemFullPainter extends CustomPainter {
  late List<Planet> planets;

  SolarSystemFullPainter(this.planets);

  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint = Paint()..color = Colors.white; // Sol en blanco

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 3,
        sunPaint); // Sol ligeramente más grande

    for (int i = 0; i < planets.length; i++) {
      var planet = planets[i];
      final radius = planet.radius;
      final orbitRadius = planet.orbitRadius;
      var angle = planet.angle;

      final planetPaint = Paint()
        ..color = Colors.white // Planetas en blanco
        ..style = PaintingStyle.fill;

      final x = size.width / 2 + orbitRadius * cos(angle);
      final y = size.height / 2 + orbitRadius * sin(angle);

      final orbitPaint = Paint()
        ..color =
            Colors.white.withOpacity(0.3) // Órbitas semi-translúcidas en blanco
        ..style = PaintingStyle.stroke;

      // Dibuja la órbita
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), orbitRadius, orbitPaint);

      // Dibuja el planeta
      canvas.drawCircle(Offset(x, y), radius, planetPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
