# Product Requirements Document (PRD)
## 💘 Dating App — "Ina"

---

| Field | Details |
|---|---|
| **Document Version** | v1.1 |
| **Status** | Draft |
| **Date** | February 27, 2026 |
| **Product Type** | Mobile Application (iOS & Android) |
| **Tech Stack** | Flutter · Firebase · Laravel / Next.js (Admin Panel) |

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Goals & Objectives](#2-goals--objectives)
3. [Scope](#3-scope)
4. [Tech Stack Overview](#4-tech-stack-overview)
5. [Feature Requirements](#5-feature-requirements)
   - 5.1 [Push Notifications](#51-push-notifications)
   - 5.2 [User Profile](#52-user-profile)
   - 5.3 [Private Chat](#53-private-chat)
   - 5.4 [Location-Based Matching](#54-location-based-matching)
   - 5.5 [In-App Purchases](#55-in-app-purchases)
   - 5.6 [Video / Audio Call](#56-video--audio-call)
   - 5.7 [Order Products & Digital Gifts](#57-order-products--digital-gifts)
   - 5.8 [Image Upload & Gallery](#58-image-upload--gallery)
   - 5.9 [Matched Profiles List](#59-matched-profiles-list)
   - 5.10 [Swipe to Send Request](#510-swipe-to-send-request)
   - 5.11 [🪙 Coin System](#511--coin-system)
6. [Admin Panel Requirements](#6-admin-panel-requirements)
7. [Non-Functional Requirements](#7-non-functional-requirements)
8. [User Roles & Permissions](#8-user-roles--permissions)
9. [Data & Privacy](#9-data--privacy)
10. [Milestones & Timeline](#10-milestones--timeline)
11. [Success Metrics (KPIs)](#11-success-metrics-kpis)
12. [Open Questions & Risks](#12-open-questions--risks)

---

## 1. Executive Summary

**Ina** is a mobile-first dating application built with Flutter and powered by Firebase, designed to help people find meaningful relationships based on shared interests and proximity. The app provides an intuitive, swipe-based discovery experience combined with rich communication tools — including private chat, video/audio calls, and digital gift sending — to guide users from first match to real connection.

A fully featured Admin Panel (built in Laravel or Next.js) enables the operations team to manage users, moderate content, configure subscriptions, and monitor platform health.

---

## 2. Goals & Objectives

### Business Goals
- Build a sustainable revenue model through subscription tiers, in-app purchases (gifts, stickers, premium features), and a **coin economy** enabling microtransactions.
- Grow to **100,000 registered users** within the first 6 months post-launch.
- Achieve a **Day-30 retention rate of ≥ 30%**.

### Product Goals
- Deliver a seamless, intuitive swipe-and-match experience on both iOS and Android.
- Ensure user safety and data privacy at every touchpoint.
- Enable real-time communication (text, voice, video) between matched users.
- Provide monetization opportunities that feel natural, not intrusive.

### User Goals
- Discover compatible matches nearby based on interests and location.
- Communicate safely with matches before meeting in person.
- Express themselves through rich profiles, photos, and digital gifts.

---

## 3. Scope

### In Scope
- Flutter mobile app (iOS & Android)
- Firebase backend (Auth, Firestore, Storage, Cloud Messaging, Functions)
- Admin Panel web application (Laravel or Next.js)
- All 10 defined features listed in this document

### Out of Scope (v1.0)
- Web/browser version of the user-facing app
- Third-party dating profile imports (e.g., Facebook Dating sync)
- AI-powered personality matching (planned for v2.0)
- Physical gift delivery logistics (v1.0 covers digital gifts/stickers only)

---

## 4. Tech Stack Overview

| Layer | Technology | Purpose |
|---|---|---|
| **Mobile App** | Flutter (Dart) | Cross-platform iOS & Android |
| **Authentication** | Firebase Auth | Email, Google, Apple, Phone sign-in |
| **Database** | Cloud Firestore | Real-time data (profiles, matches, chats) |
| **File Storage** | Firebase Storage | Profile images, media uploads |
| **Push Notifications** | Firebase Cloud Messaging (FCM) | All in-app push alerts |
| **Real-time Messaging** | Firestore + Firebase Realtime DB | Private chat |
| **Video / Audio Calls** | Agora.io or WebRTC (via Firebase Signaling) | Voice & video calls |
| **Location Services** | Geoflutterfire + Firestore GeoHash | Proximity-based matching |
| **In-App Payments** | Stripe / RevenueCat + App Store / Play Store | Subscriptions & purchases |
| **Admin Panel** | Laravel (PHP) OR Next.js (React) | Backend management UI |
| **Admin API** | REST API (Laravel) / API Routes (Next.js) | Admin data access layer |
| **Hosting (Admin)** | AWS / GCP / Vercel | Admin panel deployment |

---

## 5. Feature Requirements

---

### 5.1 Push Notifications

**Priority:** 🔴 High

**Description:**
Push notifications keep users engaged and informed about activity on the platform. Notifications are sent via Firebase Cloud Messaging (FCM) and handled on-device by Flutter's `firebase_messaging` package.

#### Functional Requirements

| ID | Requirement |
|---|---|
| PN-01 | Users receive a push notification when they receive a new match. |
| PN-02 | Users receive a notification for every new message in a private chat. |
| PN-03 | Users receive a notification when someone nearby (within configured radius) is active on the app. |
| PN-04 | Users receive notifications for new app updates, promotions, or announcements (broadcast notifications via Admin Panel). |
| PN-05 | Users receive a notification when they receive a digital gift or sticker. |
| PN-06 | Users receive a notification when someone sends them a swipe request. |
| PN-07 | Users can enable or disable individual notification categories from in-app settings. |
| PN-08 | Notifications must deep-link to the relevant screen (e.g., chat, match list, profile). |
| PN-09 | Notifications are suppressed for muted conversations. |
| PN-10 | Admin can send broadcast push notifications to all users or segmented groups. |

#### Notification Types

| Notification | Trigger | Deep Link |
|---|---|---|
| 🎉 New Match | Both users swipe right | Match screen |
| 💬 New Message | Message received in chat | Chat screen |
| 📍 Someone Nearby | Active user enters proximity radius | Discovery screen |
| 🎁 Gift Received | Another user sends a gift/sticker | Gift notification screen |
| 👋 Swipe Request | User receives a like/request | Match requests list |
| 📢 App Update / Promo | Admin broadcast | Home / Promo screen |

---

### 5.2 User Profile

**Priority:** 🔴 High

**Description:**
User profiles are the foundation of the dating experience. A rich profile helps users express who they are and what they're looking for, which in turn powers better matching.

#### Functional Requirements

| ID | Requirement |
|---|---|
| UP-01 | Users can register via Email/Password, Google Sign-In, Apple Sign-In, or Phone Number. |
| UP-02 | Profile setup wizard guides new users through completing their profile on first login. |
| UP-03 | Profile fields include: Display Name, Age (Date of Birth), Gender, Sexual Orientation, Bio / About Me (max 500 chars), Interests/Hobbies (multi-select tags), Relationship Goal (Casual, Serious, Friendship), Height, Occupation, Education, Language, and Pronouns. |
| UP-04 | Users can upload up to **6 profile photos** (see Feature 5.8). |
| UP-05 | Users can set their matching preferences: preferred gender(s), age range, and maximum distance. |
| UP-06 | Profile completion percentage is displayed to encourage full completion. |
| UP-07 | Users can preview how their profile appears to others. |
| UP-08 | Verified badge is shown on profiles that have completed phone/email verification. |
| UP-09 | Users can report or block other profiles. |
| UP-10 | Profiles can be hidden/paused without account deletion ("Snooze Mode"). |
| UP-11 | Admin can view, edit, suspend, or delete any user profile from the admin panel. |

#### Profile Data Schema (Firestore)

```
users/{userId}
  ├── displayName: string
  ├── dob: timestamp
  ├── gender: string
  ├── orientation: string
  ├── bio: string
  ├── interests: string[]
  ├── relationshipGoal: string
  ├── occupation: string
  ├── education: string
  ├── height: number
  ├── languages: string[]
  ├── pronouns: string
  ├── photoUrls: string[]
  ├── isVerified: boolean
  ├── isPremium: boolean
  ├── isActive: boolean
  ├── isSnoozed: boolean
  ├── location: GeoPoint
  ├── geohash: string
  ├── preferences: { genders[], ageMin, ageMax, maxDistanceKm }
  └── createdAt: timestamp
```

---

### 5.3 Private Chat

**Priority:** 🔴 High

**Description:**
After two users match, they unlock a private one-on-one chat. Messages are stored in Firestore with real-time listeners to deliver instant messaging.

#### Functional Requirements

| ID | Requirement |
|---|---|
| PC-01 | Private chat is only available between two mutually matched users. |
| PC-02 | Users can send text messages in real time. |
| PC-03 | Users can send images within a chat (uploaded to Firebase Storage). |
| PC-04 | Users can send digital stickers and GIFs within a chat. |
| PC-05 | Messages show delivery status: Sent, Delivered, and Read receipts. |
| PC-06 | Chat supports emoji reactions on individual messages. |
| PC-07 | Users can delete a message for themselves or for both parties (within a time window). |
| PC-08 | Users can report a conversation or block a user from within the chat. |
| PC-09 | Users can mute notifications for a specific conversation. |
| PC-10 | Chat history is paginated and loads older messages on scroll. |
| PC-11 | Users can initiate a voice or video call directly from the chat screen (links to Feature 5.6). |
| PC-12 | Admins can view flagged/reported conversation reports from the admin panel. |

#### Chat Data Schema (Firestore)

```
chats/{chatId}
  ├── participants: userId[]
  ├── lastMessage: string
  ├── lastMessageAt: timestamp
  └── messages/{messageId}
        ├── senderId: string
        ├── type: "text" | "image" | "sticker" | "gif"
        ├── content: string
        ├── mediaUrl: string (optional)
        ├── reactions: { userId: emoji }
        ├── isDeleted: boolean
        ├── deliveredAt: timestamp
        ├── readAt: timestamp
        └── sentAt: timestamp
```

---

### 5.4 Location-Based Matching

**Priority:** 🔴 High

**Description:**
Location-based discovery allows users to find matches near them. The app uses Firestore GeoHash queries via the `geoflutterfire` Flutter package to efficiently query users within a radius.

#### Functional Requirements

| ID | Requirement |
|---|---|
| LB-01 | App requests location permission on first launch with a clear explanation. |
| LB-02 | User's location is updated in Firestore whenever the app comes to foreground. |
| LB-03 | Discovery feed shows profiles within the user's configured distance preference. |
| LB-04 | Users can set their search radius (e.g., 5 km, 10 km, 25 km, 50 km, Worldwide). |
| LB-05 | Distance between current user and a profile is displayed on the discovery card (e.g., "3 km away"). |
| LB-06 | Proximity push notification is triggered when an active user matching preferences enters the configured radius. |
| LB-07 | Users can opt out of proximity notifications without disabling location entirely. |
| LB-08 | Exact location coordinates are never exposed to other users — only approximate distance. |
| LB-09 | Users can enable "Ghost Mode" to hide their location while still browsing. |
| LB-10 | Location data is stored as a GeoPoint + GeoHash to enable efficient range queries. |

---

### 5.5 In-App Purchases

**Priority:** 🔴 High

**Description:**
Monetization is handled through a combination of subscription tiers and one-time purchases. RevenueCat is recommended as the subscription management layer, sitting on top of native App Store / Play Store billing.

#### Subscription Tiers

| Plan | Price (Example) | Features |
|---|---|---|
| **Free** | $0 / month | 10 swipes/day, basic matching, limited chat |
| **Gold** | $9.99 / month | Unlimited swipes, see who liked you, 1 boost/month, read receipts |
| **Platinum** | $19.99 / month | All Gold features + priority in discovery, unlimited rewinds, profile badge, unlimited boosts |

#### Functional Requirements

| ID | Requirement |
|---|---|
| IAP-01 | Users can view subscription plans and benefits from a dedicated "Premium" screen. |
| IAP-02 | Purchases are processed natively via Apple App Store (iOS) and Google Play Store (Android). |
| IAP-03 | RevenueCat (or equivalent) manages entitlements and cross-platform subscription state. |
| IAP-04 | Premium status is stored in Firestore and synced in real time. |
| IAP-05 | Users can purchase one-time "Boosts" to appear at the top of discovery for 30 minutes. |
| IAP-06 | Users can purchase "Super Likes" packs to highlight interest to a specific profile. |
| IAP-07 | Subscription status is verified server-side before granting premium features. |
| IAP-08 | Receipts and transaction history are accessible from user account settings. |
| IAP-09 | Admin panel shows subscription analytics: active subscribers per plan, churn rate, MRR. |
| IAP-10 | Failed payment or subscription lapse downgrades user to Free tier gracefully. |

---

### 5.6 Video / Audio Call

**Priority:** 🟡 Medium-High

**Description:**
Matched users can initiate voice or video calls directly within the app, facilitating a deeper connection before meeting in person. This is built on Agora.io SDK or WebRTC with Firebase used for call signaling.

#### Functional Requirements

| ID | Requirement |
|---|---|
| VC-01 | Voice and video call options are accessible from the private chat screen. |
| VC-02 | The receiving user sees an incoming call screen with Accept and Decline options. |
| VC-03 | Calls are only allowed between matched users. |
| VC-04 | Video calls support front/rear camera toggle during the call. |
| VC-05 | Users can mute their microphone during a call. |
| VC-06 | Users can disable their camera (switch to voice-only) during a video call. |
| VC-07 | Call duration is displayed on screen during the call. |
| VC-08 | A missed call notification is sent if the recipient does not answer. |
| VC-09 | Users can end the call at any time; call duration is logged in chat history. |
| VC-10 | Calls are encrypted end-to-end. Ina does not record calls. |
| VC-11 | If a call is interrupted (network drop), the app attempts to reconnect for up to 30 seconds. |
| VC-12 | Video/audio calls are a **Premium-only** feature (Gold and Platinum tiers). |

#### Call Flow

```
User A taps "Call" → Firebase Signaling creates call document
  → FCM sends incoming call push to User B
    → User B accepts → WebRTC / Agora session established
    → User B declines → Missed call logged, notification sent to A
```

---

### 5.7 Order Products & Digital Gifts

**Priority:** 🟡 Medium

**Description:**
Users can send digital gifts and stickers to their matches as a fun, expressive way to break the ice or show appreciation. This feature generates additional revenue and allows users to redeem earned digital currency.

#### Functional Requirements

| ID | Requirement |
|---|---|
| OG-01 | A gift shop is accessible from within a match's chat and from their profile. |
| OG-02 | The gift catalogue includes animated sticker packs, virtual roses, hearts, and themed gift items. |
| OG-03 | Gifts are purchased using in-app currency ("Inas") or directly via real-money purchase. |
| OG-04 | The recipient receives a push notification and an in-chat notification when a gift is received. |
| OG-05 | Sent gifts are displayed visually within the chat conversation thread. |
| OG-06 | Users can redeem accumulated "Inas" currency for premium features or gift items. |
| OG-07 | Admin panel allows management of the gift catalogue: add, remove, price, and categorize items. |
| OG-08 | Gift purchase transactions are recorded for revenue reporting in the admin panel. |
| OG-09 | Sticker packs can be unlocked as one-time purchases or included in premium subscriptions. |
| OG-10 | Free tier users receive a limited number of stickers; premium users have access to all packs. |

#### Gift Catalogue Item Schema (Firestore)

```
gifts/{giftId}
  ├── name: string
  ├── category: "sticker" | "rose" | "animated" | "premium"
  ├── price: number (in Inas or USD)
  ├── imageUrl: string
  ├── animationUrl: string (optional, Lottie)
  ├── isPremiumOnly: boolean
  └── isActive: boolean
```

---

### 5.8 Image Upload & Gallery

**Priority:** 🔴 High

**Description:**
Users can upload photos to their profile and view photos on other users' profiles. All images are stored in Firebase Storage with moderation in place.

#### Functional Requirements

| ID | Requirement |
|---|---|
| IMG-01 | Users can upload up to **6 photos** to their profile. |
| IMG-02 | At least **1 photo is required** to complete profile setup and appear in discovery. |
| IMG-03 | Users can upload from camera or photo library. |
| IMG-04 | Uploaded images are compressed client-side before upload (max 2 MB per image). |
| IMG-05 | The first photo in the profile gallery is the primary display photo shown on discovery cards. |
| IMG-06 | Users can reorder their photos via drag-and-drop within their profile editor. |
| IMG-07 | Users can delete individual photos from their gallery. |
| IMG-08 | When viewing another user's profile, photos are presented in a swipeable gallery. |
| IMG-09 | Photos undergo automated moderation (e.g., Google Cloud Vision API) to detect and block explicit content before being published. |
| IMG-10 | Flagged images are held for admin review before being made visible. |
| IMG-11 | Admin can manually remove any image that violates community guidelines. |
| IMG-12 | Images are served via CDN (Firebase Storage CDN) for fast load times globally. |

---

### 5.9 Matched Profiles List

**Priority:** 🔴 High

**Description:**
The Matches screen provides a consolidated, organised list of all mutual matches. This is the starting point for users to initiate conversation.

#### Functional Requirements

| ID | Requirement |
|---|---|
| ML-01 | The Matches screen shows all users who have mutually swiped right. |
| ML-02 | Each match card shows the match's primary photo, display name, age, and distance. |
| ML-03 | New matches (not yet messaged) are highlighted at the top with a "New Match" badge. |
| ML-04 | Matches with unread messages display a message preview and unread count badge. |
| ML-05 | Match list is sorted by recency of activity (most recent message or match first). |
| ML-06 | Users can search their matches by name. |
| ML-07 | Users can unmatch from the matches list or from within the chat, which removes the connection for both parties. |
| ML-08 | Unmatching immediately removes chat access for both users. |
| ML-09 | A match expires and is removed if no message is sent within **7 days** (configurable by admin). |
| ML-10 | When a match expires, both users receive a notification before expiry (e.g., 24-hour warning). |

#### Matches Data Schema (Firestore)

```
matches/{matchId}
  ├── userIds: [userId1, userId2]
  ├── matchedAt: timestamp
  ├── expiresAt: timestamp
  ├── isExpired: boolean
  ├── chatId: string
  └── lastActivityAt: timestamp
```

---

### 5.10 Swipe to Send Request

**Priority:** 🔴 High

**Description:**
The core discovery and matching mechanic. Users browse profile cards and swipe to express interest or pass. A mutual right-swipe creates a match.

#### Functional Requirements

| ID | Requirement |
|---|---|
| SW-01 | The Discovery screen presents one profile card at a time in a stack. |
| SW-02 | Swipe **Right** (or tap ❤️ button) = Like / Send Match Request. |
| SW-03 | Swipe **Left** (or tap ✕ button) = Pass / Dismiss profile. |
| SW-04 | Swipe **Up** (or tap ⭐ button) = Super Like (limited uses per day for free tier). |
| SW-05 | When two users both swipe right, a match is created and both are notified. |
| SW-06 | A match animation/screen is shown immediately when a mutual match occurs. |
| SW-07 | Free users are limited to **10 swipes per day**. Premium users have unlimited swipes. |
| SW-08 | Users can **Rewind** (undo) the last swipe (Premium feature; limited for free tier). |
| SW-09 | Each profile card shows: primary photo, name, age, distance, and up to 3 interest tags. |
| SW-10 | Tapping the card opens the full profile view (all photos, full bio, all interests). |
| SW-11 | Profiles already liked, passed, or matched are not shown again in discovery. |
| SW-12 | Discovery queue is pre-fetched and cached locally to ensure smooth swipe performance. |
| SW-13 | If the discovery queue runs out (no more profiles in range), a friendly empty-state screen is shown. |

#### Swipe Logic (Firebase Functions)

```
onSwipe(fromUserId, toUserId, action: "like" | "pass" | "superlike")
  ├── Write to swipes/{fromUserId}_{toUserId}: { action, timestamp }
  ├── If action == "like" or "superlike":
  │     Check if swipes/{toUserId}_{fromUserId}.action == "like" or "superlike"
  │     If YES → createMatch(fromUserId, toUserId) → trigger match notifications
  │     If NO  → If superlike → notify toUserId of Super Like received
  └── If action == "pass": no further action
```

---

---

### 5.11 🪙 Coin System

**Priority:** 🔴 High

**Description:**
The Coin System is Ina's internal virtual currency layer. Users purchase coins with real money and spend them across the platform — sending digital gifts to partners, playing in-app games, making voice/video calls, and unlocking premium interactions. When a user wins a game, 98% of the wagered coin pool is credited to the winner (the platform retains a 2% fee). Once a user's coin balance reaches a defined withdrawal threshold, they can cash out coins to their linked real-world wallet or bank account.

---

#### 5.11.1 Coin Packages

Users can purchase coin bundles directly from the app via Stripe / in-app billing. The following packages are available at launch:

| Package Name | Price (₹) | Coins Awarded | Bonus | Effective Rate |
|---|---|---|---|---|
| 🌱 Starter Pack | ₹100 | 200 coins | — | ₹0.50 / coin |
| 🔥 Popular Pack | ₹250 | 550 coins | +50 bonus | ₹0.45 / coin |
| 💎 Value Pack | ₹500 | 1,200 coins | +200 bonus | ₹0.42 / coin |
| 👑 Premium Pack | ₹1,000 | 2,600 coins | +600 bonus | ₹0.38 / coin |
| 🚀 Mega Pack | ₹2,000 | 5,500 coins | +1,500 bonus | ₹0.36 / coin |
| 🌟 Elite Pack | ₹5,000 | 15,000 coins | +5,000 bonus | ₹0.33 / coin |

> **Note:** Package prices and coin ratios are configurable by Admin without an app release (via Firebase Remote Config).

---

#### 5.11.2 Functional Requirements

| ID | Requirement |
|---|---|
| CS-01 | Users can view all available coin packages from the dedicated **Coins** section in the app. |
| CS-02 | Coin purchases are processed via Stripe (web/Android) or App Store / Play Store in-app billing (iOS). |
| CS-03 | Purchased coins are credited to the user's balance **immediately** upon successful payment confirmation, handled server-side via Firebase Function. |
| CS-04 | Users can view their current coin balance at all times in the app top bar / wallet screen. |
| CS-05 | A full coin transaction history is available to the user (purchases, spends, earnings, withdrawals). |
| CS-06 | Coins can be used to **send digital gifts** to matched/accepted partners. Each gift has a defined coin cost. |
| CS-07 | Coins are required to **initiate voice or video calls** with partners (per-minute deduction or flat fee per call, configurable). |
| CS-08 | Coins can be used to **play in-app games** with matched partners (both users wager a coin amount before the game starts). |
| CS-09 | When a game concludes, **98% of the total wagered coins** are credited to the winner's balance. The platform retains **2%** as a service fee. |
| CS-10 | If a user's coin balance reaches the **withdrawal threshold** (default: 10,000 coins ≈ ₹500), they can request a withdrawal to their linked bank account / UPI / wallet. |
| CS-11 | Withdrawals are processed within **3–5 business days** and require identity verification (KYC) before the first withdrawal. |
| CS-12 | Coin balance can never go below zero. Transactions that would result in a negative balance are blocked. |
| CS-13 | Admin can manually credit or deduct coins from any user account with a mandatory audit reason. |
| CS-14 | Coins are **non-transferable** between users except through the defined game, gift, and call flows. |
| CS-15 | Coin packages and their prices are displayed in the user's local currency (INR default; extensible). |
| CS-16 | Users receive a push notification when coins are received (from game win or gift refund). |
| CS-17 | Coin balance and all transactions are stored server-side; the client **never** self-credits coin balances. |
| CS-18 | A minimum wager amount must be set for games (default: 10 coins). Admin can configure this. |
| CS-19 | Failed / refunded purchases must not credit coins; Firebase Function must verify payment status before crediting. |
| CS-20 | All coin flows must generate an immutable audit log entry in Firestore. |

---

#### 5.11.3 Coin Usage Flows

**Sending a Gift**
1. User opens a matched partner's profile or chat.
2. Taps **Send Gift** → browses the gift shop (items priced in coins).
3. Confirms gift selection; coins are deducted atomically and gift is delivered to the recipient.
4. Recipient receives a push notification: "🎁 [Name] sent you a [Gift Name]!"

**Making a Call**
1. User taps **Voice Call** or **Video Call** on a matched partner's profile.
2. System checks coin balance against the minimum required (e.g., 20 coins for a voice call, 30 coins for video).
3. If balance is sufficient, the call connects. Coins are deducted per minute (e.g., 5 coins/min voice, 8 coins/min video) or as a flat session fee — configurable.
4. If the balance runs out mid-call, the user is warned at 60 seconds remaining and the call ends gracefully.

**Playing a Game**
1. User challenges a matched partner to a game (e.g., trivia, spin-the-wheel).
2. Both users agree on a wager amount (e.g., 50 coins each = 100 coins total pool).
3. Coins are escrowed from both accounts before the game begins.
4. On game completion, the Firebase Function distributes: **winner receives 98 coins**, **platform retains 2 coins**.
5. Both users receive a result notification with updated balances.

**Withdrawing Coins**
1. User opens **Wallet → Withdraw**.
2. System verifies balance ≥ withdrawal threshold (default 10,000 coins).
3. If KYC is not complete, user is directed to complete identity verification.
4. User inputs withdrawal amount and confirms linked payout method (UPI / bank / wallet).
5. Withdrawal request is created in Firestore; Finance team processes via admin panel within 3–5 business days.
6. User receives confirmation notification when payout is processed.

---

#### 5.11.4 Coin Package Display (Mobile UI)

The **Coins** section in the mobile app (accessible from the main navigation) must display:

- Current coin balance (prominent, top of screen)
- "Buy Coins" grid showing all packages with visual hierarchy (highlight the Popular Pack)
- "How to Earn / Use Coins" info section
- Transaction history list (last 50 entries with pagination)
- "Withdraw" CTA (visible only when balance ≥ withdrawal threshold)
- KYC status indicator (Verified / Pending / Required)

---

#### 5.11.5 Firestore Data Schema

**`coinTransactions/{transactionId}`**
```typescript
{
  userId: string,                       // owner of this transaction
  type: "purchase" | "spend" | "earn" | "withdrawal" | "refund" | "admin_adjustment",
  amount: number,                       // positive = credit, negative = debit
  balanceAfter: number,                 // snapshot of balance after this tx
  referenceId: string,                  // paymentIntentId, gameId, giftId, etc.
  referenceType: "payment" | "game" | "gift" | "call" | "withdrawal" | "admin",
  description: string,                  // human-readable (e.g. "Sent Rose Gift")
  createdAt: Timestamp,
  status: "completed" | "pending" | "failed" | "reversed",
}
```

**`users/{userId}` — additional fields**
```typescript
{
  coinBalance: number,                  // current balance (integer, never negative)
  totalCoinsEarned: number,             // lifetime earned (for analytics)
  totalCoinsSpent: number,              // lifetime spent
  kycStatus: "none" | "pending" | "verified" | "rejected",
  kycSubmittedAt: Timestamp | null,
  withdrawalEligible: boolean,          // true if balance ≥ threshold AND kyc verified
  lastWithdrawalAt: Timestamp | null,
}
```

**`coinPackages/{packageId}`** *(Admin-managed)*
```typescript
{
  name: string,                         // e.g. "Popular Pack"
  emoji: string,
  priceINR: number,
  coinsAwarded: number,
  bonusCoins: number,
  isActive: boolean,
  isFeatured: boolean,                  // highlighted in UI
  sortOrder: number,
  createdAt: Timestamp,
  updatedAt: Timestamp,
}
```

**`withdrawalRequests/{requestId}`**
```typescript
{
  userId: string,
  coinsRequested: number,
  inrEquivalent: number,                // coinsRequested × conversionRate
  payoutMethod: "upi" | "bank" | "wallet",
  payoutDetails: string,                // encrypted UPI ID / account number
  status: "pending" | "processing" | "completed" | "rejected",
  requestedAt: Timestamp,
  processedAt: Timestamp | null,
  adminNote: string | null,
  processedBy: string | null,           // admin userId
}
```

---

#### 5.11.6 Firebase Cloud Functions

| Function | Trigger | Responsibility |
|---|---|---|
| `onCoinPurchase` | Stripe webhook / IAP webhook | Verify payment, credit coins atomically, create transaction record |
| `onGameComplete` | Firestore `games/{gameId}` update | Distribute 98% to winner, 2% platform fee, update both balances |
| `onGiftSent` | Firestore `gifts/{giftId}` create | Deduct coins from sender, create transaction records for both parties |
| `onCallMinuteTick` | Callable / Agora webhook | Deduct per-minute coin cost; terminate call if balance insufficient |
| `onWithdrawalRequest` | Firestore `withdrawalRequests` create | Validate KYC, validate balance, lock coins, notify admin |
| `adminAdjustCoins` | Callable (Admin only) | Manually credit/deduct with audit log |

> ⚠️ **Security Rule:** `coinBalance` on `users/{userId}` must be **write-protected** from the client. Only authenticated Cloud Functions may write to this field.

---

#### 5.11.7 Admin Panel — Coin Management Module

The Admin Panel must include a dedicated **Coins** section with the following capabilities:

| Feature | Description |
|---|---|
| **Package Management** | Create, edit, activate/deactivate coin packages. Set price, coins awarded, bonus, and featured status. Changes take effect immediately without app release. |
| **User Coin Ledger** | Search any user by UID / email and view their full transaction history. |
| **Manual Adjustment** | Credit or deduct coins from a user with a mandatory reason field. All adjustments are immutably logged. |
| **Withdrawal Queue** | List of pending withdrawal requests. Admin can approve (trigger payout) or reject (with reason). |
| **KYC Review** | View submitted KYC documents; approve or reject user verification. |
| **Revenue Dashboard** | Total coins sold, total INR collected, platform fee earned from games, total coins in circulation, total coins withdrawn. |
| **Conversion Rate Config** | Set the coin-to-INR conversion rate for withdrawals (default: 10,000 coins = ₹500). |
| **Withdrawal Threshold Config** | Set the minimum balance required before a user can withdraw. |
| **Call Cost Config** | Set per-minute coin cost for voice and video calls. |
| **Game Fee Config** | Set the platform fee percentage for game outcomes (default: 2%). |
| **Fraud Alerts** | Flag users with anomalous coin earning patterns (e.g., repeatedly winning games against the same partner). |

---

#### 5.11.8 Security & Anti-Fraud

- Coin balance is **only writable by Cloud Functions** — Firebase Security Rules must block all direct client writes to `coinBalance`.
- Game outcomes are determined **server-side** — client cannot report its own win.
- Withdrawal requests lock the coins immediately (escrowed) to prevent double-spend.
- Rate limiting: maximum 3 withdrawal requests per user per 30 days.
- Anomaly detection: flag accounts where win rate in peer games exceeds 80% over 20+ games (possible collusion).
- All coin transaction documents are **append-only** — no updates or deletes allowed by any role except a designated audit function.

---

## 6. Admin Panel Requirements

The Admin Panel is a web application built in **Laravel (PHP + Blade/API)** or **Next.js (React)**, providing the operations team full control over the platform.

### 6.1 Authentication & Access Control

- Secure admin login with 2FA.
- Role-based access: Super Admin, Moderator, Support Agent.
- Audit log of all admin actions.

### 6.2 User Management

| Feature | Description |
|---|---|
| User List | Searchable, filterable list of all registered users. |
| User Detail | View full profile, photos, subscription status, activity log. |
| Suspend / Ban | Temporarily suspend or permanently ban a user. |
| Delete Account | Permanently delete a user and all their data (GDPR compliance). |
| Verify User | Manually grant or revoke verified badge. |

### 6.3 Content Moderation

- Review queue for AI-flagged profile images.
- Review reported profiles and conversations.
- Approve or reject flagged content with reason logging.
- Bulk moderation tools for efficiency.

### 6.4 Match & Chat Oversight

- View match statistics (total matches, daily matches).
- Access flagged/reported chat reports (not full chat content without cause, per privacy policy).
- Configure match expiry window.

### 6.5 Subscription & Revenue Management

- View active subscribers by tier (Free / Gold / Platinum).
- Monthly Recurring Revenue (MRR) dashboard.
- Transaction history and refund management.
- Configure subscription pricing and features per tier.

### 6.6 Gift & Product Catalogue Management

- Add / edit / deactivate gift items and sticker packs.
- Set gift pricing in Inas or USD.
- View gift transaction history and revenue.

### 6.7 Push Notification Campaigns

- Compose and send broadcast push notifications.
- Target segments: All users, Premium users, Free users, users inactive for N days.
- Schedule notifications for future delivery.
- View delivery and open rate analytics.

### 6.8 Analytics Dashboard

| Metric | Description |
|---|---|
| DAU / MAU | Daily and Monthly Active Users |
| New Registrations | Daily new sign-ups |
| Match Rate | % of swipes that result in a match |
| Message Rate | % of matches that send at least one message |
| Conversion Rate | % of free users converting to paid |
| Retention (D1/D7/D30) | User retention cohort analysis |
| Revenue | MRR, ARPU, total revenue by period |

---

## 7. Non-Functional Requirements

### 7.1 Performance

- Discovery screen cards must load within **< 1 second**.
- Chat messages must be delivered in **< 500 ms** under normal network conditions.
- The app must support **10,000 concurrent users** at launch with plans to scale.
- Image uploads should complete within **< 5 seconds** for a 2 MB photo on a standard 4G connection.

### 7.2 Security

- All data in transit must use **TLS 1.2+** encryption.
- Firebase Security Rules must enforce that users can only read/write their own data.
- Phone number and email are never exposed to other users via the API.
- Passwords are managed entirely by Firebase Auth (never stored by the app).
- Payment data is handled by Stripe / App Store / Play Store — never stored on Ina's servers.

### 7.3 Reliability & Availability

- Target uptime: **99.9% availability** (measured monthly).
- Firebase's managed infrastructure provides automatic scaling and failover.
- App must gracefully handle offline state and sync when connectivity is restored.

### 7.4 Scalability

- Firestore GeoHash indexing must support efficient location queries at scale.
- Firebase Functions handle all server-side logic (match creation, notifications) and auto-scale with demand.
- Image delivery via Firebase Storage CDN to handle high read volume.

### 7.5 Compatibility

- iOS: **iOS 14+**
- Android: **Android 8.0 (API 26)+**
- Admin Panel: Latest versions of Chrome, Firefox, Safari, and Edge.

### 7.6 Accessibility

- App UI must meet **WCAG 2.1 Level AA** standards.
- Support Dynamic Type / font scaling on iOS and Android.
- All interactive elements must have accessible labels for screen readers.

---

## 8. User Roles & Permissions

| Permission | Free User | Gold User | Platinum User | Admin |
|---|---|---|---|---|
| Browse discovery | ✅ (10/day) | ✅ Unlimited | ✅ Unlimited | — |
| Swipe right / like | ✅ (10/day) | ✅ Unlimited | ✅ Unlimited | — |
| Super Like | 1/day | 3/day | Unlimited | — |
| Rewind last swipe | ❌ | ✅ | ✅ | — |
| Private Chat | ✅ | ✅ | ✅ | — |
| Send images in chat | ✅ | ✅ | ✅ | — |
| Voice / Video Call | ❌ | ✅ (coins req.) | ✅ (coins req.) | — |
| Send digital gifts | Limited | ✅ (coins req.) | ✅ (coins req.) | — |
| Premium sticker packs | ❌ | ✅ | ✅ | — |
| Profile boost | ❌ | 1/month | Unlimited | — |
| See who liked me | ❌ | ✅ | ✅ | — |
| Ghost mode (location) | ❌ | ✅ | ✅ | — |
| Purchase coins | ✅ | ✅ | ✅ | — |
| Play games with coins | ✅ | ✅ | ✅ | — |
| Withdraw coins | ✅ (KYC req.) | ✅ (KYC req.) | ✅ (KYC req.) | — |
| Admin coin adjustment | ❌ | ❌ | ❌ | ✅ |
| Admin panel access | ❌ | ❌ | ❌ | ✅ |

---

## 9. Data & Privacy

### 9.1 Regulatory Compliance

- **GDPR** (EU users): Right to access, rectify, and erase personal data.
- **CCPA** (California users): Right to know and opt out of data sale.
- **COPPA**: App requires users to be **18+**; date of birth is verified at registration.

### 9.2 Data Retention

| Data Type | Retention Period |
|---|---|
| Active user profile | Until account deletion |
| Deleted user data | Purged within **30 days** of deletion |
| Chat messages | Retained for **90 days** after unmatch or deletion |
| Location data | Updated in real time; historical logs not stored |
| Transaction records | **7 years** (legal/financial compliance) |

### 9.3 Privacy Principles

- Exact GPS coordinates are never shared with other users.
- Only approximate distance ("X km away") is shown on profile cards.
- Users can delete their account and all associated data from app settings.
- Profile data used for matching is never sold to third parties.
- Analytics are aggregated and anonymised.

---

## 10. Milestones & Timeline

| Phase | Milestone | Duration | Target Date |
|---|---|---|---|
| **Phase 0** | Project setup, repo, CI/CD, Firebase config | 1 week | Week 1 |
| **Phase 1** | Auth, User Profile, Image Upload, Swipe/Discovery | 5 weeks | Week 6 |
| **Phase 2** | Matching Logic, Matched List, Private Chat | 4 weeks | Week 10 |
| **Phase 3** | Push Notifications, Location-Based Matching | 3 weeks | Week 13 |
| **Phase 4** | In-App Purchases, Subscription Tiers | 3 weeks | Week 16 |
| **Phase 4B** | Coin System (packages, wallet, transactions, withdrawal, KYC) | 3 weeks | Week 19 |
| **Phase 5** | Video / Audio Calls (coin-gated), Digital Gifts & Stickers (coin-priced) | 4 weeks | Week 23 |
| **Phase 5B** | In-App Games with coin wagering & 98/2 payout logic | 2 weeks | Week 25 |
| **Phase 6** | Admin Panel (User Mgmt, Moderation, Analytics, Coin Management) | 4 weeks | Week 29 |
| **Phase 7** | QA, Performance Testing, Bug Fixes | 3 weeks | Week 32 |
| **Phase 8** | Beta Launch (TestFlight / Play Internal Testing) | 2 weeks | Week 34 |
| **Phase 9** | Public Launch (App Store + Play Store) | 1 week | Week 35 |

---

## 11. Success Metrics (KPIs)

| Category | KPI | Target (6 months post-launch) |
|---|---|---|
| **Growth** | Total registered users | 100,000 |
| **Growth** | Daily Active Users (DAU) | 15,000 |
| **Engagement** | Day-30 Retention Rate | ≥ 30% |
| **Engagement** | Average session length | ≥ 8 minutes |
| **Engagement** | Average swipes per session | ≥ 20 |
| **Matching** | Match rate (swipes → match) | ≥ 10% |
| **Communication** | Message rate (matches → message) | ≥ 50% |
| **Revenue** | Free-to-paid conversion rate | ≥ 5% |
| **Revenue** | Monthly Recurring Revenue (MRR) | $25,000 |
| **Coins** | Coin package conversion rate (registered → first purchase) | ≥ 8% |
| **Coins** | Average coins purchased per buyer per month | ≥ 500 coins |
| **Coins** | Coins used in games per DAU | ≥ 20 coins/day |
| **Coins** | Withdrawal requests processed within SLA | ≥ 95% within 5 business days |
| **Quality** | App Store / Play Store rating | ≥ 4.3 stars |
| **Safety** | Reported content resolved < 24 hrs | ≥ 95% |

---

## 12. Open Questions & Risks

### Open Questions

| # | Question | Owner | Due |
|---|---|---|---|
| Q1 | Final decision: Admin panel in **Laravel** or **Next.js**? | Tech Lead | Week 1 |
| Q2 | Video call provider: **Agora.io** or self-hosted **WebRTC**? | Tech Lead | Week 2 |
| Q3 | Subscription management: **RevenueCat** or native only? | Product | Week 2 |
| Q4 | Will physical gift delivery (v1.0) use a third-party fulfilment API? | Product | Week 3 |
| Q5 | Target launch markets for geo-compliance (GDPR vs CCPA)? | Legal | Week 2 |
| Q6 | Image moderation: **Google Cloud Vision** or **AWS Rekognition**? | Tech Lead | Week 3 |
| Q7 | Coin withdrawal payout provider: **Razorpay**, **Cashfree**, or direct NEFT? | Finance / Tech Lead | Week 4 |
| Q8 | KYC provider for withdrawal verification: **Digilocker API**, **Aadhaar-based**, or third-party (e.g., Hyperverge)? | Legal / Tech Lead | Week 4 |
| Q9 | Should coin-to-INR conversion rate be fixed or dynamic (adjustable by admin)? | Product / Finance | Week 3 |
| Q10 | Games list for v1.0: which games ship first? (Trivia? Spin-the-wheel? Word games?) | Product | Week 5 |

### Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Firebase cold-start latency affecting real-time chat | Medium | High | Use Firestore + warm Cloud Functions; monitor with Firebase Performance |
| App Store / Play Store rejection due to dating content policies | Medium | High | Review both stores' dating app guidelines before submission |
| Abuse / fake profiles | High | High | Image moderation, phone verification, community reporting, admin moderation queue |
| Payment processing issues (refunds, chargebacks) | Medium | Medium | Use RevenueCat + Stripe; implement clear refund policy |
| GDPR non-compliance resulting in fines | Low | High | Legal review of privacy policy, data deletion flows, consent mechanisms |
| Scalability bottleneck in GeoHash location queries | Medium | High | Benchmark at 50k users; implement query pagination and caching |
| Video call quality degradation | Medium | Medium | Use Agora.io (managed infra) with adaptive bitrate; fallback to audio-only |
| Coin balance manipulation via client-side exploits | Medium | High | coinBalance is write-protected by Firestore Security Rules; only Cloud Functions may write to it |
| Game collusion (two users cooperating to farm coins) | Medium | High | Server-side win-rate anomaly detection; admin fraud alerts; 2% fee reduces incentive |
| Withdrawal fraud / money laundering via coin system | Low | High | Mandatory KYC before first withdrawal; rate-limit 3 withdrawals / 30 days; finance team review |
| Coin purchase double-credit (webhook retry) | Low | High | Idempotent `onCoinPurchase` function using paymentIntentId as idempotency key |
| Regulatory classification of coins as gambling (RBI / gaming laws) | Medium | High | Legal review; games of skill vs. chance distinction; consult RBI virtual currency guidelines |

---

*This document is a living PRD. It will be updated as requirements are refined, decisions are made, and the product evolves through development.*

---

**Document Owner:** Product Manager  
**Last Updated:** February 27, 2026  
**Version:** 1.1 — Coin System added (Feature 5.11)
