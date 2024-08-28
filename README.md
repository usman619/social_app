# social_app

A text-based social media application built using Flutter and Firebase. This app allows users to post updates, like, comment on posts, and manage their profiles, including the ability to delete their account along with all associated data.

## Feature

### User Authentication:

- Sign up and log in using email and password.
- Password recovery via email. (will be added later)

### Profile Management:

- Edit profile information.
- Delete account along with all associated likes, comments, and posts.

### Posts:

- Create and share text-based posts.
- Like and comment on posts.
- View and manage user’s own posts.

### Real-time Updates:

- Real-time updates for posts, likes, and comments.

### Responsive Design:

- Optimized for both Android and iOS devices.

### Features to be added:

- Email Verification
- Add images/videos in Posts
- Messages between users

## File Structure

```bash
assets/
│
├── screenshots/           # UI Screenshots
└── icon/                  # App Icon
lib/
│
├── components/             # Reusable widgets and UI componets from Text Fields to Posts Container
├── helper/                 # Firebase service classes
├── models/                 # Data models for the application
├── pages/                  # UI screens for the application
├── services/               # Firebase service classes (auth_service and database_service)
│       │
│       ├── auth/           # Firebase Authentication Service
│       └── database/       # Database Service and Database Provider
├── themes/                 # Themes Provider and text themes
└── main.dart               # Main entry point of the application
```

## UI Screens

<img src="assets/screenshots/Social_App_UI.png" alt="UI">

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/) installed on your machine.
- Create a [Firebase](https://firebase.google.com/) project and turn on Email/Password from the Authentication section in the Sign-in method.

### Packages used

- ![provider](https://pub.dev/packages/provider)
- ![firebase_core](https://pub.dev/packages/firebase_core)
- ![cloud_firestore](https://pub.dev/packages/cloud_firestore)
- ![google_fonts](https://pub.dev/packages/google_fonts)
- ![intl](https://pub.dev/packages/intl)
- ![flutter_svg](https://pub.dev/packages/flutter_svg)
- ![flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/usman619/social_app.git
cd social_app
```

2. Install the dependencies:

```bash
flutter pub get
```

3. Login into Firebase Console through CLI and select the project you have created before:

```bash
firebase login
flutter pub global activate flutterfirebase_cli
flutterfire config
< Select the project that you have created in Firebase Console >
flutter pub global deactivate flutterfirebase_cli
```

4. Run using the following command:

```bash
flutter run
```
