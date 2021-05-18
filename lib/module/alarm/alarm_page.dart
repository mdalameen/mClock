import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mclock/common/model.dart';
import 'package:timezone/timezone.dart' as tz;

import 'alarm_widget.dart';

class AlarmPage extends StatefulWidget {
  AlarmPage({GlobalKey key}) : super(key: key);
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> with AlarmWidget {
  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  removeAlarm(AlarmItem alarm) async {
    await FlutterLocalNotificationsPlugin().cancel(alarm.id);
    vm.removeAlarm(alarm);
  }

  onAddPressed() async {
    DateTime date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 300)));
    if (date == null) return;
    final now = DateTime.now();
    bool isSameDay = date.day == now.day && date.month == now.month;
    TimeOfDay time = await showTimePicker(context: context, initialTime: isSameDay ? TimeOfDay.now() : TimeOfDay(hour: 0, minute: 0));
    if (time == null) return;
    DateTime t = date.add(Duration(hours: time.hour, minutes: time.minute));

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
      vm.addAlarm(AlarmItem(vm.alarms.length, t));
    }
  }
}
