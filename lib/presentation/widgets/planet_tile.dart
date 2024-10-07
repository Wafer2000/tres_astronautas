import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tres_astronautas/data/models/planets.dart';
import 'package:tres_astronautas/presentation/widgets/planet_image.dart';
import 'package:go_router/go_router.dart';
import 'package:tres_astronautas/presentation/widgets/solar_system_mini.dart';

class PlanetTile extends StatelessWidget {
  final Planets planet;

  const PlanetTile({
    super.key,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2.0),
        color: Colors.black,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Stack(
          clipBehavior: Clip.hardEdge, // Recorta cualquier parte que sobresalga
          children: [
            // Imagen del planeta posicionada detrás del contenido textual
            Positioned(
              left: planet.name != 'Saturn' ? 80 : 30,
              top: -80,
              child: GestureDetector(
                onTap: () => context.go('/planets/${planet.name}'),
                child: PlanetImage(
                  image: planet.image,
                  planetName: planet.name,
                ),
              ),
            ),
            // Planeta en orbita
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: GestureDetector(
                onTap: () => context.go('/planets/${planet.name}'),
                child: SolarSystemMini(
                  planetsToShow: [planet.name],
                ),
              ),
            ),
            // Contenedor principal con el contenido textual
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 10, color: Colors.white),
                    _buildPlanetName(),
                    const SizedBox(height: 4.0),
                    _buildPlanetMass(),
                    const SizedBox(height: 4.0),
                    _buildOrbitalDistance(),
                    const SizedBox(height: 4.0),
                    _buildPlanetDescription(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanetName() {
    return AutoSizeText(
      planet.name.toUpperCase(),
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      presetFontSizes: [25, 15, 15],
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      minFontSize: 10,
    );
  }

  Widget _buildPlanetMass() {
    return _buildAutoSizeText('Mass: ${planet.massKg} kg');
  }

  Widget _buildOrbitalDistance() {
    return _buildAutoSizeText(
        'Orbital Distance: ${planet.orbitalDistanceKm} km');
  }

  Widget _buildPlanetDescription() {
    return _buildAutoSizeText(planet.description);
  }

  Widget _buildAutoSizeText(String text) {
    return AutoSizeText(
      text,
      style: const TextStyle(color: Colors.white),
      presetFontSizes: [18, 16, 14],
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
