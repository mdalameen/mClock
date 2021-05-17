import 'dart:io';

// import 'package:awesome_notifications/awesome_notifications.dart';
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
      color: AppColors.grey,
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
    // print('addPressed');
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     // Insert here your friendly dialog box before call the request method
    //     // This is very important to not harm the user experience
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   } else {
    //     AwesomeNotifications().createNotification(
    //         content: NotificationContent(
    //           id: 10,
    //           channelKey: 'basic_channel',
    //           title: 'Simple Notification',
    //           body: 'Simple body',
    //         ),
    //         schedule: NotificationCalendar.fromDate(
    //           date: DateTime.now().add(Duration(seconds: 5)),
    //           allowWhileIdle: true,
    //           repeats: false,
    //         ));
    //   }
    // });
    if (Platform.isIOS) {
      final bool result = await FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>().requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
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
