import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tres_astronautas/data/models/planet.dart';

class SolarSystemMini extends StatefulWidget {
  final List<String> planetsToShow; // Nombres de los planetas a mostrar

  const SolarSystemMini({
    super.key,
    required this.planetsToShow,
  });

  @override
  State<SolarSystemMini> createState() => _SolarSystemMiniState();
}

class _SolarSystemMiniState extends State<SolarSystemMini>
    with TickerProviderStateMixin {
  late List<Planet> _planets;
  late List<AnimationController> _planetControllers;
  late AnimationController _sunAnimationController;

  @override
  void initState() {
    super.initState();

    // Todos los planetas
    final allPlanets = [
      Planet(
        planetName: 'Mercury',
        radius: 2.0,
        orbitRadius: 6.0,
        color: Colors.white,
      ),
      Planet(
        planetName: 'Venus',
        radius: 2.0,
        orbitRadius: 11.0,
        color: Colors.white,
      ),
      Planet(
        planetName: 'Earth',
        radius: 2.0,
        orbitRadius: 16.0,
        color: Colors.white,
      ),
      Planet(
        planetName: 'Mars',
        radius: 2.0,
        orbitRadius: 21.0,
        color: Colors.white,
      ),
      Planet(
        planetName: 'Jupiter',
        radius: 2.0,
        orbitRadius: 26.0,
        color: Colors.white,
      ),
      Planet(
        planetName: 'Saturn',
        radius: 2.0,
        orbitRadius: 31.0,
        color: Colors.white,
      ),
      Planet(
        planetName: 'Uranus',
        radius: 2.0,
        orbitRadius: 36.0,
        color: Colors.white,
      ),
      Planet(
        planetName: 'Neptune',
        radius: 2.0,
        orbitRadius: 41.0,
        color: Colors.white,
      ),
    ];

    // Filtra los planetas con base en la lista proporcionada
    _planets = allPlanets;

    _sunAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
      upperBound: 2 * pi,
    );

    _planetControllers = _planets
        .map(
            (planet) => _createController(_getOrbitDuration(planet.planetName)))
        .toList();

    _sunAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _sunAnimationController.repeat();
      }
    });
    _sunAnimationController.forward();

    for (AnimationController controller in _planetControllers) {
      addRepeatListener(controller);
    }
  }

  double _getOrbitDuration(String planetName) {
    switch (planetName) {
      case 'Mercury':
        return 88;
      case 'Venus':
        return 224.7;
      case 'Earth':
        return 365;
      case 'Mars':
        return 687;
      case 'Jupiter':
        return 4333;
      case 'Saturn':
        return 10759;
      case 'Uranus':
        return 30685;
      case 'Neptune':
        return 60190;
      default:
        return 365;
    }
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
      duration: Duration(milliseconds: ((durationInDays / 365) * 1000).floor()),
      upperBound: 2 * pi,
    )..forward();
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
            painter: SolarSystemMiniPainter(_planets, widget.planetsToShow),
            child: Container(),
          );
        },
      ),
    );
  }
}

class SolarSystemMiniPainter extends CustomPainter {
  final List<Planet> planets;
  final List<String> planetsToShow; // Planetas visibles

  SolarSystemMiniPainter(this.planets, this.planetsToShow);

  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint = Paint()..color = Colors.white; // Sol en blanco

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 3,
        sunPaint); // Sol ligeramente más grande

    for (var planet in planets) {
      final radius = planet.radius;
      final orbitRadius = planet.orbitRadius;
      final angle = planet.angle;

      final orbitPaint = Paint()
        ..color =
            Colors.white.withOpacity(0.3) // Órbitas semi-translúcidas en blanco
        ..style = PaintingStyle.stroke;

      // Dibuja la órbita
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), orbitRadius, orbitPaint);

      // Solo dibuja el planeta si está incluido en planetsToShow
      if (planetsToShow.contains(planet.planetName)) {
        final planetPaint = Paint()
          ..color = Colors.white // Planetas en blanco
          ..style = PaintingStyle.fill;

        final x = size.width / 2 + orbitRadius * cos(angle);
        final y = size.height / 2 + orbitRadius * sin(angle);

        // Dibuja el planeta
        canvas.drawCircle(Offset(x, y), radius, planetPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
