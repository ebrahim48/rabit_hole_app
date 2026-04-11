# Rabbit Hole — Carrot Chase Runner Game

A Flutter-based 2D arcade mobile game where a rabbit falls down a hole, collecting carrots and dodging obstacles. Compete on global leaderboards, unlock skins, and earn power-ups in this endless vertical runner.

---

## Features

### Gameplay
- **Carrot Chase** — Control a rabbit falling vertically through an endless hole, collecting carrots and avoiding obstacles.
- **Progressive Difficulty** — Speed increases over time; distance is tracked in feet as your score.
- **Collision Detection** — Powered by Flame's built-in collision system for responsive hit detection.
- **Power-Ups** — Activate timed power-ups mid-game to gain advantages.
- **Game Over Screen** — Displays final score, carrots collected, and options to retry or exit.
- **Countdown & HUD** — In-game countdown widget and heads-up display showing live stats.

### Leaderboard
- **Global Rankings** — See the top players worldwide.
- **Today's Rankings** — Daily leaderboard refreshed each day.
- **Personal Best** — Track your highest score and carrot count.

### Shop
- **Carrot Packages** — Purchase carrot bundles via In-App Purchase (USD pricing).
- **Rabbit Skins** — Unlock and equip different rabbit character skins.
- **Power-Ups** — Buy timed power-up items to use during gameplay.
- **Share to Earn** — Share the app via social platforms to earn a free skin.
- **Watch Ads to Earn** — Watch rewarded ads to earn 20 free carrots (2 ads per session).

### Profile
- **Gaming Dashboard** — View your total distance, carrots collected, high score, and achievements.
- **Badges & Achievements** — Unlock achievement badges based on milestones reached.
- **Profile Image** — Upload and update your avatar via camera or gallery.
- **Edit Profile** — Update display name and account details.

### Settings
- **Background Music** — Toggle and adjust volume of in-game background music.
- **Sound Effects** — Toggle hit, carrot-collect, and power-up sound effects independently.
- **Haptic Feedback** — Toggle and adjust vibration intensity.
- **Change Password** — Update your account password from within the app.
- **Static Pages** — Privacy Policy, Terms & Conditions, About Us, and Contact Us fetched from the server.

### Authentication
- **Sign Up** — Register with email and password; profile image upload supported (multipart).
- **OTP Verification** — Verify your account via a one-time PIN sent to your email.
- **Sign In** — Email and password login returning a Bearer access token.
- **Forgot Password** — Initiate a password reset flow via email.
- **Reset Password** — Set a new password using the OTP verification step.
- **Resend OTP** — Request a new OTP if the previous one expired.

---

## Tech Stack

| Layer              | Technology                              |
|--------------------|-----------------------------------------|
| Framework          | Flutter (Dart) `^3.7.0`                 |
| Game Engine        | Flame `^1.17.0` + flame_svg `^1.8.0`   |
| State Management   | GetX `^4.6.6`                           |
| Navigation         | GoRouter                                |
| Local Storage      | SharedPreferences `^2.5.3`             |
| Audio              | audioplayers `^6.4.0`                   |
| In-App Purchase    | in_app_purchase `^3.2.3`               |
| Responsive UI      | flutter_screenutil `^5.9.3` (393×852)  |
| Image Loading      | cached_network_image `^3.4.1`           |
| Animations         | Lottie, flutter_staggered_animations    |
| Image Picker       | image_picker `^1.1.2` + file_picker    |
| OTP Input          | pin_code_fields `^8.0.1`               |
| Haptic Feedback    | haptic_feedback `^0.5.1+1`             |
| Social Sharing     | share_plus `^10.0.0`                   |
| HTML Rendering     | flutter_html `^3.0.0-beta.2`           |
| Network Check      | internet_connection_checker_plus        |
| Asset Generation   | flutter_gen_runner (type-safe assets)  |

---

## Platform Support

| Platform | Support                        |
|----------|--------------------------------|
| Android  | Full support                   |
| iOS      | Full support                   |
| Windows  | Supported (desktop)            |
| macOS    | Supported (desktop)            |
| Linux    | Supported (desktop)            |

> In-App Purchase and rewarded ads functionality may require additional platform-specific configuration on iOS and desktop.

---

## Getting Started

### Prerequisites
- Flutter SDK `^3.7.0`
- Android Studio or VS Code
- Android device or emulator (API 21+) / iOS device or simulator

### Installation

```bash
# Clone the repository
git clone <repo-url>
cd rabbit_hole_app

# Install dependencies
flutter pub get

# Generate type-safe assets
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### App Icon Generation

```bash
flutter pub run flutter_launcher_icons
```

---

## Backend API

| Detail          | Value                                 |
|-----------------|---------------------------------------|
| Base URL        | `https://api.rhrunnerapp.com/api/v1`  |
| Image Base URL  | `https://api.rhrunnerapp.com/`        |
| Auth            | Bearer token (stored in SharedPreferences) |
| Timeout         | 20 seconds                            |
| Response Format | `{ "data": { "attributes": { ... } }, "message": "..." }` |

### Key Endpoints

**Auth**
- `POST /auth/register` — Multipart registration with profile image
- `POST /auth/login` — Returns access token
- `POST /auth/verify-email` — OTP verification
- `POST /auth/forgot-password` / `POST /auth/reset-password`
- `POST /auth/resend-otp` / `POST /auth/refresh-token`
- `POST /auth/change-password`

**Gaming**
- `GET /gaming-dashboard` — Fetch user game stats
- `POST /gaming-dashboard` — Create dashboard (first game)
- `PATCH /gaming-dashboard` — Update stats after each game
- `GET /gaming-dashboard/leaderboard` — Global & today rankings
- `POST /gaming-dashboard/share-and-get-skin`
- `POST /gaming-dashboard/watch-ads-and-get-carrots`

**Shop**
- `GET /package` — Carrot packages with USD pricing
- `GET /content?category=skin` — Available rabbit skins
- `GET /content?category=power-up` — Available power-ups

**User**
- `GET /user/account` — Fetch profile
- `PATCH /user/update-profile` — Multipart profile update with image

**Settings**
- `GET /settings/support-and-contact`
- `GET /settings/privacy-policy`
- `GET /settings/about-us`
- `GET /settings/terms-conditions`

---

## Project Structure

```
lib/
├── controllers/              # GetX controllers
│   ├── auth-controller.dart      # Auth flows, OTP countdown
│   ├── profile_controller.dart   # Profile fetch/update, gaming dashboard
│   ├── shop_controller.dart      # Packages, skins, power-ups
│   ├── leaderboard_controller.dart # Global/today leaderboard, personal best
│   ├── settings_controller.dart  # Audio settings, static content
│   ├── game_controller.dart      # Game session state
│   └── home_controller.dart      # Home screen state
├── models/                   # Data models
│   ├── user_profile_model.dart
│   ├── gaming_dashboard_model.dart
│   ├── leaderboard_models.dart
│   ├── content_model.dart        # Skins
│   ├── content_powerUp_model.dart
│   ├── shop_package_model.dart
│   └── contact_model.dart
├── services/                 # Network layer
│   ├── api_client.dart           # HTTP client (GET/POST/PATCH/DELETE + multipart)
│   ├── api_constants.dart        # Endpoint constants
│   ├── iap_service.dart          # In-App Purchase service
│   └── error_response.dart
├── core/
│   ├── config/
│   │   ├── app_routes/           # GoRouter declarative routes
│   │   └── app_themes/           # Light/Dark themes
│   ├── constants/
│   │   └── app_colors.dart       # AppColors palette
│   ├── helpers/
│   │   ├── audio_service.dart    # GetxService — music & SFX players
│   │   ├── settings_helper.dart  # SharedPreferences audio/haptic settings
│   │   ├── haptic_helper.dart    # Haptic feedback wrapper
│   │   ├── toast_message_helper.dart
│   │   ├── dependancy_injaction.dart # DI registration
│   │   └── time_format.dart
│   └── app_constants/
│       └── app_constants.dart    # PrefsHelper (SharedPreferences)
├── presentations/
│   ├── controller/
│   │   └── theme_controller.dart
│   ├── screens/
│   │   ├── splash/               # Splash + auth check
│   │   ├── auth/                 # SignIn, Register, Verify, Forget, Reset
│   │   ├── bottom_navbar/        # 4-tab navigation container
│   │   ├── home/
│   │   │   ├── home_screen.dart  # Main menu
│   │   │   ├── game_screen.dart  # Flame game host
│   │   │   └── game/             # Rabbit, SpawnManager, GameObjects, HUD
│   │   ├── leaderboard/
│   │   ├── shop_screen/          # Shop + In-App Purchase
│   │   ├── profile_screen/       # Profile, Edit, Update
│   │   └── settings/             # Settings, Privacy, Terms, About, Contact
│   └── widgets/                  # 25+ reusable UI components
│       ├── custom_text.dart
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       └── ...
└── global/
    └── custom_assets/            # flutter_gen type-safe asset references
        ├── assets.gen.dart
        └── fonts.gen.dart
```

---

## Navigation Flow

```
Splash Screen
    ├── [Authenticated] → Bottom Navbar (Home | Leaderboard | Shop | Profile)
    │       └── Home Tab → Game Screen (Flame engine)
    └── [Not Authenticated] → Sign In
            ├── Sign In → Bottom Navbar
            ├── Register → Verify Email → Bottom Navbar
            └── Forgot Password → Verify Email → Reset Password → Sign In
```

---

## Architecture

- **State Management:** GetX with Rx observables and `Obx()` for reactive UI rebuilds
- **Navigation:** GoRouter with named routes, `state.extra` for parameter passing, custom `SlideTransition` page transitions
- **Dependency Injection:** `DependencyInjection` class registers all controllers and services at startup
- **Game Engine:** Flame component-based architecture — `RabbitGame`, `Rabbit`, `SpawnManager`, `GameObject`; speed increases `10 * dt` per second, distance = `speed * dt * 0.1`
- **Audio:** `AudioService` (GetxService) manages background music loop and separate `AudioPlayer` instances per sound effect
- **Design Baseline:** 393×852 via `flutter_screenutil`
