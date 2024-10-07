import 'package:flutter/material.dart';
import 'package:tres_astronautas/presentation/widgets/planet_tile.dart';
import '../../data/models/planets.dart';

class PlanetGrid extends StatelessWidget {
  final List<Planets> filteredPlanets;

  const PlanetGrid({super.key, required this.filteredPlanets});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10, left: 10, right: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCountWidth = _getCrossAxisCount(constraints.maxWidth);
            double childAspectRatioHeight =
                _getChildAspectRatio(constraints.maxWidth);

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCountWidth,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: childAspectRatioHeight,
              ),
              itemCount: filteredPlanets.length,
              itemBuilder: (context, index) {
                return PlanetTile(
                  planet: filteredPlanets[index],
                );
              },
            );
          },
        ),
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    if (width > 1400) return 4;
    if (width < 1380 && width > 780) return 3;
    if (width < 780 && width > 548) return 2;
    return 1;
  }

  double _getChildAspectRatio(double width) {
    if (width > 1400) return 0.95;
    if (width < 1380 && width > 780) return 0.65;
    if (width < 780 && width > 500) return 0.89;
    return 0.98;
  }
}
