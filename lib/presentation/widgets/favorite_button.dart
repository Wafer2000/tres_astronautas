import 'package:flutter/material.dart';
import 'package:tres_astronautas/data/services/favorite_service.dart';

class FavoriteButton extends StatefulWidget {
  final String planetName;

  const FavoriteButton({super.key, required this.planetName});

  @override
  FavoriteButtonState createState() => FavoriteButtonState();
}

class FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false; // Controlar si es favorito
  final FavoritesService favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _checkIfFavorite(); // Verifica si el planeta es favorito al iniciar
  }

  // Verifica si el planeta es favorito
  void _checkIfFavorite() async {
    isFavorite = await favoritesService.isFavorite(widget.planetName);
    setState(() {}); // Actualiza el estado
  }

  // Maneja el cambio de estado del favorito
  void _toggleFavorite() async {
    if (isFavorite) {
      await favoritesService.removeFavorite(widget.planetName);
    } else {
      await favoritesService.saveFavorite(widget.planetName);
    }
    setState(() {
      isFavorite = !isFavorite; // Cambia el estado
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: _toggleFavorite,
    );
  }
}
