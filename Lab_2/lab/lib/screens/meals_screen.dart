import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  final String categoryName;

  MealsScreen({required this.categoryName});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  ApiService apiService = ApiService();
  List<Meal> meals = [];
  List<Meal> filteredMeals = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadMeals();
  }

  void loadMeals() async {
    meals = await apiService.fetchMealsByCategory(widget.categoryName);
    filteredMeals = meals;
    setState(() => loading = false);
  }

  void searchMeals(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredMeals = meals;
      });
    } else {
      final searchedMeals = await apiService.searchMeals(query);
      setState(() => filteredMeals = searchedMeals);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search meals',
                fillColor: Colors.white,
                filled: true,
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: searchMeals,
            ),
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: filteredMeals.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (_, index) {
                final meal = filteredMeals[index];
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
