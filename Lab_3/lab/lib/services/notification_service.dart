import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../screens/meal_detail_screen.dart';
import '../main.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('🔔 Permission: ${settings.authorizationStatus}');

    final token = await _messaging.getToken();
    print('📱 FCM token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🔔 Foreground message data: ${message.data}');
      if (message.notification != null) {
        print(
          '🔔 Notification: ${message.notification!.title} '
          '- ${message.notification!.body}',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageTap);

    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      _handleMessageTap(initialMessage);
    }
  }

  Future<void> _handleMessageTap(RemoteMessage message) async {
    print('🔔 Notification tapped with data: ${message.data}');

    final api = ApiService();
    final randomMeal = await api.fetchRandomMeal();

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => MealDetailScreen(mealDetail: randomMeal),
      ),
    );
  }
}
