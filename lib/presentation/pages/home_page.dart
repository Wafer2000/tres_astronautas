import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tres_astronautas/presentation/widgets/solar_system_mini.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/tre-sastronautas.appspot.com/o/sun.jpg?alt=media&token=98ee3ddc-82f8-4fc6-ad24-1d5020f43f69',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.red,
                  child: const Center(
                      child: Icon(Icons.error, color: Colors.white)),
                );
              },
            ),
            Positioned(
              left: isMobile ? 20 : size.width * 0.25,
              right: isMobile ? 20 : size.width * 0.25,
              bottom: isMobile ? 40 : size.height * 0.4,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    // Usar un Future.delayed para verificar el contexto
                    Future.delayed(Duration.zero, () {
                      context.go('/planets');
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isMobile
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: isMobile ? TextAlign.left : TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 72 : 100,
                            fontWeight: FontWeight.normal,
                          ),
                          children: const [
                            TextSpan(text: 'Ver '),
                            TextSpan(
                                text: 'Planetas',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: isMobile
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: isMobile ? 52 : 72,
                          ),
                          const SizedBox(width: 50),
                          GestureDetector(
                            onTap: () {
                              context.go('/planets');
                            },
                            child: SolarSystemMini(
                              planetsToShow: [
                                'Mercury',
                                'Venus',
                                'Earth',
                                'Mars',
                                'Jupiter',
                                'Saturn',
                                'Uranus',
                                'Neptune'
                              ],
                            ),
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
      ),
    );
  }
}
