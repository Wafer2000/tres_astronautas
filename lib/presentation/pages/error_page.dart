import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.6, // 60% del ancho de la pantalla
              height: MediaQuery.of(context).size.height *
                  0.3, // 30% del alto de la pantalla
              child: Lottie.asset('animations/default_animation.json'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/planets');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Fondo blanco
                foregroundColor: Colors.black, // Texto negro
              ),
              child: const Text('Volver al listado de planetas'),
            ),
          ],
        ),
      ),
    );
  }
}
