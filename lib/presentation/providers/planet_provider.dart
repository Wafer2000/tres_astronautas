import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tres_astronautas/data/models/planets.dart';
import '../../data/services/planet_service.dart';

final planetProvider = FutureProvider<List<Planets>>((ref) async {
  final planetService = PlanetService();
  return planetService.fetchPlanets();
});
