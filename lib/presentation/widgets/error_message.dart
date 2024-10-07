import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Error al cargar los planetas. Por favor, intenta de nuevo más tarde.',
      ),
    );
  }
}
