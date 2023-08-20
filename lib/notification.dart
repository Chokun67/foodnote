import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationAlert{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNotification(String title, String notificationText) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // กำหนด ID ของช่องการแจ้งเตือนสำหรับแอนดรอยด์
      'your_channel_name', // กำหนดชื่อของช่องการแจ้งเตือนสำหรับแอนดรอยด์
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );


    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      notificationText,
      platformChannelSpecifics,
      payload: 'notification',
    );
  }
}
