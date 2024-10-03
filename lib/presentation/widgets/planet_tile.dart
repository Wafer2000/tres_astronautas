import 'package:flutter/material.dart';
import 'package:tres_astronautas/data/models/planets.dart';
import 'package:tres_astronautas/presentation/widgets/planet_image.dart';
import 'package:go_router/go_router.dart';

class PlanetTile extends StatelessWidget {
  final Planets planet;

  const PlanetTile({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    final isMobileW = MediaQuery.of(context).size.width < 600;
    final isTabletW = MediaQuery.of(context).size.width < 1200;

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
        color: const Color(0xFF000000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                context.go('/planets/${planet.name}');
              },
              child: PlanetImage(image: planet.image),
            ),
          ),
          const SizedBox(height: 8.0),
          Center(
            child: Text(
              planet.name.toUpperCase(),
              style: TextStyle(
                fontSize: isMobileW ? 20 : isTabletW ? 25 : 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Masa: ${planet.massKg} kg',
            style: TextStyle(fontSize: isMobileW ? 14 : isTabletW ? 15 : 16, color: Colors.white),
          ),
          Text(
            'Distancia Orbital: ${planet.orbitalDistanceKm} km',
            style: TextStyle(fontSize: isMobileW ? 14 : isTabletW ? 15 : 16, color: Colors.white),
          ),
          const SizedBox(height: 8.0),
          Text(
            planet.description,
            style: TextStyle(fontSize: isMobileW ? 12 : isTabletW ? 13 : 14, color: Colors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
