import 'package:flutter/material.dart';
import 'package:tres_astronautas/data/models/planets.dart';

class PlanetDetails extends StatelessWidget {
  final Planets planet;

  const PlanetDetails({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600; // Define si es escritorio

    final details = [
      {'label': 'Name', 'value': planet.name, 'icon': Icons.public},
      {
        'label': 'Description',
        'value': planet.description,
        'icon': Icons.description
      },
      {
        'label': 'Mass',
        'value': '${planet.massKg} kg',
        'icon': Icons.fitness_center
      },
      {
        'label': 'Orbital Distance',
        'value': '${planet.orbitalDistanceKm} km',
        'icon': Icons.track_changes
      },
      {
        'label': 'Equatorial Radius',
        'value': '${planet.equatorialRadiusKm} km',
        'icon': Icons.assessment
      },
      {
        'label': 'Volume',
        'value': '${planet.volumeKm3} km³',
        'icon': Icons.aspect_ratio
      },
      {
        'label': 'Density',
        'value': '${planet.densityGCm3} g/cm³',
        'icon': Icons.balance
      },
      {
        'label': 'Surface Gravity',
        'value': '${planet.surfaceGravityMS2} m/s²',
        'icon': Icons.swap_vert
      },
      {
        'label': 'Escape Velocity',
        'value': '${planet.escapeVelocityKmh} km/h',
        'icon': Icons.launch
      },
      {
        'label': 'Day Length',
        'value': '${planet.dayLengthEarthDays} días terrestres',
        'icon': Icons.timer
      },
      {
        'label': 'Year Length',
        'value': '${planet.yearLengthEarthDays} días terrestres',
        'icon': Icons.calendar_today
      },
      {
        'label': 'Orbital Speed',
        'value': '${planet.orbitalSpeedKmh} km/h',
        'icon': Icons.speed
      },
      {
        'label': 'Atmosphere Composition',
        'value': planet.atmosphereComposition,
        'icon': Icons.cloud
      },
      {
        'label': 'Number of Moons',
        'value': '${planet.moons}',
        'icon': Icons.star
      },
      {
        'label': 'Year Length (Earth Years)',
        'value': '${planet.yearLengthEarthYears}',
        'icon': Icons.calendar_today
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? screenWidth * 0.1 : screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details.map((detail) {
            final String label = detail['label'] as String;
            final String value = detail['value'] as String;
            final IconData icon = detail['icon'] as IconData;

            return Container(
              constraints: const BoxConstraints(
                maxWidth: 481.3,
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(
                  16.0), // Padding fijo para mantener consistencia
              decoration: BoxDecoration(
                color: Colors.grey[800], // Fondo gris
                borderRadius: BorderRadius.circular(12.0), // Esquinas curvas
              ),
              child: Row(
                children: [
                  Icon(icon,
                      color: Colors.white,
                      size: isDesktop ? 70 : 50), // Ícono blanco y responsivo
                  const SizedBox(width: 8.0), // Espaciado entre ícono y texto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: isDesktop
                                ? 24
                                : 26, // Tamaño fijo para texto de etiqueta
                            color: Colors.white, // Texto blanco
                            fontWeight: FontWeight.bold, // Texto en negrita
                          ),
                          overflow:
                              TextOverflow.ellipsis, // Prevenir desbordamiento
                          maxLines: 1, // Asegura que solo se muestre una línea
                        ),
                        // Modifica el Text del valor para permitir múltiples líneas
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: isDesktop
                                ? 17
                                : 19, // Tamaño fijo para texto de valor
                            color: Colors.white, // Texto blanco
                          ),
                          overflow:
                              TextOverflow.visible, // Permitir desbordamiento
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
