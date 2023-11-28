import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:ramirez_ayala_s_application16/theme/theme_helper.dart';
import 'package:ramirez_ayala_s_application16/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'ramirez_ayala_s_application16',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.frminicioContainerScreen,
      routes: AppRoutes.routes,
    );
  }
}
