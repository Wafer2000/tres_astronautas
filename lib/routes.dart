import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tres_astronautas/presentation/pages/error_page.dart';
import 'package:tres_astronautas/presentation/pages/home_page.dart';
import 'package:tres_astronautas/presentation/pages/planet_detail_page.dart';
import 'package:tres_astronautas/presentation/pages/planets_page.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/planets',
      builder: (context, state) => const PlanetsPage(),
    ),
    GoRoute(
      path: '/planets/:planet',
      builder: (context, state) {
        final String? planetName = state.pathParameters['planet'];
        if (planetName == null) {
          return const ErrorPage(); // Redirige a la página de error si no hay `planet`
        }
        return PlanetDetailPage(planetName: planetName); // Página de detalles del planeta
      },
    ),
  ],
  errorPageBuilder: (context, state) => const MaterialPage(
    child: ErrorPage(),
  ),
);
