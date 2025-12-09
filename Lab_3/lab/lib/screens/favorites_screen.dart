import 'package:flutter/material.dart';
import '../services/favorite_service.dart';
import '../services/api_service.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ApiService apiService = ApiService();
  List<Meal> _favoriteMeals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteMeals();
  }

  Future<void> _loadFavoriteMeals() async {
    final ids = FavoriteService.instance.favoriteIds;
    List<Meal> meals = [];
    for (final id in ids) {
      final detail = await apiService.fetchMealDetails(id);
      meals.add(
        Meal(id: detail.id, name: detail.name, thumbnail: detail.imageUrl),
      );
    }
    setState(() {
      _favoriteMeals = meals;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Recipes')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _favoriteMeals.isEmpty
          ? Center(child: Text('No favorites yet.'))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _favoriteMeals.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (_, index) {
                final meal = _favoriteMeals[index];
                return MealCard(
                  meal: meal,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailScreen(mealId: meal.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
