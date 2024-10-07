import 'package:flutter/material.dart';
import '../../data/models/planets.dart';
import '../../data/services/planet_service.dart';
import '../widgets/background_container.dart';
import '../widgets/error_message.dart';
import '../widgets/loading_indicator.dart';

class PlanetsPage extends StatefulWidget {
  const PlanetsPage({super.key});

  @override
  PlanetsPageState createState() => PlanetsPageState();
}

class PlanetsPageState extends State<PlanetsPage> {
  late Future<List<Planets>> futurePlanets;
  String filter = '';

  @override
  void initState() {
    super.initState();
    futurePlanets = PlanetService().fetchPlanets();
  }

  void _filterPlanets(String query) {
    setState(() {
      filter = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Planets>>(
      future: futurePlanets,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.hasError) {
          return const ErrorMessage();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No se encontraron planetas'));
        }

        final filteredPlanets = _filterPlanetList(snapshot.data!);
        Size size = MediaQuery.of(context).size;

        return BackgroundContainer(
          size: size,
          filteredPlanets: filteredPlanets,
          onSearch: _filterPlanets,
        );
      },
    );
  }

  List<Planets> _filterPlanetList(List<Planets> planets) {
    return planets.where((planet) {
      return planet.name.toLowerCase().contains(filter.toLowerCase()) ||
          planet.massKg.toString().contains(filter) ||
          planet.orbitalDistanceKm.toString().contains(filter);
    }).toList();
  }
}
