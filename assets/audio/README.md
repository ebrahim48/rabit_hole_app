# Audio Files Setup

## প্রয়োজনীয় অডিও ফাইলসমূহ

আপনার গেমের জন্য নিচের অডিও ফাইলগুলো `assets/audio/` ফোল্ডারে যোগ করুন:

### 1. Background Music (ব্যাকগ্রাউন্ড মিউজিক)
- **ফাইলের নাম**: `background_music.mp3`
- **সময়**: ২-৩ মিনিটের লুপিং মিউজিক
- **ধরণ**: শান্ত, গেমের পরিবেশের উপযোগী
- **উদাহরণ**: [Free looping background music](https://opengameart.org/content/search?keys=looping+background+music)

### 2. Collect Carrot Sound (ক্যারট সংগ্রহের শব্দ)
- **ফাইলের নাম**: `collect_carrot.mp3`
- **সময়**: ০.৩-০.৫ সেকেন্ড
- **ধরণ**: চিপটিউন/পজিটিভ সাউন্ড
- **উদাহরণ**: [Coin collect sound](https://opengameart.org/content/search?keys=coin+collect)

### 3. Hit Obstacle Sound (বাধায় ধাক্কার শব্দ)
- **ফাইলের নাম**: `hit_obstacle.mp3`
- **সময়**: ০.৫-১ সেকেন্ড
- **ধরণ**: ইমপ্যাক্ট/ক্র্যাশ সাউন্ড
- **উদাহরণ**: [Hit impact sound](https://opengameart.org/content/search?keys=hit+impact)

### 4. Power Up Sound (পাওয়ার আপ সংগ্রহের শব্দ)
- **ফাইলের নাম**: `power_up.mp3`
- **সময়**: ০.৫-১ সেকেন্ড
- **ধরণ**: পাওয়ার আপ/আপগ্রেড সাউন্ড
- **উদাহরণ**: [Power up sound](https://opengameart.org/content/search?keys=power+up)

## ফ্রি অডিও রিসোর্স

নিচের ওয়েবসাইটগুলো থেকে আপনি ফ্রি অডিও ফাইল পেতে পারেন:

1. **OpenGameArt.org** - https://opengameart.org/
2. **Freesound.org** - https://freesound.org/
3. **Kenney.nl** - https://kenney.nl/sounds
4. **Itch.io Game Assets** - https://itch.io/game-assets/free/tag-audio

## কিভাবে অডিও ফাইল যোগ করবেন

### ধাপ ১: অডিও ফাইল ডাউনলোড
উপরের সাইটগুলো থেকে অডিও ফাইল ডাউনলোড করুন

### ধাপ ২: MP3 ফরম্যাটে কনভার্ট
যদি অডিও ফাইল MP3 না হয়, তবে কনভার্ট করুন:
- Online: https://cloudconvert.com/
- Software: Audacity, VLC Media Player

### ধাপ ৩: ফাইলগুলো যোগ করুন
অডিও ফাইলগুলো এই ফোল্ডারে কপি করুন:
```
C:\Users\ebu\StudioProjects\rabbit_hole_app\assets\audio\
```

### ধাপ ৪: Flutter প্রজেক্ট আপডেট
```bash
cd C:\Users\ebu\StudioProjects\rabbit_hole_app
fvm flutter pub get
fvm flutter run
```

## টেস্টিং

১. অ্যাপ চালু করুন
২. Settings এ যান
৩. Sound Effects এবং Background Music অন করুন
৪. Volume স্লাইডার মিডিয়ামে সেট করুন
৫. Start Game এ ক্লিক করুন
৬. গেম খেলার সময় মিউজিক এবং সাউন্ড এফেক্টস শোনা যাচ্ছে কিনা চেক করুন

## সমস্যা সমাধান

### যদি সাউন্ড না শোনা যায়:
- ডিভাইসের ভলিউম চেক করুন
- Settings এ সাউন্ড অন আছে কিনা চেক করুন
- অডিও ফাইলগুলো সঠিক ফোল্ডারে আছে কিনা চেক করুন
- অ্যাপ রিস্টার্ট দিন

### যদি মিউজিক লুপ না হয়:
- অডিও ফাইলটি সঠিকভাবে লুপ করার জন্য তৈরি কিনা চেক করুন
- অ্যাপ লজিক ঠিক আছে (ReleaseMode.loop সেট করা আছে)

### যদি হ্যাপটিক কাজ না করে:
- Settings এ Haptic Feedback অন আছে কিনা চেক করুন
- ইমুলেটরে হ্যাপটিক কাজ করে না, ফিজিক্যাল ডিভাইসে টেস্ট করুন

## নোট

- অডিও ফাইলগুলোর সাইজ ছোট রাখার চেষ্টা করুন (১০০ KB এর নিচে)
- ব্যাকগ্রাউন্ড মিউজিকের জন্য লুপিং অডিও ব্যবহার করুন
- সাউন্ড এফেক্টসের জন্য ছোট ক্লিপ ব্যবহার করুন
