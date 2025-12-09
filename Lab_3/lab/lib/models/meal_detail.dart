class MealDetail {
  final String id;
  final String name;
  final String instructions;
  final String imageUrl;
  final String youtubeUrl;
  final List<String> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    required this.instructions,
    required this.imageUrl,
    required this.youtubeUrl,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredientsList = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientsList.add('${ingredient.trim()} - ${measure?.trim() ?? ""}');
      }
    }
    return MealDetail(
      id: json['idMeal'],
      name: json['strMeal'],
      instructions: json['strInstructions'],
      imageUrl: json['strMealThumb'],
      youtubeUrl: json['strYoutube'] ?? '',
      ingredients: ingredientsList,
    );
  }
}
