import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  MessagingService._();

  static final MessagingService _service = MessagingService._();
  factory MessagingService() => _service;

  static MessagingService get instance => _service;

  Future<void> initialize() async {
    final NotificationSettings settings = await _requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _getToken();
      _firebaseMessagingForgroundHandler();
    }
  }

  get userDeviceToken {
    return _token;
  }

  void setToken(String token) {
    _token = token;
  }

  String? _token;

  Future<void> _getToken() async {
    final String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      _token = token;
    }

    _firebaseMessaging.onTokenRefresh.listen(setToken);
  }

  _firebaseMessagingForgroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        AlertDialog(
          title: Text(message.notification!.title!),
          content: Text(message.notification!.body!),
        );
      }
    });
  }

  Future<bool> isPermissionEnable(AuthorizationStatus status) async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == status;
  }

  Future<NotificationSettings> _requestPermission() async {
    final NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
            alert: true,
            badge: true,
            sound: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            announcement: false);

    return settings;
  }
}
