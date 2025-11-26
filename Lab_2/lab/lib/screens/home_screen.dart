import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../widgets/category_card.dart';
import 'meals_screen.dart';
import 'meal_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService apiService = ApiService();
  List<Category> categories = [];
  List<Category> filteredCategories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    categories = await apiService.fetchCategories();
    filteredCategories = categories;
    setState(() => loading = false);
  }

  void searchCategory(String query) {
    final searchResult = categories
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() => filteredCategories = searchResult);
  }

  void openRandomRecipe() async {
    final randomMeal = await apiService.fetchRandomMeal();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealDetailScreen(mealDetail: randomMeal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: openRandomRecipe,
            tooltip: "Random Recipe",
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search categories',
                fillColor: Colors.white,
                filled: true,
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: searchCategory,
            ),
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (_, index) {
                final category = filteredCategories[index];
                return CategoryCard(
                  category: category,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealsScreen(categoryName: category.name),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
