import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../screens/exam_detail_screen.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({required this.exam, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isPast = exam.dateTime.isBefore(now);
    final cardColor = isPast ? Colors.grey[200] : Colors.green[100];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExamDetailScreen(exam: exam),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Card(
          color: cardColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exam.subjectName,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: Colors.indigo[900],
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 9),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 17, color: Colors.indigo[400]),
                    SizedBox(width: 4),
                    Text(
                      DateFormat('dd.MM.yyyy').format(exam.dateTime),
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(width: 18),
                    Icon(Icons.access_time, size: 17, color: Colors.indigo[400]),
                    SizedBox(width: 4),
                    Text(
                      DateFormat('HH:mm').format(exam.dateTime),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 17, color: Colors.indigo[400]),
                    SizedBox(width: 4),
                    Text(
                      exam.rooms.join(', '),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
