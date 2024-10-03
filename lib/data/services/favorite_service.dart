import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  // Guardar un planeta como favorito
  Future<void> saveFavorite(String planetName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList(_favoritesKey) ?? [];
    
    if (!favorites.contains(planetName)) {
      favorites.add(planetName);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  // Eliminar un planeta de los favoritos
  Future<void> removeFavorite(String planetName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList(_favoritesKey) ?? [];
    
    if (favorites.contains(planetName)) {
      favorites.remove(planetName);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  // Verificar si un planeta es favorito
  Future<bool> isFavorite(String planetName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.contains(planetName);
  }

  // Obtener la lista de favoritos
  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }
}
