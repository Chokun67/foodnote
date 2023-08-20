import 'package:flutter/material.dart';
import 'package:foodnote/first.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes.dart';
import 'package:foodnote/person.dart' as foodnoteperson;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {

   WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await Hive.initFlutter();
  Hive.registerAdapter(foodnoteperson.PersonAdapter());
  boxPersons = await Hive.openBox<foodnoteperson.Person>('personBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const FirstPage(),
    );
  }
}

