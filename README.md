# CH4NGE

A cross-platform **Flutter** app that turns everyday eco-friendly habits into a game. Log green actions, earn points, take on challenges, climb the leaderboard, and explore environmental data on an interactive map.

Runs on Android, iOS, web, and desktop (Linux, macOS, Windows) from a single codebase.

## Features

- **Authentication** — sign up and sign in flows with session handling.
- **Actions** — log eco-friendly activities and track your impact.
- **Challenges & achievements** — complete challenges and unlock achievements.
- **Feed** — a social feed to share and follow activity.
- **Leaderboard** — compete with others and climb the rankings.
- **Map** — interactive map with heatmap visualization of environmental sensor data.
- **Settings** — manage your profile and app preferences.

## Tech Stack

- **Framework:** Flutter (Dart SDK `^3.6.1`)
- **State management:** [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Routing:** [go_router](https://pub.dev/packages/go_router)
- **Dependency injection:** [get_it](https://pub.dev/packages/get_it)
- **Networking:** [dio](https://pub.dev/packages/dio) / [http](https://pub.dev/packages/http)
- **Maps:** [flutter_map](https://pub.dev/packages/flutter_map), [latlong2](https://pub.dev/packages/latlong2), [flutter_map_heatmap](https://pub.dev/packages/flutter_map_heatmap)
- **Location:** [geolocator](https://pub.dev/packages/geolocator), [location](https://pub.dev/packages/location)
- **Storage:** [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Config:** [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) (`.env.dev` / `.env.prod`)
- **Other:** flutter_screenutil, image_picker, share_plus, app_links, freezed, json_serializable

## Project Structure

```
lib/
├── core/            # Shared infrastructure
│   ├── api/         # API service
│   ├── auth/        # Auth manager
│   ├── network/     # Network client
│   ├── di/          # Service locator (get_it)
│   ├── shared/
│   └── utils/
├── features/
│   └── layers/
│       └── presentation/
│           └── screens/   # authentication, home, challenges,
│                          # feed, leaderboard, map, settings
└── main.dart
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart `^3.6.1` or newer)
- A configured device, emulator, or browser

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Kamal578/CH4NGE_UI.git
   cd CH4NGE_UI
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Create the environment files in the project root (they are required but not committed):

   `.env.dev`
   ```env
   BASE_URL=https://your-dev-api-url
   # add any other required keys
   ```

   `.env.prod`
   ```env
   BASE_URL=https://your-prod-api-url
   ```

4. Generate code for freezed / json_serializable models:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. Run the app:
   ```bash
   flutter run
   ```

The app loads `.env.dev` in debug mode and `.env.prod` in release builds.

## Build

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
flutter build macos      # macOS
flutter build windows    # Windows
flutter build linux      # Linux
```

## Author

**Kamal Ahmadov** ([@Kamal578](https://github.com/Kamal578))
