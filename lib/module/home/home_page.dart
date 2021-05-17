// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/module/alarm/alarm_page.dart';
import 'package:mclock/module/home/home_widget.dart';
import 'package:mclock/module/settings/settings_page.dart';
import 'package:mclock/module/world_clock/world_clock_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeWidget {
  // final _clockKey = GlobalKey(debugLabel: 'CLOCK KEY');
  // final _alarmKey = GlobalKey(debugLabel: 'ALARM KEY');
  // final _settingsKey = GlobalKey(debugLabel: 'SETTINGS KEY');

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    print('onSelected $payload .');
    // if (payload != null) {
    //   debugPrint('notification payload: $payload');
    // }
    // print('tapped');
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    print('onNotificationReceived');
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: vm.stream,
        builder: (_, d) => Scaffold(
              backgroundColor: AppColors.white,
              body: BottomBarPageTransition(
                builder: (_, i) => i == PageType.clock.index
                    ? WorldClockPage()
                    : i == PageType.alarm.index
                        ? AlarmPage()
                        : SettingsPage(),
                currentIndex: vm.selectedPage.index,
                totalLength: PageType.values.length,
                transitionType: TransitionType.slide,
              ),
              bottomNavigationBar: buildBottomBar(context),
            ));
  }
}

enum PageType { clock, alarm, settings }
