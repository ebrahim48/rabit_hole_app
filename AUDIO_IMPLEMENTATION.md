# Audio, Music & Haptic Feedback Implementation

## Overview
This document explains the complete implementation of audio settings, background music, sound effects, and haptic feedback for the Rabbit Hole App.

## Features Implemented

### 1. Settings Screen Controls
- **Sound Effects Toggle**: Enable/disable game sound effects
- **Sound Effects Volume Slider**: Adjust volume (0-100%)
- **Background Music Toggle**: Enable/disable background music
- **Background Music Volume Slider**: Adjust music volume (0-100%)
- **Haptic Feedback Toggle**: Enable/disable vibration
- **Haptic Feedback Intensity Slider**: Adjust vibration sensitivity (0-100%)

### 2. In-Game Audio Features
- **Background Music**: Plays during gameplay, loops continuously
- **Collect Carrot Sound**: Plays when collecting carrots or extra lives
- **Power-up Sound**: Plays when collecting power-ups
- **Hit Obstacle Sound**: Plays when hitting obstacles
- **Haptic Feedback**: Vibrates on collisions (configurable intensity)

## File Structure

### New Files Created
```
lib/core/helpers/
├── settings_helper.dart      # Persistent storage for settings
└── audio_service.dart        # Audio playback management

assets/
└── audio/                    # Audio files folder
    ├── background_music.mp3
    ├── collect_carrot.mp3
    ├── hit_obstacle.mp3
    └── power_up.mp3
```

### Updated Files
```
lib/
├── main.dart                              # Settings initialization
├── core/app_constants/app_constants.dart  # Settings keys
├── core/helpers/prefs_helper.dart         # Added double support
├── controllers/settings_controller.dart   # Settings management
├── presentations/screens/settings/settings_screen.dart
├── presentations/screens/home/game/rabbit_game.dart
├── presentations/screens/home/game/game_screen_view.dart
├── presentations/widgets/
│   ├── custom_slider.dart                 # Sound effects volume
│   ├── custom_music_slider.dart           # Background music volume
│   └── custom_haptic_feedback_slider.dart # Haptic intensity
└── pubspec.yaml                           # Added audioplayers dependency
```

## How It Works

### 1. Settings Persistence
All settings are saved using `SharedPreferences`:
- Sound Effects: `soundEffects` (bool), `soundEffectsVolume` (double)
- Background Music: `backgroundMusic` (bool), `backgroundMusicVolume` (double)
- Haptic Feedback: `hapticFeedback` (bool), `hapticFeedbackIntensity` (double)

### 2. Audio Service
The `AudioService` is a GetX controller that manages:
- Background music playback with looping
- Sound effect playback
- Volume control for music and SFX
- Respects user settings (won't play if disabled)

### 3. Game Integration
When the game starts:
1. `AudioService` is initialized
2. Background music starts playing
3. On collect/hit events:
   - Corresponding sound effect plays
   - Haptic feedback triggers (if enabled)
4. When game ends, music stops

## Setup Instructions

### 1. Add Audio Files
Place the following MP3 files in `assets/audio/`:

- `background_music.mp3` - Looping background music (2-3 minutes)
- `collect_carrot.mp3` - Short pleasant sound (0.5 seconds)
- `hit_obstacle.mp3` - Impact/crash sound (0.5-1 seconds)
- `power_up.mp3` - Power-up collection sound (1 second)

### 2. Run Flutter Commands
```bash
cd C:\Users\ebu\StudioProjects\rabbit_hole_app
fvm flutter pub get
fvm flutter run
```

### 3. Test the Features
1. Open the app and go to **Settings**
2. Toggle sound/music/haptic settings
3. Adjust volume sliders
4. Start a game and verify:
   - Background music plays
   - Sound effects play on collect/hit
   - Phone vibrates on collisions

## Code Usage

### In Settings Screen
```dart
// Get the controller
final SettingsController controller = Get.find<SettingsController>();

// Toggle sound effects
controller.setSoundEffects(true/false);

// Set volume (0.0 to 1.0)
controller.setSoundEffectsVolume(0.5);
controller.setBackgroundMusicVolume(0.8);

// Toggle haptic
controller.setHapticFeedback(true/false);
```

### In Game
```dart
// Audio service is auto-initialized in RabbitGame
// Sounds are triggered automatically on game events:
- collectCarrot() → plays collect sound
- collectPower() → plays power-up sound
- hitObstacle() → plays hit sound + haptic feedback
```

## Troubleshooting

### No Sound Playing
1. Check if audio files exist in `assets/audio/`
2. Verify `pubspec.yaml` includes `- assets/audio/`
3. Check device volume is not muted
4. Verify settings have sound enabled

### Music Not Looping
- The `AudioService` handles looping automatically
- Check if `backgroundMusic` setting is enabled

### Haptic Not Working
1. Check device haptic settings
2. Verify `hapticFeedback` setting is enabled in app
3. Note: Haptic only works on physical devices (not emulator)

## Notes
- All settings persist across app restarts
- Default values: All enabled at 83% volume/intensity
- AudioService is a singleton accessible via `Get.find<AudioService>()`
- Music automatically stops when leaving game screen
