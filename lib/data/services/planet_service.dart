import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/planets.dart';

class PlanetService {
  Future<List<Planets>> fetchPlanets() async {
    final response = await http.get(Uri.parse(
        'https://us-central1-a-academia-espacial.cloudfunctions.net/planets'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> planetsJson = jsonResponse['data'];
      return planetsJson
          .map((planetJson) => Planets.fromJson(planetJson))
          .toList();
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Future<Planets?> fetchPlanetByName(String planetName) async {
    final response = await http.get(Uri.parse(
        'https://us-central1-a-academia-espacial.cloudfunctions.net/planets/$planetName'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
        // Buscar el planeta específico por nombre
        final List<dynamic> planets = jsonResponse['data'];
        for (var planet in planets) {
          if (planet['name'].toString().toLowerCase() ==
              planetName.toLowerCase()) {
            return Planets.fromJson(planet); // Retorna el planeta que coincide
          }
        }
        return null; // Si no se encuentra el planeta específico
      } else {
        return null; // En caso de que no se encuentre el planeta
      }
    } else {
      throw Exception('Failed to load planet: $planetName');
    }
  }
}
