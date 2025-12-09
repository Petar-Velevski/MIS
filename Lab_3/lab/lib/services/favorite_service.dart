import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const _key = 'favorite_meal_ids';

  FavoriteService._();

  static final FavoriteService instance = FavoriteService._();

  List<String> _favoriteIds = [];

  List<String> get favoriteIds => _favoriteIds;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList(_key) ?? [];
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _favoriteIds);
  }

  bool isFavorite(String mealId) {
    return _favoriteIds.contains(mealId);
  }

  Future<void> toggleFavorite(String mealId) async {
    if (isFavorite(mealId)) {
      _favoriteIds.remove(mealId);
    } else {
      _favoriteIds.add(mealId);
    }
    await _saveFavorites();
  }
}
