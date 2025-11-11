import 'package:flutter/material.dart';
import '../models/exam_data.dart';
import '../widgets/exam_card.dart';

class ExamListScreen extends StatelessWidget {
  final String studentIndex = "201214";

  @override
  Widget build(BuildContext context) {
    examList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Распоред за Испити',
                    textAlign: TextAlign.center,
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
                  SizedBox(height: 4),
                  Text(
                    studentIndex,
                    style: TextStyle(
                      color: Color(0xff2276f4),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 14),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              itemCount: examList.length,
              itemBuilder: (context, index) {
                return ExamCard(exam: examList[index]);
              },
            ),
          ),
          SafeArea(
            bottom: true,
            top: false,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Center(
                child: Container(
                  width: 300,
                  margin: EdgeInsets.symmetric(horizontal: 4),
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
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.list_alt, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Text(
                        'Вкупно испити: ${examList.length}',
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
    );
  }
}
