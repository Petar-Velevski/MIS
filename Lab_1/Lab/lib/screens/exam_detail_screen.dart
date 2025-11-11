import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({required this.exam, Key? key}) : super(key: key);

  String getRemainingTime() {
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);
    if (diff.isNegative) return "Испитот е поминат";

    final days = diff.inDays;
    final hours = diff.inHours % 24;
    return "$days дена, $hours часа";
  }

  bool isPast() {
    final now = DateTime.now();
    return exam.dateTime.isBefore(now);
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = getRemainingTime();
    final pastExam = isPast();

    return Scaffold(
      backgroundColor: Colors.blue[50]?.withOpacity(0.95),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: Container(
          padding: EdgeInsets.only(top: 28, bottom: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff2276f4),
                Colors.indigo[700]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Color(0xff2276f4), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: SizedBox(
                width: 280,
                child: Text(
                  exam.subjectName,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: Color(0xff2276f4),
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.blue[100]!,
                        offset: Offset(0, 3),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Color(0xff2276f4)),
                          SizedBox(width: 8),
                          Text(
                            'Датум: ${DateFormat('dd.MM.yyyy').format(exam.dateTime)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Color(0xff2276f4)),
                          SizedBox(width: 8),
                          Text(
                            'Време: ${DateFormat('HH:mm').format(exam.dateTime)}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, color: Color(0xff2276f4)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Простории: ${exam.rooms.join(', ')}',
                              style: TextStyle(fontSize: 16),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Divider(),
                      SizedBox(height: 14),
                      Text(
                        'Останато време до испитот:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900],
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        remainingTime,
                        style: TextStyle(
                          fontSize: 18,
                          color: pastExam ? Colors.red : Colors.indigo[700],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff2276f4),
                        Colors.indigo[700]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 23, vertical: 18),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => Navigator.of(context).pop(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Сите испити',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
