import 'package:flutter/material.dart';
import 'screens/exam_list_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ExamListScreen(),
    theme: ThemeData(primarySwatch: Colors.blue),
  ));
}