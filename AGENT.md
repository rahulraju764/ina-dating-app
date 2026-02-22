# AGENT.md — Spark Dating App

> This file provides guidance for AI coding agents (e.g., Claude, Copilot, Cursor) working on the **Spark** dating app codebase. Read this before making any changes.

---

## Project Identity

| Field | Value |
|---|---|
| **App Name** | Spark |
| **Type** | Mobile Dating App + Admin Panel |
| **Mobile Stack** | Flutter (Dart) |
| **Backend** | Firebase (Auth · Firestore · Storage · FCM · Functions) |
| **Admin Panel** | Laravel (PHP) OR Next.js (React/TypeScript) |
| **PRD Reference** | `PRD.md` — source of truth for all feature requirements |

---

## Monorepo Structure

```
spark/
├── mobile/                         # Flutter app
│   ├── lib/
│   │   ├── main.dart
│   │   ├── app.dart                # App root, routing, theme
│   │   ├── core/
│   │   │   ├── constants/          # App-wide constants (colors, sizes, strings)
│   │   │   ├── errors/             # Failure classes, exception handlers
│   │   │   ├── router/             # GoRouter route definitions
│   │   │   ├── theme/              # ThemeData, text styles, color palette
│   │   │   └── utils/              # Date helpers, validators, formatters
│   │   ├── data/
│   │   │   ├── models/             # Dart model classes (fromJson / toJson)
│   │   │   ├── repositories/       # Repository implementations (Firebase calls)
│   │   │   └── datasources/        # Remote datasources (Firestore, Storage, FCM)
│   │   ├── domain/
│   │   │   ├── entities/           # Pure domain entities (no Firebase deps)
│   │   │   ├── repositories/       # Abstract repository interfaces
│   │   │   └── usecases/           # Business logic use cases (one action per file)
│   │   ├── presentation/
│   │   │   ├── auth/               # Login, Register, Onboarding screens
│   │   │   ├── profile/            # Profile view, profile edit
│   │   │   ├── discovery/          # Swipe card stack screen
│   │   │   ├── matches/            # Matched profiles list
│   │   │   ├── chat/               # Private chat screen
│   │   │   ├── calls/              # Video / audio call screen
│   │   │   ├── gifts/              # Gift shop, sticker picker
│   │   │   ├── purchases/          # Subscription plans, IAP screen
│   │   │   ├── notifications/      # Notification settings screen
│   │   │   └── settings/           # Account settings, privacy, delete account
│   │   └── services/
│   │       ├── firebase_service.dart
│   │       ├── notification_service.dart
│   │       ├── location_service.dart
│   │       ├── call_service.dart   # Agora / WebRTC wrapper
│   │       └── purchase_service.dart  # RevenueCat wrapper
│   ├── test/
│   │   ├── unit/
│   │   ├── widget/
│   │   └── integration/
│   ├── pubspec.yaml
│   └── firebase.json
│
├── functions/                      # Firebase Cloud Functions (Node.js / TypeScript)
│   ├── src/
│   │   ├── index.ts                # Function exports
│   │   ├── match/
│   │   │   ├── onSwipe.ts          # Match creation logic
│   │   │   └── expireMatches.ts    # Scheduled match expiry
│   │   ├── notifications/
│   │   │   ├── sendMatchNotif.ts
│   │   │   ├── sendMessageNotif.ts
│   │   │   └── sendProximityNotif.ts
│   │   ├── purchases/
│   │   │   └── verifyReceipt.ts    # Server-side IAP verification
│   │   ├── moderation/
│   │   │   └── moderateImage.ts    # Cloud Vision API integration
│   │   └── gifts/
│   │       └── processGift.ts
│   ├── package.json
│   └── tsconfig.json
│
├── admin/                          # Admin Panel
│   ├── laravel/                    # If Laravel is chosen
│   │   ├── app/
│   │   │   ├── Http/Controllers/
│   │   │   ├── Models/
│   │   │   └── Services/
│   │   ├── routes/api.php
│   │   └── ...
│   └── nextjs/                     # If Next.js is chosen
│       ├── app/
│       │   ├── (auth)/
│       │   ├── dashboard/
│       │   ├── users/
│       │   ├── moderation/
│       │   ├── subscriptions/
│       │   ├── gifts/
│       │   ├── notifications/
│       │   └── analytics/
│       ├── components/
│       ├── lib/
│       └── ...
│
├── firestore.rules                 # Firestore Security Rules
├── storage.rules                   # Firebase Storage Security Rules
├── firebase.json                   # Firebase project config
├── .firebaserc
├── PRD.md                          # Product Requirements Document ← READ FIRST
└── AGENT.md                        # This file
```

---

## Key Decisions & Conventions

### 1. Architecture — Flutter (Clean Architecture)

The Flutter app follows **Clean Architecture** with three layers:

```
Presentation  →  Domain  →  Data
(UI / State)     (Entities,  (Firebase,
                  UseCases,   Repositories)
                  Interfaces)
```

- **Never** import Firebase packages directly into `presentation/` or `domain/`.
- All Firebase calls go through `data/repositories/` and `data/datasources/`.
- Use cases in `domain/usecases/` contain **one public method** (`call()`) each.
- State management: **Riverpod** (preferred) or **BLoC** — be consistent, do not mix.

### 2. State Management

- Use **Riverpod** (`flutter_riverpod`) throughout the mobile app.
- Every feature folder under `presentation/` may have its own `*_provider.dart` or `*_notifier.dart`.
- Do not use `setState` outside of trivial local UI state (animations, focus).
- Async providers use `AsyncNotifier` / `FutureProvider` — always handle loading and error states.

### 3. Firebase Conventions

- **Firestore collection names** are always `camelCase` plural: `users`, `matches`, `chats`, `swipes`, `gifts`, `transactions`.
- **Document IDs**: use Firebase auto-generated IDs unless there is a strong reason to use a custom ID (e.g., `swipes/{fromId}_{toId}`).
- **Timestamps**: always use `FieldValue.serverTimestamp()` when writing, never client-side `DateTime.now()`.
- **Batch writes**: use `WriteBatch` for any operation that modifies more than one document atomically (e.g., creating a match updates both `swipes` and `matches`).
- **Never expose** raw Firestore `DocumentSnapshot` to the `domain` or `presentation` layers — always map to a Dart entity/model.

### 4. Security Rules Philosophy

Firestore and Storage rules are the **last line of defence**. Rules must enforce:
- A user can only **read/write their own** `users/{userId}` document.
- A user can only read a `chats/{chatId}` document if their `userId` is in `participants[]`.
- A user can only write to `swipes/{fromId}_{toId}` if `fromId == request.auth.uid`.
- Image uploads to `Storage` are restricted to authenticated users, max **2 MB**, allowed MIME types: `image/jpeg`, `image/png`, `image/webp`.

> ⚠️ **Agent Rule:** Never weaken Security Rules. If a feature requires a new data access pattern, add the minimum required permission, scoped as tightly as possible.

### 5. Cloud Functions

- All functions are written in **TypeScript**.
- Triggered functions (`onDocumentCreated`, `onDocumentUpdated`) must be **idempotent** — safe to run more than once.
- Match creation (`onSwipe.ts`) is the most critical function. Any changes require a unit test update.
- Scheduled functions (e.g., `expireMatches`) run daily via **Cloud Scheduler**.
- All functions must log errors using `functions.logger.error()`, never `console.error()`.

---

## Feature Map (PRD → Code)

| PRD Feature | Key Files / Locations |
|---|---|
| Push Notifications | `lib/services/notification_service.dart`, `functions/src/notifications/` |
| User Profile | `lib/presentation/profile/`, `lib/domain/entities/user_entity.dart`, `lib/data/models/user_model.dart` |
| Private Chat | `lib/presentation/chat/`, `lib/data/repositories/chat_repository.dart`, Firestore `chats/` collection |
| Location-Based | `lib/services/location_service.dart`, `lib/data/repositories/discovery_repository.dart`, GeoHash on `users/` |
| In-App Purchases | `lib/services/purchase_service.dart`, `lib/presentation/purchases/`, `functions/src/purchases/verifyReceipt.ts` |
| Video / Audio Call | `lib/services/call_service.dart`, `lib/presentation/calls/`, Agora SDK integration |
| Order Products / Gifts | `lib/presentation/gifts/`, `lib/data/repositories/gift_repository.dart`, `functions/src/gifts/processGift.ts` |
| Image Upload & Gallery | `lib/data/datasources/storage_datasource.dart`, Firebase Storage `users/{uid}/photos/` |
| Matched Profiles List | `lib/presentation/matches/`, `lib/data/repositories/match_repository.dart`, Firestore `matches/` |
| Swipe to Send Request | `lib/presentation/discovery/`, `lib/domain/usecases/swipe_usecase.dart`, `functions/src/match/onSwipe.ts` |

---

## Firestore Data Schemas

> These are the canonical schemas. Do not add fields to Firestore documents without updating this file and `PRD.md`.

### `users/{userId}`
```typescript
{
  displayName: string,
  dob: Timestamp,
  gender: string,
  orientation: string,
  bio: string,                        // max 500 chars
  interests: string[],
  relationshipGoal: "casual" | "serious" | "friendship",
  occupation: string,
  education: string,
  height: number,                     // cm
  languages: string[],
  pronouns: string,
  photoUrls: string[],                // max 6, Firebase Storage URLs
  isVerified: boolean,
  isPremium: boolean,
  premiumTier: "free" | "gold" | "platinum",
  isActive: boolean,
  isSnoozed: boolean,
  isBanned: boolean,
  location: GeoPoint,
  geohash: string,                    // for proximity queries
  preferences: {
    genders: string[],
    ageMin: number,
    ageMax: number,
    maxDistanceKm: number
  },
  swipesRemainingToday: number,       // reset daily via Cloud Function
  superLikesRemainingToday: number,
  createdAt: Timestamp,
  updatedAt: Timestamp
}
```

### `swipes/{fromUserId}_{toUserId}`
```typescript
{
  fromUserId: string,
  toUserId: string,
  action: "like" | "pass" | "superlike",
  createdAt: Timestamp
}
```

### `matches/{matchId}`
```typescript
{
  userIds: [string, string],
  matchedAt: Timestamp,
  expiresAt: Timestamp,
  isExpired: boolean,
  chatId: string,
  lastActivityAt: Timestamp
}
```

### `chats/{chatId}/messages/{messageId}`
```typescript
{
  senderId: string,
  type: "text" | "image" | "sticker" | "gif",
  content: string,
  mediaUrl?: string,
  reactions: { [userId: string]: string },  // emoji reactions
  isDeleted: boolean,
  deliveredAt?: Timestamp,
  readAt?: Timestamp,
  sentAt: Timestamp
}
```

### `gifts/{giftId}`
```typescript
{
  name: string,
  category: "sticker" | "rose" | "animated" | "premium",
  priceInSparks: number,
  priceUSD?: number,
  imageUrl: string,
  animationUrl?: string,              // Lottie JSON URL
  isPremiumOnly: boolean,
  isActive: boolean,
  createdAt: Timestamp
}
```

### `transactions/{transactionId}`
```typescript
{
  userId: string,
  type: "subscription" | "boost" | "superlike_pack" | "gift" | "sticker_pack",
  amount: number,                     // USD
  currency: string,
  productId: string,
  platform: "ios" | "android",
  receiptData: string,
  isVerified: boolean,
  createdAt: Timestamp
}
```

---

## Firebase Storage Structure

```
spark-storage/
├── users/
│   └── {userId}/
│       └── photos/
│           ├── {photoId}_original.jpg
│           └── {photoId}_thumb.jpg      # 200x200 thumbnail (generated by Function)
└── chat/
    └── {chatId}/
        └── {messageId}.jpg             # Images sent in chat
```

**Rules for agents:**
- Always upload to `users/{uid}/photos/` — never to a shared or public path.
- Thumbnails are generated server-side by a Firebase Function trigger on `object.finalize`.
- Use the **thumbnail URL** in profile cards and match lists for performance. Use full resolution only in the full profile view.

---

## Critical Business Logic

### Swipe & Match Creation (`functions/src/match/onSwipe.ts`)

```
1. Validate: fromUserId != toUserId
2. Validate: fromUserId has swipesRemainingToday > 0 (Free tier) OR isPremium == true
3. Write swipes/{fromId}_{toId} with action
4. If action == "like" or "superlike":
   a. Check if swipes/{toId}_{fromId} exists with action "like" or "superlike"
   b. If mutual match found:
      - Create matches/{matchId} document
      - Create chats/{chatId} document
      - Update matches/{matchId}.chatId
      - Send match push notification to BOTH users (FCM)
   c. If NOT mutual AND action == "superlike":
      - Send "You received a Super Like" notification to toUserId
5. Decrement swipesRemainingToday for Free tier users
```

> ⚠️ This function must remain **idempotent**. If called twice for the same swipe, it must not create duplicate matches.

### Match Expiry (`functions/src/match/expireMatches.ts`)

- Runs as a **scheduled function** every day at 02:00 UTC.
- Queries all `matches` where `expiresAt <= now` and `isExpired == false`.
- Sends a **24-hour warning notification** to both users at `expiresAt - 24h`.
- Sets `isExpired = true` on the match document.
- Does **not** delete the `chats` document — messages are retained per data retention policy.

### Free Tier Swipe Limit Reset

- A scheduled function runs daily at **00:00 UTC**.
- Resets `swipesRemainingToday` to `10` and `superLikesRemainingToday` to `1` for all `isPremium == false` users.
- Use batched writes (max 500 per batch) to handle large user counts.

### Premium Entitlement Check

- Premium status is verified **server-side** via `functions/src/purchases/verifyReceipt.ts`.
- Never trust `isPremium` or `premiumTier` values set directly by the client.
- RevenueCat webhook updates `users/{userId}.isPremium` and `premiumTier` via a Firebase Function endpoint.

---

## Environment Variables & Secrets

> **Agent Rule:** Never hardcode API keys, secrets, or environment-specific URLs in source code. Always use the appropriate secrets manager.

| Secret | Location |
|---|---|
| Firebase config (mobile) | `mobile/lib/core/constants/firebase_options.dart` (generated by FlutterFire CLI — do not edit manually) |
| Agora App ID | Flutter: `--dart-define=AGORA_APP_ID=...` or `.env` (not committed) |
| RevenueCat API Key | Flutter: `--dart-define=RC_API_KEY=...` or `.env` |
| Admin Panel env vars | `admin/.env` (not committed — see `.env.example`) |
| Firebase Functions secrets | Firebase Secret Manager (`firebase functions:secrets:set KEY`) |
| Google Cloud Vision API Key | Firebase Secret Manager |

---

## Common Commands

### Flutter (Mobile)

```bash
# Install dependencies
flutter pub get

# Run on device/emulator
flutter run

# Run with environment variables
flutter run --dart-define=AGORA_APP_ID=xxx --dart-define=RC_API_KEY=xxx

# Run tests
flutter test

# Build production APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Analyze code
flutter analyze

# Format code
dart format lib/
```

### Firebase Functions

```bash
# Install dependencies
cd functions && npm install

# Run emulator suite locally
firebase emulators:start

# Deploy all functions
firebase deploy --only functions

# Deploy specific function
firebase deploy --only functions:onSwipe

# View function logs
firebase functions:log

# Set a secret
firebase functions:secrets:set AGORA_APP_ID
```

### Firestore Rules & Indexes

```bash
# Deploy security rules
firebase deploy --only firestore:rules

# Deploy storage rules
firebase deploy --only storage

# Deploy Firestore indexes
firebase deploy --only firestore:indexes
```

### Admin Panel — Next.js

```bash
cd admin/nextjs
npm install
npm run dev          # Development server
npm run build        # Production build
npm run lint         # ESLint
npm run type-check   # TypeScript check
```

### Admin Panel — Laravel

```bash
cd admin/laravel
composer install
php artisan serve           # Development server
php artisan migrate         # Run migrations
php artisan test            # Run tests
php artisan route:list      # List API routes
```

---

## Testing Requirements

### Mobile (Flutter)

| Layer | Tool | Coverage Target |
|---|---|---|
| Use cases (domain) | `flutter_test` | 90%+ |
| Repository implementations | `flutter_test` + `mockito` | 80%+ |
| Widget tests | `flutter_test` | Key flows only |
| Integration tests | `integration_test` | Swipe, match, chat flows |

### Firebase Functions

| Type | Tool | Coverage Target |
|---|---|---|
| Unit tests | `jest` | 90%+ on `onSwipe`, `expireMatches` |
| Integration tests | Firebase Emulator Suite | All function triggers |

**Run all tests before opening a PR:**

```bash
# Flutter
flutter test --coverage

# Functions
cd functions && npm test
```

---

## Pull Request Checklist for Agents

Before submitting or suggesting a code change, verify:

- [ ] Change is aligned with the relevant section of `PRD.md`.
- [ ] No Firebase calls in `domain/` or `presentation/` layers.
- [ ] No hardcoded API keys, UIDs, or secrets.
- [ ] Firestore writes use `FieldValue.serverTimestamp()`, not `DateTime.now()`.
- [ ] Security Rules are not weakened by the change.
- [ ] Any new Firestore field is documented in the schema section of this file.
- [ ] `onSwipe.ts` changes include an updated/new unit test.
- [ ] Free tier limits are enforced server-side (Functions), not client-side only.
- [ ] `flutter analyze` passes with zero errors.
- [ ] `dart format lib/` has been run.
- [ ] Image uploads validate file size (≤ 2 MB) and MIME type before uploading.

---

## Feature Flags

Feature flags are stored in Firebase Remote Config and fetched at app startup.

| Flag | Default | Purpose |
|---|---|---|
| `enable_video_calls` | `true` | Toggle video/audio call feature |
| `enable_gift_shop` | `true` | Toggle gift & sticker shop |
| `match_expiry_days` | `7` | Days before an unmessaged match expires |
| `free_daily_swipes` | `10` | Daily swipe limit for Free tier |
| `proximity_radius_km` | `5` | Radius for proximity push notifications |
| `image_moderation_enabled` | `true` | Enable/disable Cloud Vision moderation |
| `superlike_free_daily` | `1` | Daily Super Likes for Free tier |

> When implementing a new major feature, wrap it in a Remote Config flag so it can be toggled without a new app release.

---

## Do Not Touch

The following files/areas must **not** be modified without explicit confirmation from the project lead:

- `firestore.rules` and `storage.rules` — security rule changes need security review.
- `functions/src/match/onSwipe.ts` — core matching logic; any change needs a test + review.
- `functions/src/purchases/verifyReceipt.ts` — payment verification; changes need QA sign-off.
- `lib/core/constants/firebase_options.dart` — auto-generated by FlutterFire CLI.
- `.firebaserc` — project aliases (staging vs production).

---

## Contacts & References

| Role | Responsibility |
|---|---|
| Product Manager | Feature decisions, PRD ownership |
| Tech Lead | Architecture decisions, Firebase, admin panel choice |
| Mobile Lead | Flutter app standards, PR reviews |
| DevOps | Firebase project config, CI/CD, secrets |

**Key reference documents:**
- `PRD.md` — Full product requirements and feature specs
- `AGENT.md` — This file (agent and developer guidance)
- Firebase Console — Firestore, Storage, Functions, FCM dashboards
- Agora.io Docs — Video/audio call SDK reference
- RevenueCat Docs — Subscription and entitlement management

---

*Last updated: February 22, 2026 — v1.0*
