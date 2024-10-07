import 'package:flutter/material.dart';

class Planet {
  final String planetName;
  final double radius;
  final double orbitRadius;
  final Color color;
  double angle = 0; // Inicializa el ángulo
  bool isVisible; // Nuevo campo para controlar la visibilidad

  Planet({
    required this.planetName,
    required this.radius,
    required this.orbitRadius,
    required this.color,
    this.isVisible = true, // Valor predeterminado
  });
}
