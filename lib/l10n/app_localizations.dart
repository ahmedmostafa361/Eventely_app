import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @first.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get first;

  /// No description provided for @createEvent.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get createEvent;

  /// No description provided for @eventTitle.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get eventTitle;

  /// No description provided for @eventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// No description provided for @updateDetails.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get updateDetails;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @eventDescription.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get eventDescription;

  /// No description provided for @eventDate.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get eventDate;

  /// No description provided for @eventTime.
  ///
  /// In en, this message translates to:
  /// **'Event Time'**
  String get eventTime;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get chooseDate;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get chooseTime;

  /// No description provided for @chooseEventLocation.
  ///
  /// In en, this message translates to:
  /// **'Choose Event Location'**
  String get chooseEventLocation;

  /// No description provided for @addEvent.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get addEvent;

  /// No description provided for @bookClub.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get bookClub;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get enterTitle;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get enterDescription;

  /// No description provided for @plsChooseDate.
  ///
  /// In en, this message translates to:
  /// **'Please enter a date'**
  String get plsChooseDate;

  /// No description provided for @plsChooseTime.
  ///
  /// In en, this message translates to:
  /// **'Please enter a time'**
  String get plsChooseTime;

  /// No description provided for @pg1t1.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get pg1t1;

  /// No description provided for @pg1b1.
  ///
  /// In en, this message translates to:
  /// **'Lets start'**
  String get pg1b1;

  /// No description provided for @pg2t1.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get pg2t1;

  /// No description provided for @pg2t2.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get pg2t2;

  /// No description provided for @pg3t1.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get pg3t1;

  /// No description provided for @pg3t2.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get pg3t2;

  /// No description provided for @pg4t1.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get pg4t1;

  /// No description provided for @pg4t2.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get pg4t2;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'John Safwat'**
  String get userName;

  /// No description provided for @userLocation.
  ///
  /// In en, this message translates to:
  /// **'Cairo, Egypt'**
  String get userLocation;

  /// No description provided for @please_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get please_enter_password;

  /// No description provided for @please_enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get please_enter_valid_email;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgot_password;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have Account ?'**
  String get dont_have_account;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_with_google;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @re_password.
  ///
  /// In en, this message translates to:
  /// **'Re Password'**
  String get re_password;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account ?'**
  String get already_have_account;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'ofo Sport'**
  String get appName;

  /// No description provided for @please_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get please_enter_name;

  /// No description provided for @please_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get please_enter_email;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalid_email;

  /// No description provided for @password_too_short.
  ///
  /// In en, this message translates to:
  /// **'Password should be at least 6 characters'**
  String get password_too_short;

  /// No description provided for @password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get password_not_match;

  /// No description provided for @languageEN.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get languageEN;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @birthdayDate.
  ///
  /// In en, this message translates to:
  /// **'21 Nov'**
  String get birthdayDate;

  /// No description provided for @birthdayDescription.
  ///
  /// In en, this message translates to:
  /// **'This is a Birthday Party'**
  String get birthdayDescription;

  /// No description provided for @meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get meeting;

  /// No description provided for @meetingDate.
  ///
  /// In en, this message translates to:
  /// **'22 Nov'**
  String get meetingDate;

  /// No description provided for @meetingDescription.
  ///
  /// In en, this message translates to:
  /// **'Meeting for Updating The Development Method'**
  String get meetingDescription;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'°C'**
  String get temperature;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @homeDate.
  ///
  /// In en, this message translates to:
  /// **'22 Nov'**
  String get homeDate;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @google_short.
  ///
  /// In en, this message translates to:
  /// **'G'**
  String get google_short;

  /// No description provided for @exhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get exhibition;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @love.
  ///
  /// In en, this message translates to:
  /// **'favourite'**
  String get love;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get gaming;

  /// No description provided for @workshop.
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get workshop;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @eating.
  ///
  /// In en, this message translates to:
  /// **'Eating'**
  String get eating;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
