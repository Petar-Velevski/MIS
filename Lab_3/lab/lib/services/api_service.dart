import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}categories.php'));
    final data = json.decode(response.body);
    List categoriesJson = data['categories'];
    return categoriesJson.map((json) => Category.fromJson(json)).toList();
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final response = await http.get(
      Uri.parse('${baseUrl}filter.php?c=$category'),
    );
    final data = json.decode(response.body);
    List mealsJson = data['meals'];
    return mealsJson.map((json) => Meal.fromJson(json)).toList();
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('${baseUrl}search.php?s=$query'));
    final data = json.decode(response.body);
    if (data['meals'] == null) return [];
    List mealsJson = data['meals'];
    return mealsJson.map((json) => Meal.fromJson(json)).toList();
  }

  Future<MealDetail> fetchMealDetails(String id) async {
    final response = await http.get(Uri.parse('${baseUrl}lookup.php?i=$id'));
    final data = json.decode(response.body);
    return MealDetail.fromJson(data['meals'][0]);
  }

  Future<MealDetail> fetchRandomMeal() async {
    final response = await http.get(Uri.parse('${baseUrl}random.php'));
    final data = json.decode(response.body);
    return MealDetail.fromJson(data['meals'][0]);
  }
}
