import 'package:evently_app_flutter/auth/login_screen%20.dart';
import 'package:evently_app_flutter/auth/register_screen%20.dart';
import 'package:evently_app_flutter/auth/reset_pass_screen.dart';
import 'package:evently_app_flutter/providers/app_language_providers%20.dart';
import 'package:evently_app_flutter/providers/app_theme_provider%20.dart';
import 'package:evently_app_flutter/providers/event_list_provider.dart'; // ← ADD THIS
import 'package:evently_app_flutter/providers/location_provider.dart';
import 'package:evently_app_flutter/providers/my_users_provider.dart';
import 'package:evently_app_flutter/ui/add_event_screen/add_event_screen.dart';
import 'package:evently_app_flutter/ui/intro_screen/first_page_screen%20.dart';
import 'package:evently_app_flutter/ui/intro_screen/intro_screen%20.dart';
import 'package:evently_app_flutter/ui/tabs/home_screen/home_screen_with_details/event_details_screen.dart';
import 'package:evently_app_flutter/ui/tabs/home_screen/home_screen_with_details/event_edit_screen.dart';
import 'package:evently_app_flutter/ui/tabs/home_screen/nav_bar_screen.dart';
import 'package:evently_app_flutter/utlis/app_routes%20.dart';
import 'package:evently_app_flutter/utlis/app_theme%20.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'location picker/location_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProviders()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => MyUsersProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => EventListProvider()),
        // ← ADD THIS
      ],
      child: Myapp(),
    ),
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
      routes: {
        AppRoutes.firstPageScreen: (context) => FirstPageScreen(),
        AppRoutes.introScreenRoute: (context) => IntroScreen(),
        AppRoutes.homeScreenRoute: (context) => NavBarScreen(),
        AppRoutes.loginScreen: (context) => LoginScreen(),
        AppRoutes.registerScreen: (context) => RegisterScreen(),
        AppRoutes.resetPassScreen: (context) => ResetPassScreen(),
        AppRoutes.addEventScreen: (context) => AddEventScreen(),
        AppRoutes.eventDetailsScreen: (context) => EventDetailsScreen(),
        AppRoutes.eventEditScreen: (context) => EventEditScreen(),
        AppRoutes.locationPickerScreen: (context) => LocationPicker(),
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