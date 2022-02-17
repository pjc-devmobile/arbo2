import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_cloud_messaging_wapper.dart';

///Notificações
class HandleNotification {
  static List<String> _idsUltimasNotificaoesMostradas = [];

  static showNotification(RemoteMessage message, AndroidNotificationChannel channel, flutterLocalNotificationsPlugin) async {
    if (_idsUltimasNotificaoesMostradas.contains(message.hashCode.toString()))
      return;
    else
      _idsUltimasNotificaoesMostradas.add(message.hashCode.toString());

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channel.description,
      // TODO add a proper drawable resource to android, for now using
      //      one that already exists in example app.
      icon: 'launch_background',
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
    );
  }

  static showNotificationLocal(Map<String, dynamic> message) async {
    if (_idsUltimasNotificaoesMostradas.contains(message.hashCode.toString()))
      return;
    else
      _idsUltimasNotificaoesMostradas.add(message.hashCode.toString());

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      FirebaseCloudMessagagingWapper.channel.id,
      FirebaseCloudMessagagingWapper.channel.name,
      FirebaseCloudMessagagingWapper.channel.description,
      // TODO add a proper drawable resource to android, for now using
      //      one that already exists in example app.
      icon: 'launch_background',
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await FirebaseCloudMessagagingWapper.flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message["notification"]["title"],
      message["notification"]["body"],
      notificationDetails,
    );
  }
}