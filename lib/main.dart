import 'package:evently_app_flutter/providers/app_language_providers%20.dart';
import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/ui/intro_screen/first_page_screen%20.dart';
import 'package:evently_app_flutter/ui/intro_screen/intro_screen%20.dart';
import 'package:evently_app_flutter/ui/tabs/profile_tab/profile_screen%20.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:evently_app_flutter/utlis/app_theme%20.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => AppLanguageProviders(),),
            ChangeNotifierProvider(create: (context) => AppThemeProvider(),)
          ],
          child: Myapp()
      )
  );
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProviders>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.firstPageScreen,
      // AppRoutes.profileTabScreen,
      // AppRoutes.introScreenRoute,
      routes: {
        AppRoutes.firstPageScreen: (context) => FirstPageScreen(),
        AppRoutes.introScreenRoute: (context) => IntroScreen(),
        AppRoutes.profileTabScreen: (context) => ProfileScreen()
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
