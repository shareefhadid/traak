# Traak

A Flutter application for tracking sprint workout routines and performance.

## Features

- **Track Workouts**: Create and manage your sprint training routines
- **View History**: Review past workout details and completed exercises
- **Insights**: View analytics about your sprint performance and progress

## Getting Started

### Prerequisites

- Flutter 3.0.0 or higher
- Dart 2.17.0 or higher

### Installation

1. Clone the repository

   ```
   git clone https://github.com/yourusername/traak.git
   ```

2. Install dependencies

   ```
   flutter pub get
   ```

3. Run the app
   ```
   flutter run
   ```

## Project Structure

The project follows a feature-first architecture:

```
lib/
├── app.dart              # Main app configuration
├── main.dart             # Entry point
├── router.dart           # Routing configuration
├── theme.dart            # App theme
├── constants/            # App constants
├── features/             # Feature modules
│   ├── track/            # Workout tracking feature
│   ├── history/          # Workout history feature
│   └── insights/         # Performance insights feature
├── services/             # App-wide services
└── shared/               # Shared components
```

## Technologies

- **Flutter**: UI framework
- **Isar**: Local database
- **go_router**: Navigation

## Development

### Adding a New Feature

1. Create a new directory under `lib/features/`
2. Follow the established architecture pattern:
   - screens: UI pages
   - components: Reusable UI components
   - models: Data models
   - repositories: Data access
   - view_models: Business logic

### Adding a New Route

Add your route in `lib/router.dart` following the existing pattern.

## Isar Database

### Code Generation

After creating or modifying Isar model classes:

1. Make sure your model class has the proper Isar annotations:

   ```dart
   @collection
   class YourModel {
     Id id = Isar.autoIncrement;
     // Your model properties
   }
   ```

2. Run the Isar generator:

   ```
   dart run build_runner build --delete-conflicting-outputs
   ```

3. For continuous generation during development:
   ```
   dart run build_runner build watch
   ```

## Publishing to TestFlight

To publish the iOS version to TestFlight for testing:

1. Update the version and build number in `pubspec.yaml`
   ```yaml
   version: 1.0.0+1  # Format is version_number+build_number
   ```

2. Build the iOS app in release mode
   ```
   flutter build ios --release
   ```

3. Ensure you have the latest code with all dependencies updated
   ```
   flutter pub get
   ```

4. Open the iOS project in Xcode
   ```
   open ios/Runner.xcworkspace
   ```

5. In Xcode, select **Product** > **Archive** from the top menu
   - Make sure you have selected a proper team in the Signing & Capabilities section
   - Ensure the build is set to "Release" not "Debug"

6. Once the archive process completes, the Xcode Organizer window will open
   - If it doesn't open automatically, go to **Window** > **Organizer**

7. Select the archive you just created and click **Distribute App**

8. Choose **App Store Connect** as the distribution method and click **Next**

9. Select **Upload** to upload the build to App Store Connect and click **Next**

10. Choose distribution options (typically the defaults are fine) and continue through the remaining prompts

11. After the upload completes successfully, log in to [App Store Connect](https://appstoreconnect.apple.com/)

12. Navigate to your app > TestFlight and wait for the build to finish processing
    - This typically takes 15-30 minutes
    - Once processed, you can add test users and distribute the build
