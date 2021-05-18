import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/injector.dart';
import 'module/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MClock',
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: AppColors.clockInner),
      home: HomePage(),
    );
  }
}
