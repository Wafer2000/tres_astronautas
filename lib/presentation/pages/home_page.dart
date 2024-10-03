import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tres_astronautas/presentation/widgets/solar_system_full.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Verifica el tamaño de la pantalla
    bool isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            left: -100,
            top: -30,
            bottom: 0,
            right: -90,
            child: Container(
              transformAlignment: Alignment.center,
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    const Color(0xFF2E0300).withOpacity(0.4),
                    BlendMode.darken,
                  ),
                  image: const AssetImage('images/sun.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: isMobile
                ? 20
                : size.width * 0.25, // Centra en tablet/escritorio
            right: isMobile
                ? 20
                : size.width * 0.25, // Centra en tablet/escritorio
            bottom: isMobile ? 40 : size.height * 0.4, // Ajusta la posición
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  context.go('/planets');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: isMobile
                      ? MainAxisAlignment.start
                      : MainAxisAlignment
                          .center, // Centra el contenido en tablet/escritorio
                  children: [
                    RichText(
                      textAlign: isMobile
                          ? TextAlign.left
                          : TextAlign
                              .center, // Centra el texto en tablet/escritorio
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              isMobile ? 72 : 100, // Ajuste de tamaño de fuente
                          fontWeight: FontWeight.normal,
                        ),
                        children: const [
                          TextSpan(text: 'Ver '),
                          TextSpan(
                            text: 'Planetas',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: isMobile
                          ? MainAxisAlignment.start
                          : MainAxisAlignment
                              .center, // Centra el icono en tablet/escritorio
                      children: [
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: isMobile
                              ? 52
                              : 72, // Aumentar el tamaño del icono en escritorio
                        ),
                        const SizedBox(width: 50),
                        GestureDetector(
                          onTap: () {
                            context.go('/planets');
                          },
                          child:
                              const SolarSystemFull(), // Sistema solar escalado
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
