import 'package:flutter/material.dart';
import 'package:tres_astronautas/data/models/planets.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const CustomSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A), // Color de fondo del contenedor
          borderRadius: BorderRadius.circular(30), // Esquinas curvadas
        ),
        child: TextField(
          onChanged: onSearch,
          style: const TextStyle(color: Colors.white), // Color del texto
          decoration: const InputDecoration(
            hintText: 'Filtrar planetas...',
            hintStyle: TextStyle(color: Colors.white54),
            filled: false, // No llenar el fondo, el contenedor ya lo hace
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            // Aquí no se necesita fillColor porque ya está en el contenedor
          ),
        ),
      ),
    );
  }
}

List<Planets> filterPlanets(List<Planets> planets, String query) {
  return planets.where((planet) {
    return planet.name.toLowerCase().contains(query.toLowerCase()) ||
        planet.massKg.toString().contains(query) ||
        planet.orbitalDistanceKm.toString().contains(query);
  }).toList();
}
