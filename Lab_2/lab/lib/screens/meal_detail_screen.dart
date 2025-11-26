import 'package:flutter/material.dart';
import '../models/meal_detail.dart';
import '../services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatefulWidget {
  final String? mealId;
  final MealDetail? mealDetail;

  MealDetailScreen({this.mealId, this.mealDetail});

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  ApiService apiService = ApiService();
  late Future<MealDetail> mealDetailFuture;

  @override
  void initState() {
    super.initState();
    if (widget.mealDetail != null) {
      mealDetailFuture = Future.value(widget.mealDetail!);
    } else {
      mealDetailFuture = apiService.fetchMealDetails(widget.mealId!);
    }
  }

  void openYoutube(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Details')),
      body: FutureBuilder<MealDetail>(
        future: mealDetailFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final meal = snapshot.data!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      meal.imageUrl,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  meal.name,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Ingredients",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: meal.ingredients
                      .map(
                        (ingredient) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            ingredient,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[850],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 16),
                Text(
                  "Instructions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  meal.instructions,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[900],
                    height: 1.4,
                  ),
                ),
                if (meal.youtubeUrl.isNotEmpty) ...[
                  SizedBox(height: 18),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.video_library),
                      label: Text("Watch on YouTube"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => openYoutube(meal.youtubeUrl),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
