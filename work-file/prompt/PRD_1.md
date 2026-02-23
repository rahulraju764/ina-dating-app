# Product Requirements Document (PRD)
## 💘 Spark — Dating App (Cost-Optimised Edition)

---

| Field | Details |
|---|---|
| **Document Version** | v2.0 |
| **Status** | Active |
| **Date** | February 22, 2026 |
| **Product Type** | Mobile Application (iOS & Android) + Admin Panel |
| **Design Philosophy** | Free-first. Use open-source & free-tier tools wherever possible. |

---

## Cost Optimisation Summary

| Area | Original (Paid) | Replacement (Free) | Monthly Saving |
|---|---|---|---|
| Video / Audio Calls | Agora.io (~$0.99/1000 min) | **Jitsi Meet SDK** (100% free, open-source) | ~$200–$2,000+ |
| Subscription Mgmt | RevenueCat Pro | **RevenueCat Free Tier** (up to $2.5k MRR free) | $0 until scale |
| Image Moderation | Google Cloud Vision API ($1.50/1000) | **TensorFlow Lite on-device** (free) | ~$50–$500 |
| Push Notifications | Paid FCM advanced | **Firebase Cloud Messaging** (free, unlimited) | $0 |
| Location & Maps | Google Maps Platform | **OpenStreetMap + flutter_map** (free) | ~$50–$300 |
| Admin Hosting | AWS / GCP ($50–200/mo) | **Vercel Free Tier** (Next.js) | ~$50–$200 |
| Analytics | Mixpanel / Amplitude (paid) | **Firebase Analytics** (free) | ~$50–$300 |
| Crash Reporting | Sentry Pro | **Firebase Crashlytics** (free) | ~$30–$100 |
| CI/CD | Bitrise / Codemagic Pro | **GitHub Actions** (free 2000 min/mo) | ~$30–$50 |
| **Total Estimated Saving** | | | **~$500–$3,500/mo** |

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Goals and Objectives](#2-goals-and-objectives)
3. [Scope](#3-scope)
4. [Tech Stack Cost-Optimised](#4-tech-stack-cost-optimised)
5. [Flutter Packages Free Only](#5-flutter-packages-free-only)
6. [Feature Requirements](#6-feature-requirements)
7. [Admin Panel Requirements](#7-admin-panel-requirements)
8. [Non-Functional Requirements](#8-non-functional-requirements)
9. [User Roles and Permissions](#9-user-roles-and-permissions)
10. [Data and Privacy](#10-data-and-privacy)
11. [Milestones and Timeline](#11-milestones-and-timeline)
12. [Success Metrics KPIs](#12-success-metrics-kpis)
13. [Open Questions and Risks](#13-open-questions-and-risks)

---

## 1. Executive Summary

**Spark** is a cross-platform mobile dating app built entirely on free and open-source tools, maximising quality while minimising infrastructure cost. The app uses Flutter for mobile, Firebase (free Spark plan during development, Blaze on launch), **Jitsi Meet** for free video/audio calls instead of Agora.io, and a Next.js admin panel hosted on Vercel's free tier.

The philosophy: **pay nothing until you have paying users**.

---

## 2. Goals and Objectives

### Business Goals
- Launch with **zero ongoing infrastructure cost** during development and early beta.
- Break even on server costs before reaching 1,000 paying subscribers.
- Grow to **100,000 registered users** within the first 6 months post-launch.
- Achieve **Day-30 retention rate of 30% or higher**.
- Keep monthly infrastructure cost under **$50** for the first 10,000 users.

### Product Goals
- Deliver a full-featured dating experience using 100% free packages and SDKs.
- Ensure user safety with on-device TFLite image moderation at zero API cost.
- Provide smooth video/audio calls via Jitsi Meet at no per-minute charge.

---

## 3. Scope

### In Scope (v1.0)
- Flutter mobile app (iOS and Android)
- Firebase backend (Auth, Firestore, Storage, FCM, Functions)
- Jitsi Meet video/audio calling (public server or self-hosted)
- Next.js Admin Panel hosted on Vercel free tier
- All 10 features defined in this PRD

### Out of Scope (v1.0)
- Web browser version of the user app
- Physical gift delivery
- AI personality matching
- Paid third-party analytics beyond Firebase Analytics

---

## 4. Tech Stack Cost-Optimised

| Layer | Technology | Cost | Notes |
|---|---|---|---|
| Mobile App | Flutter (Dart) | Free | Cross-platform iOS and Android |
| Authentication | Firebase Auth | Free (10k/mo) | Email, Google, Apple, Phone |
| Database | Cloud Firestore | Free (Spark Plan) | 1 GiB storage, 50k reads/day |
| File Storage | Firebase Storage | Free (5 GB) | Profile photos, chat media |
| Push Notifications | Firebase Cloud Messaging | Free (unlimited) | All push alerts |
| Real-time Chat | Firestore real-time listeners | Free | Instant messaging |
| **Video / Audio Calls** | **Jitsi Meet SDK** | **Free** | Open-source, replaces Agora.io |
| Location Services | Geolocator + flutter_map + OpenStreetMap | Free | No map tile fees |
| GeoQueries | geoflutterfire_plus | Free | GeoHash proximity queries |
| In-App Payments | RevenueCat free tier + App Store / Play | Free until $2.5k MRR | Subscription management |
| **Image Moderation** | **TFLite on-device** | **Free** | Replaces Cloud Vision API |
| Analytics | Firebase Analytics | Free | DAU, retention, funnels |
| Crash Reporting | Firebase Crashlytics | Free | Crash and error tracking |
| Admin Panel | Next.js 14 (React/TypeScript) | Free | App Router + Tailwind CSS |
| Admin Hosting | Vercel Free Tier | Free | 100 GB bandwidth/month |
| Admin Auth | NextAuth.js | Free | Admin login with 2FA |
| CI/CD | GitHub Actions | Free (2000 min/mo) | Build, test, deploy |
| Remote Config | Firebase Remote Config | Free | Feature flags |
| Performance | Firebase Performance Monitoring | Free | App and network metrics |

---

## 5. Flutter Packages Free Only

All packages listed below are open-source with no licensing cost.

### Core and Architecture
```yaml
dependencies:
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0
  go_router: ^13.0.0
  get_it: ^7.6.0
  freezed_annotation: ^2.4.0
  json_annotation: ^4.8.0

dev_dependencies:
  build_runner: ^2.4.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  riverpod_generator: ^2.3.0
```

### Firebase
```yaml
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.0
  firebase_storage: ^11.5.0
  firebase_messaging: ^14.7.0
  firebase_analytics: ^10.7.0
  firebase_crashlytics: ^3.4.0
  firebase_performance: ^0.9.3
  firebase_remote_config: ^4.3.0
```

### Video and Audio Calls — Jitsi Meet (FREE)
```yaml
  jitsi_meet_flutter_sdk: ^9.2.0
  # 100% free, Apache 2.0 open-source licence
  # Use public meet.jit.si servers OR self-host on a $5/mo VPS
  # No per-minute charges, no API key required
```

### Location and Maps
```yaml
  geolocator: ^11.0.0
  geoflutterfire_plus: ^0.0.28
  flutter_map: ^6.1.0          # OpenStreetMap — no API key needed
  latlong2: ^0.9.0
```

### UI and Media
```yaml
  image_picker: ^1.0.7
  flutter_image_compress: ^2.1.0
  cached_network_image: ^3.3.0
  photo_view: ^0.14.0
  flutter_card_swiper: ^6.0.0   # Tinder-style swipe cards — free
  lottie: ^3.0.0                 # Gift sticker animations — free
  flutter_svg: ^2.0.9
  shimmer: ^3.0.0
  emoji_picker_flutter: ^1.6.4
```

### Push Notifications
```yaml
  flutter_local_notifications: ^16.3.0
  flutter_foreground_task: ^6.1.0
```

### In-App Purchases
```yaml
  purchases_flutter: ^6.27.0    # RevenueCat — free until $2.5k MRR
```

### Image Moderation — On-Device TFLite (FREE)
```yaml
  tflite_flutter: ^0.10.4       # Runs entirely on device — zero API cost
  image: ^4.1.0
```

### Utilities
```yaml
  intl: ^0.18.0
  timeago: ^3.6.0
  url_launcher: ^6.2.0
  connectivity_plus: ^6.0.0
  permission_handler: ^11.3.0
  flutter_dotenv: ^5.1.0
  uuid: ^4.3.0
  logger: ^2.0.2
```

---

## 6. Feature Requirements

---

### 6.1 Push Notifications

**Priority:** High | **Cost:** Free (Firebase Cloud Messaging)

FCM is completely free with no message volume limit. `flutter_local_notifications` handles foreground display at no cost.

| ID | Requirement |
|---|---|
| PN-01 | Push notification sent on new match. |
| PN-02 | Push notification on new chat message. |
| PN-03 | Proximity alert when a matching user enters the configured radius. |
| PN-04 | Admin broadcasts to all users or segments via Admin Panel. |
| PN-05 | Gift or sticker received notification. |
| PN-06 | Swipe request and Super Like received notification. |
| PN-07 | Users toggle individual notification categories in Settings. |
| PN-08 | Notifications deep-link to the relevant screen via GoRouter. |
| PN-09 | Muted conversations suppress message notifications. |
| PN-10 | Incoming Jitsi call notification with Accept and Decline actions. |

| Notification | Trigger | Delivery Method |
|---|---|---|
| New Match | Mutual swipe | FCM direct token |
| New Message | Chat message sent | FCM direct token |
| Someone Nearby | GeoHash query match | FCM direct token |
| Gift Received | Gift sent by match | FCM direct token |
| Super Like | Super like action | FCM direct token |
| Broadcast | Admin panel campaign | FCM topic: all_users |
| Incoming Call | Jitsi call initiated | FCM data message |

---

### 6.2 User Profile

**Priority:** High | **Cost:** Free (Firebase Auth + Firestore)

| ID | Requirement |
|---|---|
| UP-01 | Register via Email, Google, Apple, or Phone (Firebase Auth — free). |
| UP-02 | Profile setup wizard on first login. |
| UP-03 | Profile fields: Display Name, DOB, Gender, Orientation, Bio (500 chars max), Interests (multi-select tags), Relationship Goal, Height, Occupation, Education, Language, Pronouns. |
| UP-04 | Upload up to 6 photos (Firebase Storage 5 GB free). |
| UP-05 | Minimum 1 photo required to appear in discovery. |
| UP-06 | Matching preferences: preferred gender(s), age range, max distance. |
| UP-07 | Profile completion percentage indicator. |
| UP-08 | "Preview my profile" mode. |
| UP-09 | Verified badge after phone or email verification. |
| UP-10 | Report and Block user. |
| UP-11 | Snooze Mode — hide from discovery without deleting account. |

**Firestore Schema — users/{userId}**
```
displayName, dob, gender, orientation, bio, interests[],
relationshipGoal, occupation, education, height, languages[],
pronouns, photoUrls[], isVerified, isPremium, premiumTier,
isActive, isSnoozed, isBanned, location (GeoPoint), geohash,
preferences { genders[], ageMin, ageMax, maxDistanceKm },
swipesRemainingToday, superLikesRemainingToday, createdAt, updatedAt
```

---

### 6.3 Private Chat

**Priority:** High | **Cost:** Free (Firestore real-time listeners)

| ID | Requirement |
|---|---|
| PC-01 | Chat only available to mutual matches. |
| PC-02 | Real-time text messaging via Firestore listeners. |
| PC-03 | Image sharing within chat (Firebase Storage). |
| PC-04 | Lottie animated sticker and GIF sending. |
| PC-05 | Delivery status: Sent, Delivered, Read. |
| PC-06 | Emoji reactions on individual messages. |
| PC-07 | Delete message for self or both parties. |
| PC-08 | Report and Block from within chat. |
| PC-09 | Mute notifications per conversation. |
| PC-10 | Paginated history — load older messages on scroll. |
| PC-11 | Start Call button launches Jitsi Meet (free). |

**Firestore Schema — chats/{chatId}/messages/{messageId}**
```
senderId, type (text | image | sticker | gif), content,
mediaUrl (optional), reactions { userId: emoji },
isDeleted, deliveredAt, readAt, sentAt
```

---

### 6.4 Location-Based Matching

**Priority:** High | **Cost:** Free (OpenStreetMap tiles, geoflutterfire_plus)

Using `flutter_map` with OpenStreetMap instead of Google Maps saves $50–300/month in tile costs. GeoHash proximity queries via `geoflutterfire_plus` are free within Firestore read limits.

| ID | Requirement |
|---|---|
| LB-01 | Request location permission on first launch with clear explanation. |
| LB-02 | Update GeoPoint and GeoHash in Firestore on app foreground. |
| LB-03 | Discovery feed filtered to user's configured distance. |
| LB-04 | Adjustable search radius: 5, 10, 25, 50 km, or Worldwide. |
| LB-05 | Approximate distance ("3 km away") shown on profile cards. |
| LB-06 | Proximity push notification when a matching user enters the radius. |
| LB-07 | Opt out of proximity notifications without disabling location. |
| LB-08 | Exact coordinates never exposed — computed distance only. |
| LB-09 | Ghost Mode: browse without updating location (Premium feature). |

---

### 6.5 In-App Purchases

**Priority:** High | **Cost:** Free until $2.5k MRR (RevenueCat free tier)

RevenueCat's free tier covers up to $2.5k Monthly Recurring Revenue — you pay nothing until the app is generating meaningful revenue.

| Plan | Price | Features |
|---|---|---|
| Free | $0/month | 10 swipes/day, 1 Super Like/day, basic chat |
| Gold | $9.99/month | Unlimited swipes, see who liked you, video calls, 1 boost/month |
| Platinum | $19.99/month | All Gold plus priority discovery, unlimited boosts and rewinds, all sticker packs |

| ID | Requirement |
|---|---|
| IAP-01 | Premium screen shows plan comparison and benefits. |
| IAP-02 | Native billing via App Store (iOS) and Play Store (Android). |
| IAP-03 | RevenueCat manages entitlements cross-platform on free tier. |
| IAP-04 | Premium status stored in Firestore, synced via RevenueCat webhook and Firebase Function. |
| IAP-05 | One-time Boost purchase (30-minute visibility boost). |
| IAP-06 | Super Like packs purchasable individually. |
| IAP-07 | Server-side receipt verification via RevenueCat API (free). |
| IAP-08 | Subscription lapse gracefully downgrades user to Free tier. |

---

### 6.6 Video and Audio Call — Jitsi Meet (Free)

**Priority:** Medium-High | **Cost:** Completely Free

#### Why Jitsi Meet Replaces Agora.io

| Criteria | Agora.io (Removed) | Jitsi Meet (Chosen) |
|---|---|---|
| Cost | $0.99 per 1,000 minutes | **$0 — completely free** |
| 10,000 min/month | ~$10 | **$0** |
| 100,000 min/month | ~$100 | **$0** |
| Open Source | No | **Yes (Apache 2.0)** |
| Self-Hostable | No | **Yes** |
| Flutter SDK | Paid | **Free (jitsi_meet_flutter_sdk)** |
| E2E Encryption | Paid feature | **Free** |
| API Key Required | Yes | **No** |

**Deployment Options:**
- **Option A — Public Servers:** Use `meet.jit.si` — completely free, zero setup, handles global scale automatically.
- **Option B — Self-Hosted:** Deploy Jitsi on a Hetzner or DigitalOcean VPS at $5–10/month for full control and branded domain.

| ID | Requirement |
|---|---|
| VC-01 | Voice and video calls launched from chat screen via Jitsi Meet SDK. |
| VC-02 | Unique Jitsi room name generated per call: `spark_{matchId}_{uuid}`. |
| VC-03 | Room name shared to both users via Firestore — no extra cost. |
| VC-04 | Receiving user gets FCM push notification with Accept and Decline. |
| VC-05 | Calls only permitted between matched users. |
| VC-06 | Camera toggle and microphone mute supported natively by Jitsi UI. |
| VC-07 | Call duration shown in Jitsi's built-in UI. |
| VC-08 | Missed call logged in chat if not answered within 30 seconds. |
| VC-09 | End-to-end encrypted calls (Jitsi E2EE — free). |
| VC-10 | Feature restricted to Gold and Platinum subscribers. |
| VC-11 | Jitsi UI customised with Spark branding (logo, colors). |

**Call Flow via Firestore Signaling (Free)**
```
User A taps "Call"
  → Generate roomName = "spark_{matchId}_{uuid}"
  → Write calls/{callId} to Firestore { roomName, callerId, receiverId, status: "ringing" }
  → Send FCM data push to User B with roomName
    → User B accepts → both join JitsiMeet.join(roomName)
    → User B declines → update calls/{callId}.status = "declined"
    → No answer in 30 seconds → status = "missed", FCM missed call sent
```

**Flutter Code Sample**
```dart
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

final jitsi = JitsiMeet();

Future<void> startCall(String roomName, String displayName) async {
  final options = JitsiMeetConferenceOptions(
    serverURL: "https://meet.jit.si",  // Free public OR your self-hosted URL
    room: roomName,
    configOverrides: {
      "startWithAudioMuted": false,
      "startWithVideoMuted": false,
    },
    featureFlags: {
      FeatureFlags.isWelcomePageEnabled: false,
    },
    userInfo: JitsiMeetUserInfo(displayName: displayName),
  );
  await jitsi.join(options);
}
```

---

### 6.7 Order Products and Digital Gifts

**Priority:** Medium | **Cost:** Free (Lottie animations from LottieFiles, Firebase Storage)

| ID | Requirement |
|---|---|
| OG-01 | Gift shop accessible from chat and profile screens. |
| OG-02 | Catalogue includes Lottie animated stickers, virtual roses, hearts. |
| OG-03 | Gifts purchased using in-app "Sparks" currency or IAP. |
| OG-04 | Recipient receives FCM notification and in-chat gift display. |
| OG-05 | Gifts render as Lottie animations in the chat thread. |
| OG-06 | "Sparks" currency redeemable for premium features or gifts. |
| OG-07 | Admin manages gift catalogue from Admin Panel. |
| OG-08 | Free sticker packs for all users; premium packs for Gold and Platinum. |
| OG-09 | Gift transactions logged in `transactions/` for revenue reporting. |

**Free Sticker Sources:**
- LottieFiles.com — thousands of free CC0 Lottie animations.
- Custom Lottie files created with Adobe After Effects free Lottie plugin.

**Firestore Schema — gifts/{giftId}**
```
name, category (sticker | rose | animated | premium),
priceInSparks, priceUSD (optional), imageUrl,
animationUrl (Lottie JSON URL, optional),
isPremiumOnly, isActive, createdAt
```

---

### 6.8 Image Upload and Gallery

**Priority:** High | **Cost:** Free (Firebase Storage 5 GB, TFLite on-device moderation)

On-device TFLite moderation replaces Google Cloud Vision API, saving $50–500/month.

| ID | Requirement |
|---|---|
| IMG-01 | Upload up to 6 profile photos. |
| IMG-02 | Minimum 1 photo required for discovery. |
| IMG-03 | Upload from camera or photo gallery via image_picker (free). |
| IMG-04 | Client-side compression via flutter_image_compress before upload (max 2 MB). |
| IMG-05 | Primary photo shown on discovery cards; others in swipeable gallery. |
| IMG-06 | Drag-and-drop photo reordering in profile editor. |
| IMG-07 | On-device NSFW detection via TFLite before upload — zero API cost. |
| IMG-08 | Images flagged by TFLite blocked client-side and logged for admin review. |
| IMG-09 | Admin can manually review and remove flagged photos. |
| IMG-10 | Images served via Firebase Storage CDN (included free). |
| IMG-11 | Thumbnail generated via Firebase Function on `storage.object().onFinalize()`. |

**On-Device Moderation Code Sample (TFLite — Free)**
```dart
import 'package:tflite_flutter/tflite_flutter.dart';

class ImageModerationService {
  late Interpreter _interpreter;

  Future<void> init() async {
    // Model bundled with app assets — no network call, zero API cost
    _interpreter = await Interpreter.fromAsset('assets/models/nsfw_mobilenet.tflite');
  }

  Future<bool> isSafeImage(File imageFile) async {
    // Run inference on device
    // Returns true if image passes safety threshold
    final nsfwScore = await _runInference(imageFile);
    return nsfwScore < 0.7;
  }
}
```

---

### 6.9 Matched Profiles List

**Priority:** High | **Cost:** Free (Firestore)

| ID | Requirement |
|---|---|
| ML-01 | Shows all mutual matches in a scrollable list. |
| ML-02 | Each card: primary photo, name, age, distance, last message preview. |
| ML-03 | New uncontacted matches highlighted with "New Match" badge. |
| ML-04 | Unread message count badge per match. |
| ML-05 | Sorted by most recent activity. |
| ML-06 | Search matches by name. |
| ML-07 | Unmatch from list or chat (removes access for both parties). |
| ML-08 | Match expires after 7 days with no message (configurable via Firebase Remote Config — free). |
| ML-09 | 24-hour expiry warning notification sent to both users. |

**Firestore Schema — matches/{matchId}**
```
userIds: [userId1, userId2],
matchedAt, expiresAt, isExpired,
chatId, lastActivityAt
```

---

### 6.10 Swipe to Send Request

**Priority:** High | **Cost:** Free (flutter_card_swiper)

`flutter_card_swiper` is a free open-source package delivering Tinder-style physics-based card swiping.

| ID | Requirement |
|---|---|
| SW-01 | Discovery screen presents profile cards in a swipeable stack. |
| SW-02 | Swipe Right or tap heart button = Like. |
| SW-03 | Swipe Left or tap X button = Pass. |
| SW-04 | Swipe Up or tap star button = Super Like (limited for Free tier). |
| SW-05 | Mutual right-swipe creates a match and notifies both users. |
| SW-06 | Match celebration Lottie animation on mutual match (free). |
| SW-07 | Free users: 10 swipes/day. Gold and Platinum: unlimited. |
| SW-08 | Rewind last swipe (Gold and Platinum feature). |
| SW-09 | Profile card shows: primary photo, name, age, distance, top 3 interest tags. |
| SW-10 | Tap card opens full profile view. |
| SW-11 | Previously seen profiles do not reappear. |
| SW-12 | Discovery queue pre-fetches 10 profiles for smooth performance. |

**Flutter Code Sample**
```dart
CardSwiper(
  controller: controller,
  cardsCount: profiles.length,
  onSwipe: (prev, curr, direction) {
    switch (direction) {
      case CardSwiperDirection.right: swipeUseCase.like(profiles[prev]);
      case CardSwiperDirection.left:  swipeUseCase.pass(profiles[prev]);
      case CardSwiperDirection.top:   swipeUseCase.superLike(profiles[prev]);
    }
    return true;
  },
  cardBuilder: (ctx, index, _, __) => ProfileCard(profile: profiles[index]),
)
```

---

## 7. Admin Panel Requirements

**Stack:** Next.js 14 (App Router) + TypeScript + Tailwind CSS + shadcn/ui
**Hosting:** Vercel Free Tier (100 GB bandwidth, unlimited deployments, automatic HTTPS)
**Auth:** NextAuth.js + Firebase Admin SDK (both free)

| Section | Features |
|---|---|
| Dashboard | DAU/MAU, registrations, match rate, MRR (Firebase Analytics — free) |
| User Management | List, search, view, suspend, ban, delete users |
| Content Moderation | Review TFLite-flagged images, reported profiles and conversations |
| Subscriptions | Active subscribers by tier, revenue, RevenueCat webhook data |
| Gift Catalogue | Add, edit, deactivate gift items and sticker packs |
| Push Campaigns | Compose and broadcast FCM notifications to user segments |
| Match Config | Set expiry days and swipe limits via Firebase Remote Config (free) |
| Audit Log | All admin actions logged to Firestore |

---

## 8. Non-Functional Requirements

### Performance
- Discovery cards load within 1 second (pre-fetched cache of 10 profiles).
- Chat messages delivered in under 500 ms via Firestore real-time listener.
- Jitsi call connection established within 3 seconds on 4G.
- Image uploads complete within 5 seconds for a 2 MB photo.

### Security
- All traffic uses TLS 1.2+ (enforced by Firebase and Vercel).
- Firestore Security Rules enforce user-scoped data access.
- Jitsi rooms use UUID in name — unguessable by outsiders.
- Payment data handled by App Store and Play Store only — never by Spark servers.
- On-device TFLite moderation: profile images never sent to third-party APIs.

### Firebase Free Tier Limits (Spark Plan)

| Resource | Free Limit | Action at Limit |
|---|---|---|
| Firestore reads | 50,000 / day | Upgrade to Blaze (pay-per-use) |
| Firestore writes | 20,000 / day | Upgrade to Blaze |
| Firestore storage | 1 GiB | Upgrade to Blaze |
| Firebase Storage | 5 GB total | Upgrade to Blaze |
| FCM messages | Unlimited | No action needed |
| Firebase Auth | 10,000 users/month | Upgrade to Blaze |
| Cloud Functions | 2M invocations/month | Upgrade to Blaze |

At approximately 10,000 active users, expect Blaze costs of $10–30/month — still very affordable.

### Compatibility
- iOS 14 and above | Android 8.0 (API 26) and above
- Jitsi Meet requires iOS 13.4+ and Android 6.0+
- Admin Panel: Chrome, Firefox, Safari, Edge (latest versions)

---

## 9. User Roles and Permissions

| Permission | Free | Gold ($9.99/mo) | Platinum ($19.99/mo) |
|---|---|---|---|
| Daily Swipes | 10 | Unlimited | Unlimited |
| Super Likes | 1/day | 3/day | Unlimited |
| Rewind | No | Yes | Yes |
| Private Chat | Yes | Yes | Yes |
| Images in Chat | Yes | Yes | Yes |
| Video and Audio Call (Jitsi — free) | No | Yes | Yes |
| Digital Gifts | Limited | Yes | Yes |
| Premium Sticker Packs | No | Yes | Yes |
| Profile Boost | No | 1/month | Unlimited |
| See Who Liked Me | No | Yes | Yes |
| Ghost Mode | No | Yes | Yes |

---

## 10. Data and Privacy

- GDPR and CCPA compliant: right to access, rectify, and erase data.
- App requires users to be 18 or older — DOB verified at registration.
- Exact GPS coordinates never exposed to other users — approximate distance only.
- On-device TFLite moderation: profile images never sent to any third-party API.
- Account deletion purges all personal data within 30 days.
- Transaction records retained 7 years for legal compliance.
- Jitsi calls are end-to-end encrypted — Spark has no access to call content.

---

## 11. Milestones and Timeline

| Phase | Milestone | Duration | Target |
|---|---|---|---|
| Phase 0 | Repo setup, Firebase config, GitHub Actions CI/CD | 1 week | Week 1 |
| Phase 1 | Auth, User Profile, Image Upload, TFLite moderation | 5 weeks | Week 6 |
| Phase 2 | Swipe/Discovery (flutter_card_swiper), Match logic | 3 weeks | Week 9 |
| Phase 3 | Matched Profiles List, Private Chat | 3 weeks | Week 12 |
| Phase 4 | Push Notifications (FCM), Location Matching (OpenStreetMap) | 3 weeks | Week 15 |
| Phase 5 | In-App Purchases (RevenueCat free tier) | 2 weeks | Week 17 |
| Phase 6 | Video and Audio Calls (Jitsi Meet — free) | 2 weeks | Week 19 |
| Phase 7 | Digital Gifts and Sticker Shop (Lottie) | 3 weeks | Week 22 |
| Phase 8 | Admin Panel (Next.js on Vercel free tier) | 4 weeks | Week 26 |
| Phase 9 | QA, Performance Testing, Security Audit | 3 weeks | Week 29 |
| Phase 10 | Beta Launch (TestFlight / Play Internal Testing) | 2 weeks | Week 31 |
| Phase 11 | Public Launch (App Store + Play Store) | 1 week | Week 32 |

---

## 12. Success Metrics KPIs

| KPI | Target (6 months post-launch) |
|---|---|
| Registered users | 100,000 |
| Daily Active Users (DAU) | 15,000 |
| Day-30 Retention Rate | 30% or higher |
| Average session length | 8 minutes or more |
| Match rate (swipes to match) | 10% or higher |
| Message rate (matches to first message) | 50% or higher |
| Free to paid conversion | 5% or higher |
| Monthly Recurring Revenue | $25,000 |
| App Store and Play Store rating | 4.3 stars or higher |
| Monthly infra cost at 10,000 users | Under $30 |
| Monthly infra cost at 100,000 users | Under $200 |

---

## 13. Open Questions and Risks

### Open Questions

| # | Question | Owner | Due |
|---|---|---|---|
| Q1 | Jitsi public meet.jit.si servers vs self-hosted $5/mo VPS? | Tech Lead | Week 1 |
| Q2 | Which free NSFW TFLite model to bundle? MobileNet vs NSFWDetector? | Tech Lead | Week 3 |
| Q3 | RevenueCat free tier sufficient or use native IAP only below $2.5k MRR? | Product | Week 5 |
| Q4 | Target launch markets for GDPR vs CCPA compliance scope? | Legal | Week 2 |

### Risks and Mitigations

| Risk | Likelihood | Mitigation |
|---|---|---|
| Jitsi public servers experiencing congestion at peak | Low | Self-host Jitsi on $5/mo Hetzner VPS as fallback option |
| Firebase free tier limits hit earlier than projected | Medium | Monitor daily in Firebase console; Blaze upgrade is pay-per-use with no upfront cost |
| TFLite on-device moderation missing some NSFW content | Medium | Combine with admin manual review queue; retrain or swap model as needed |
| App Store rejection for dating content | Medium | Review Apple and Google dating app guidelines before submission |
| RevenueCat free tier ($2.5k MRR cap) exceeded early | Low — a good problem | Upgrade to RevenueCat Starter at $119/month — still very affordable |
| Abuse and fake profiles | High | TFLite moderation + phone verification + community reporting + admin queue |
| Firestore read costs spiking with GeoHash queries | Medium | Paginate discovery queries, cache results locally, tune GeoHash precision |

---

*This document is a living PRD. Version 2.0 replaces Agora.io with Jitsi Meet and all paid dependencies with free or open-source alternatives.*

**Document Owner:** Product Manager
**Last Updated:** February 22, 2026 | **Version:** 2.0 — Cost-Optimised Edition
