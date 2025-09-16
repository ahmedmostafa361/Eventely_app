import 'package:evently_app_flutter/ui/intro_screen/intro_screen%20.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.introScreenRoute,
      routes: {AppRoutes.introScreenRoute: (context) => IntroScreen()},
      // darkTheme: AppTheme.darkTheme ,
      themeMode: ThemeMode.light,
    );
  }
}
