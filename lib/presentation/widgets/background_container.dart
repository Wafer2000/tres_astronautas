import 'package:flutter/material.dart';
import 'package:tres_astronautas/presentation/widgets/app_bar.dart';
import 'package:tres_astronautas/presentation/widgets/planet_grid.dart';
import '../../data/models/planets.dart';

class BackgroundContainer extends StatelessWidget {
  final Size size;
  final List<Planets> filteredPlanets;
  final Function(String) onSearch;

  const BackgroundContainer({
    super.key,
    required this.size,
    required this.filteredPlanets,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            const Color(0xFF2E0300).withOpacity(0.4),
            BlendMode.darken,
          ),
          image: const NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/tre-sastronautas.appspot.com/o/stars.jpg?alt=media&token=8dff3355-c407-4ce3-b5cb-a4ec25401cc3',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(onSearch: onSearch),
        body: PlanetGrid(filteredPlanets: filteredPlanets),
      ),
    );
  }
}
