<div align="center">

# 🎉 Evently — Event Planning App

**A feature-rich Flutter mobile application for discovering, creating, and managing events — powered by Firebase and built with Clean Architecture.**

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%7C%20Auth-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Provider](https://img.shields.io/badge/State%20Management-Provider-7B68EE?style=for-the-badge)](https://pub.dev/packages/provider)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blueviolet?style=for-the-badge&logo=android&logoColor=white)](https://flutter.dev)

<br/>

[📱 View Demo](#-demo) • [🚀 Quick Start](#-installation) • [🏗 Architecture](#-architecture--state-management) • [👨‍💻 Author](#-author)

</div>

---

## 📌 About The Project

**Evently** is a cross-platform mobile application built with Flutter that empowers users to seamlessly create, manage, and explore events. Whether it's a birthday party, a sports meetup, a workshop, or a book club — Evently helps you organize it all in one place.

The app features real-time syncing via Cloud Firestore, interactive map-based location picking, Google Sign-In authentication, multi-language support (Arabic & English), dark/light theming, and a clean, modern UI.

> 🏗 Built with **Clean Architecture**, **MVVM** principles, and **Provider** state management — showcasing production-level Flutter development practices.

---

## ✨ Features

| Feature | Description |
|--------|-------------|
| 🔐 **Authentication** | Email/Password & Google Sign-In via Firebase Auth |
| 📅 **Event Creation** | Create events with title, description, category, date, time & location |
| 🗺️ **Interactive Map** | Pick event locations on a live map using `flutter_map` |
| 📍 **Geolocation** | Auto-detect user's current location with `geolocator` |
| ❤️ **Favourites** | Mark events as favourite and view them in a dedicated tab |
| 🧭 **Navigation** | Open real turn-by-turn Google Maps directions for any event |
| 🌙 **Dark / Light Mode** | Persistent theme switching saved via `shared_preferences` |
| 🌐 **Multi-language** | Full Arabic & English localisation with RTL support |
| 🔥 **Real-time Sync** | Live Firestore listeners update events instantly across the app |
| 📲 **Splash Screen** | Native splash screen for Android & iOS |
| 🎨 **Custom UI** | Custom widgets — elevated buttons, text fields, dialogs, tab items |
| 🔄 **Onboarding** | Beautiful multi-step introduction screen for new users |

---

## 📸 Screenshots

### 🔐 Auth Screens

<div align="center">

| Login | Register |
|:-----:|:--------:|
| <img src="screenshots/screen_login.png" width="220"/> | <img src="screenshots/screen_register.png" width="220"/> |

</div>

---

### 🏠 Home & Events

<div align="center">

| Home Screen | Create Event | Create Event + Location |
|:-----------:|:------------:|:-----------------------:|
| <img src="screenshots/screen_home.png" width="200"/> | <img src="screenshots/screen_create_event_1.png" width="200"/> | <img src="screenshots/screen_create_event_2.png" width="200"/> |

</div>

---

### 🗺️ Map & Navigation

<div align="center">

| Location Picker | Map Tab (Events + Route) | Google Maps Navigation |
|:---------------:|:------------------------:|:----------------------:|
| <img src="screenshots/screen_map_picker.png" width="200"/> | <img src="screenshots/screen_map_tab.png" width="200"/> | <img src="screenshots/screen_google_maps_nav.png" width="200"/> |

</div>

---

### ❤️ Favourites, Details & Profile

<div align="center">

| Event Details | Favourites | Profile (Dark + Arabic) |
|:-------------:|:----------:|:-----------------------:|
| <img src="screenshots/screen_event_details.png" width="200"/> | <img src="screenshots/screen_favourites.png" width="200"/> | <img src="screenshots/screen_profile_dark.png" width="200"/> |

</div>

---

## 🎬 Demo

> 📺 Watch the full app walkthrough here:

[![Demo Video](https://img.shields.io/badge/▶%20Watch%20Demo-YouTube-red?style=for-the-badge&logo=youtube)](https://[PASTE_VIDEO_LINK_HERE])

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.x / Dart 3.x |
| **Backend** | Firebase Firestore, Firebase Auth |
| **State Management** | Provider (`ChangeNotifier`) |
| **Maps** | flutter_map + latlong2 |
| **Location** | geolocator + geocoding + permission_handler |
| **Localisation** | flutter_localizations + intl |
| **Storage** | shared_preferences |
| **Navigation** | url_launcher (Google Maps deep link) |
| **UI / Icons** | google_fonts, icons_plus, animated_bottom_navigation_bar |
| **Splash Screen** | flutter_native_splash |
| **Onboarding** | introduction_screen |
| **Auth (Social)** | google_sign_in |

---

## 🏗 Architecture / State Management

Evently follows **MVVM + Clean Architecture** principles with **Provider** as the state management solution.

```
┌─────────────────────────────────────────────────────────┐
│                        UI Layer                         │
│   Screens → Widgets → listen to Providers via context   │
└───────────────────────────┬─────────────────────────────┘
                            │  notifyListeners()
┌───────────────────────────▼─────────────────────────────┐
│                   Providers (ViewModels)                 │
│  AppThemeProvider · AppLanguageProviders                │
│  MyUsersProvider · LocationProvider · EventListProvider │
└───────────────────────────┬─────────────────────────────┘
                            │  Firestore / Device APIs
┌───────────────────────────▼─────────────────────────────┐
│              Data Layer (FireBaseUtils)                  │
│     Cloud Firestore · Firebase Auth · Geolocator        │
└─────────────────────────────────────────────────────────┘
```

### Provider Responsibilities

| Provider | Responsibility |
|----------|---------------|
| `AppThemeProvider` | Manages dark/light theme; persists via SharedPreferences |
| `AppLanguageProviders` | Manages AR/EN locale; persists via SharedPreferences |
| `MyUsersProvider` | Holds the currently logged-in user model |
| `LocationProvider` | Handles GPS location, event address, and navigation URLs |
| `EventListProvider` | Real-time Firestore stream of user's events |

---

## 📁 Folder Structure

```
lib/
├── auth/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   └── reset_pass_screen.dart
│
├── firebase/
│   └── fire_base_utils.dart          # All Firestore & Auth helpers
│
├── l10n/                             # Localisation ARB files (en / ar)
│
├── location picker/
│   └── location_picker.dart          # Map-based location selection
│
├── model/
│   ├── event.dart
│   └── my_users.dart
│
├── providers/
│   ├── app_language_providers.dart
│   ├── app_theme_provider.dart
│   ├── event_list_provider.dart      # Real-time Firestore listener
│   ├── location_provider.dart
│   └── my_users_provider.dart
│
├── ui/
│   ├── add_event_screen/
│   │   └── add_event_screen.dart
│   ├── intro_screen/
│   │   ├── first_page_screen.dart
│   │   └── intro_screen.dart
│   ├── tabs/
│   │   ├── home_screen/             # Event list + details + edit
│   │   ├── Love_tab/                # Favourites tab
│   │   ├── map_tab/                 # Map tab with event pins
│   │   └── profile_tab/             # User profile
│   └── widget/                      # Reusable custom widgets
│
├── utlis/
│   ├── app_assets.dart
│   ├── app_colors.dart
│   ├── app_routes.dart
│   ├── app_text.dart
│   └── app_theme.dart
│
├── firebase_options.dart
└── main.dart

screenshots/                          # App screenshots for README
```

---

## ⚙️ Installation

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) `>=3.8.1`
- [Dart SDK](https://dart.dev/get-dart) `>=3.0.0`
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- A Firebase project configured for Android & iOS

### 1. Clone the Repository

```bash
git clone https://github.com/ahmedmostafa361/Eventely_app.git
cd Eventely_app
git checkout develop
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

> The project uses **FlutterFire CLI**. To connect your own Firebase project:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Or use the existing `firebase_options.dart` already configured for the demo project.

### 4. Android Network Security (HTTP Map Tiles)

Add the following to `android/app/src/main/AndroidManifest.xml`:

```xml
<application
  android:usesCleartextTraffic="true"
  ...>
```

### 5. Generate Splash Screen

```bash
dart run flutter_native_splash:create
```

---

## 🚀 How to Run

```bash
# Run on a connected device or emulator
flutter run

# Run in release mode
flutter run --release

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

---

## 📦 Dependencies Used

```yaml
# UI & Design
google_fonts: ^6.3.1
icons_plus: ^5.0.0
animated_bottom_navigation_bar: ^1.4.0
introduction_screen: ^4.0.0
flutter_native_splash: ^2.4.6

# State Management
provider: ^6.1.5+1

# Firebase
firebase_core: ^4.1.1
firebase_auth: ^6.1.0
cloud_firestore: ^6.0.2

# Authentication
google_sign_in: ^6.2.1

# Maps & Location
flutter_map: ^7.0.1
latlong2: ^0.9.1
geolocator: ^13.0.0
geocoding: ^3.0.0
permission_handler: ^11.3.1

# Utilities
shared_preferences: ^2.5.3
url_launcher: ^6.2.6
intl: any
fluttertoast: ^9.0.0
```

---

## 🔗 API / Backend Integration

Evently integrates with **Google Firebase** for all backend needs:

| Service | Usage |
|---------|-------|
| **Firebase Auth** | Email/password login, Google Sign-In, password reset |
| **Cloud Firestore** | Real-time storage for users and events (NoSQL) |
| **Firestore Security Rules** | Per-user data isolation (events stored under `users/{uid}/events`) |

The `FireBaseUtils` class centralises all database operations:

```dart
// Real-time event stream
FireBaseUtils.getEventCollection(userId)
  .orderBy('eventDataTime')
  .snapshots()
  .listen((snapshot) { ... });
```

---

## 🎨 Responsive Design & Animations

- **Responsive sizing** — all padding and dimensions use `MediaQuery` proportional values for consistent layout across all screen sizes
- **Animated Bottom Navigation** — smooth tab switching with notch FAB using `animated_bottom_navigation_bar`
- **Dark / Light Theme** — full `ThemeData` switching with custom `AppTheme` for both modes
- **RTL Support** — full Arabic right-to-left layout via `flutter_localizations`
- **Native Splash** — platform-native splash screen with dark mode variant
- **Google Maps Integration** — deep-link navigation opens real turn-by-turn directions in Google Maps

---

## 🔮 Future Improvements

- [ ] 🔔 **Push Notifications** — remind users of upcoming events via Firebase Cloud Messaging
- [ ] 👥 **Social Events** — invite friends and share events via deep links
- [ ] 🔍 **Advanced Search** — filter events by category, date range, or distance
- [ ] 📊 **Analytics Dashboard** — track event engagement using Firebase Analytics
- [ ] 🗓️ **Calendar Integration** — sync events to device calendar
- [ ] 📷 **Image Upload** — custom event cover photos via Firebase Storage
- [ ] ⭐ **Ratings & Reviews** — allow attendees to rate events
- [ ] 🌍 **Public Events Feed** — discover events from other users nearby

---

## 👨‍💻 Author

<div align="center">

<img src="https://avatars.githubusercontent.com/ahmedmostafa361" width="100" style="border-radius:50%"/>

### Ahmed Mostafa

**Junior Flutter Developer** | Content Creator 📱

*Building mobile apps with Flutter & Firebase · Sharing knowledge on YouTube & TikTok*

[![GitHub](https://img.shields.io/badge/GitHub-ahmedmostafa361-181717?style=for-the-badge&logo=github)](https://github.com/ahmedmostafa361)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Ahmed%20Mostafa-0A66C2?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/ahmedmostafa361)

</div>

---

## 🤝 Contributing

Contributions are welcome! Here's how to get started:

```bash
# 1. Fork the repo
# 2. Create your feature branch
git checkout -b feature/amazing-feature

# 3. Commit your changes
git commit -m "feat: add amazing feature"

# 4. Push to the branch
git push origin feature/amazing-feature

# 5. Open a Pull Request
```

---

## ⭐ Support

If you found this project useful, please consider giving it a **⭐ star** on GitHub!

[![Star on GitHub](https://img.shields.io/github/stars/ahmedmostafa361/Eventely_app?style=social)](https://github.com/ahmedmostafa361/Eventely_app)

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

```
MIT License — Copyright (c) 2025 Ahmed Mostafa
```

---

<div align="center">

Made with ❤️ and ☕ by **Ahmed Mostafa**

*Flutter Developer · Cairo, Egypt 🇪🇬*

</div>
