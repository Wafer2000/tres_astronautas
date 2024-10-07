import 'package:flutter/material.dart';
import 'package:tres_astronautas/data/models/planets.dart';
import 'package:tres_astronautas/presentation/widgets/favorite_button.dart';
import 'package:tres_astronautas/presentation/widgets/planet_image.dart';
import 'package:tres_astronautas/presentation/widgets/planet_details.dart';
import '../../data/services/planet_service.dart';

class PlanetDetailPage extends StatelessWidget {
  final String planetName;

  const PlanetDetailPage({super.key, required this.planetName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Text('Detalles del planeta',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          FavoriteButton(planetName: planetName), // Reemplazar el botón aquí
        ],
      ),
      body: FutureBuilder<Planets?>(
        future: PlanetService()
            .fetchPlanetByName(planetName), // Aquí usamos Planet?
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar los detalles del planeta'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No se encontraron detalles para este planeta.'),
            );
          }

          final planetDetails =
              snapshot.data!; // Ahora planetDetails es de tipo Planet

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PlanetImage(
                          image: planetDetails.image,
                          planetName: planetDetails.name,
                        ),
                        const SizedBox(height: 20),
                        PlanetDetails(planet: planetDetails),
                      ],
                    ), // Usar el nuevo widget
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
