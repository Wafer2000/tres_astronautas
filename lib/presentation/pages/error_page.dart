import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181743),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double widthFactor;
          double heightFactor;

          // Aplicamos ajustes según el ancho de la pantalla
          if (constraints.maxWidth <= 430) {
            // Móvil medio
            widthFactor = 0.68;
            heightFactor = 0.3;
          } else if (constraints.maxWidth <= 720) {
            // Smartphone grande
            widthFactor = 0.72;
            heightFactor = 0.45;
          } else if (constraints.maxWidth <= 1366) {
            // Ordenador portátil medio
            widthFactor = 0.58;
            heightFactor = 0.37;
          } else if (constraints.maxWidth <= 1440) {
            // Ordenador de escritorio medio
            widthFactor = 0.7;
            heightFactor = 0.5;
          } else {
            // PC de escritorio grande
            widthFactor = 0.3;
            heightFactor = 0.5;
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: constraints.maxWidth * widthFactor,
                  height: constraints.maxHeight.isFinite
                      ? constraints.maxHeight * heightFactor
                      : 300,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://cdn.dribbble.com/users/1600801/screenshots/3305058/media/ff1e7d87851f5ce92a5997da93d9da34.gif',
                    placeholder: (context, url) => const SizedBox(
                      width: 30,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: const Color(0xFF181743),
                      child: const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Planet Not Found',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
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
          );
        },
      ),
    );
  }
}
