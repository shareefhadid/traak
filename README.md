# Traak

A Flutter application for tracking sprint workout routines and performance.

## Features

- **Track Workouts**: Create and manage your sprint training routines
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
