import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MealApp());
}

class MealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Recipes',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color(0xFFF7F6F9),
        cardColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
