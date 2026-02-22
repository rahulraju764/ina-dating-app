# 💘 Spark — Dating App

**Spark** is a mobile-first dating application built with Flutter and powered by Firebase, designed to help people find meaningful relationships based on shared interests and proximity. The app provides an intuitive, swipe-based discovery experience combined with rich communication tools — including private chat, video/audio calls, and digital gift sending — to guide users from first match to real connection.

## 🚀 Tech Stack & Architecture

### Mobile App (Flutter)
The mobile app is built in Flutter (Dart) and strictly follows **Clean Architecture**:
* **Presentation**: UI, routing, theme, and state management via **Riverpod**.
* **Domain**: Pure business logic containing Entities, generic Interfaces, and Use Cases with a single `call()` method.
* **Data**: Firebase Models, Repositories, and specific Remote Datasources (Firestore, Storage, FCM).

### Backend (Firebase)
* **Auth**: Email, Google, Apple, and Phone Sign-in.
* **Database**: Cloud Firestore. Security Rules are strictly applied – users read/write only their own document, and chat access requires being a participant.
* **File Storage**: Firebase Storage for Profile Photos and Media, with 2MB limits and server-side generated thumbnails via Cloud Functions.
* **Push Notifications**: Firebase Cloud Messaging (FCM).
* **Cloud Functions**: Written in TypeScript, handling Match logic (e.g., idempotent `onSwipe`), Notifications, Match Expiry (via Scheduler), Subscription validations, and Automoderation integrations (Cloud Vision API).

### Admin Panel
The Admin Panel will be constructed using either **Laravel (PHP)** or **Next.js (React)**, focusing on user management, subscription tracking, and moderating flagged images/chats.

### External Services
* **Calls**: Agora.io or WebRTC.
* **Subscriptions & Payments**: RevenueCat (alongside Stripe + App Store / Play Store natively).
* **Location Service**: Geoflutterfire and Firestore GeoHash for performant proximity-based matching.

## ✨ Core Features

1. **Swipe to Send Request**: Intuitive discovery experience. Swipe right to like, left to pass, or use a Super Like to stand out. Validations are enforced by Firebase Functions against Daily Limits (Free Tier) or Premium Status.
2. **Rich User Profiles**: Setup a profile with up to 6 photos, a bio, tags, relationship goals, and matching parameters.
3. **Location-Based Matching**: Discover compatible profiles nearby using distance search and GeoHash queries.
4. **Private Chat**: Real-time messaging with text, images, stickers, and read receipts between matched users.
5. **Video & Audio Calls**: Initiate encrypted voice or video calls directly from the chat screen to build deeper connections before meeting up.
6. **Push Notifications**: Stay instantly updated about new matches, messages, gifts, or when active users enter your proximity.
7. **Digital Gifts & Products**: Express interest creatively by sending animated stickers, virtual roses, and digital gifts. This heavily utilizes in-app currency ("Sparks").
8. **In-App Purchases & Subscriptions**: Flexible tiers (Free, Gold, Platinum) unlocking features like unlimited swipes, rewinds, and profile boosts via RevenueCat.
9. **Matched profiles List**: Organized view of all your mutual matches highlighting new matches and unread messages. Automatic expiry runs for matches with 0 messages inside 7 Days.
10. **Image Upload & Gallery**: Built-in photo moderation ensures a safe platform environment.

## 🛡️ Privacy & Security

Spark prioritizes user safety and data privacy:
* **Location Privacy**: Exact GPS coordinates are never exposed; only approximate distance is shared.
* **Moderation**: State-of-the-art automated (Google Cloud Vision) and manual moderation for photos and profiles.
* **Firestore Rules**: Acts as the ultimate validator of requests; users cannot execute restricted reads on other chats or impersonate writes.
* **Control**: Users have full control over unmatching, reporting, and erasing their personal data.
* **Compliance**: Adherence to GDPR, CCPA, and COPPA (strict 18+ age requirement).

## 🧰 Development Commands

Relevant commands for configuring and testing the environment:

### Flutter (Mobile)
```bash
flutter pub get
flutter run --dart-define=AGORA_APP_ID=YOUR_ID --dart-define=RC_API_KEY=YOUR_KEY
flutter test --coverage  # Ensure Domain & Repository tests pass (90%+ Target)
```

### Firebase Functions
```bash
cd functions
npm install
firebase emulators:start # Run emulator suite
npm test                 # Run Jest tests (Especially for onSwipe and expireMatches)
firebase deploy --only functions
```

---
*For complete specifications, feature data schemas, and non-functional requirements, please refer to the detailed [PRD.md](PRD.md).*
*For agent guidelines, testing standards, and codebase rules, review [AGENT.md](AGENT.md).*
