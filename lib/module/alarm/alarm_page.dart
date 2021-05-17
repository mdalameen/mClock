import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmPage extends StatefulWidget {
  AlarmPage({GlobalKey key}) : super(key: key);
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Alarms'),
            actions: [
              IconButton(icon: Icon(Icons.add), onPressed: onAddPressed),
            ],
          ),
        ],
      ),
    );
  }

  onAddPressed() async {
    var allow = false;
    if (Platform.isIOS) {
      allow = (await FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>().requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              )) ??
          false;
    } else {
      allow = true;
    }
    if (allow) {
      await FlutterLocalNotificationsPlugin().zonedSchedule(
        1,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(android: AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
