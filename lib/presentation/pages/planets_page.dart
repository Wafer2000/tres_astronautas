import 'package:flutter/material.dart';
import 'package:tres_astronautas/presentation/widgets/search_bar.dart';
import 'package:tres_astronautas/presentation/widgets/planet_tile.dart';
import '../../data/models/planets.dart';
import '../../data/services/planet_service.dart';

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
          return const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los planetas. Por favor, intenta de nuevo más tarde.'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No se encontraron planetas'));
        }

        // Filtrar los planetas
        final filteredPlanets = snapshot.data!.where((planet) {
          return planet.name.toLowerCase().contains(filter.toLowerCase()) ||
                 planet.massKg.toString().contains(filter) ||
                 planet.orbitalDistanceKm.toString().contains(filter);
        }).toList();

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  'Listado de Planetas'.toUpperCase(),
                  style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            backgroundColor: Colors.black,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: CustomSearchBar(onSearch: _filterPlanets),
            ),
          ),
          body: Center(
            child: SizedBox(
              width: 500,
              child: ListView.builder(
                itemCount: filteredPlanets.length,
                itemBuilder: (context, index) {
                  return PlanetTile(planet: filteredPlanets[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
