# PROMPT.md — Phase-Wise AI Build Prompts
## 💘 Spark Dating App

> Copy each prompt below into your AI coding agent (Claude, Cursor, Copilot, etc.) at the start of each development phase. Each prompt is self-contained and references the PRD and AGENT.md for context.

---

## How to Use This File

1. Complete phases **in order** — each phase builds on the previous one.
2. Paste the full prompt block into your AI agent at the start of each phase.
3. After the agent completes a phase, run the **Validation Checklist** before moving on.
4. Reference files: `PRD.md` (feature requirements) and `AGENT.md` (coding rules).

---

## Phase 0 — Project Setup and Infrastructure

**Duration:** 1 week | **Goal:** Empty repo → fully configured Firebase project with CI/CD

---

### Prompt 0.1 — Repository and Folder Structure

```
You are setting up the Spark dating app monorepo. Read AGENT.md for the full folder structure before writing any code.

Create the complete folder structure for a Flutter + Firebase monorepo with the following top-level directories:
- mobile/    (Flutter app using Clean Architecture)
- functions/ (Firebase Cloud Functions in TypeScript)
- admin/     (Next.js 14 admin panel)

Inside mobile/lib/ create these folders with empty placeholder .dart files:
core/constants, core/errors, core/router, core/theme, core/utils,
data/models, data/repositories, data/datasources,
domain/entities, domain/repositories, domain/usecases,
presentation/auth, presentation/profile, presentation/discovery,
presentation/matches, presentation/chat, presentation/calls,
presentation/gifts, presentation/purchases, presentation/notifications,
presentation/settings,
services/

Create mobile/pubspec.yaml with ALL the free packages listed in PRD.md Section 5.
Create functions/package.json and functions/tsconfig.json for TypeScript Cloud Functions.
Create admin/package.json for Next.js 14 with TypeScript, Tailwind CSS, and shadcn/ui.

Do not install any paid packages. Every dependency must be from PRD.md Section 5.
```

---

### Prompt 0.2 — Firebase Configuration

```
You are configuring Firebase for the Spark dating app. Read AGENT.md before starting.

Do the following:
1. Create firebase.json configuring Firestore, Storage, Functions, and Hosting emulators.
2. Create firestore.rules with strict Security Rules following these principles from AGENT.md:
   - A user can only read/write their own users/{userId} document.
   - A user can only read chats/{chatId} if their userId is in participants[].
   - A user can only write to swipes/{fromId}_{toId} if fromId == request.auth.uid.
   - Gifts and matches are readable by authenticated users only.
3. Create storage.rules restricting uploads to authenticated users only, max 2 MB, allowed types: image/jpeg, image/png, image/webp.
4. Create firestore.indexes.json with a composite index on users collection for geohash + isActive + isBanned fields.
5. Create a .firebaserc with staging and production project aliases.
6. Create a firebase_emulator_setup.md explaining how to run the local emulator suite.

Security Rules must never be weakened. When in doubt, deny.
```

---

### Prompt 0.3 — GitHub Actions CI/CD

```
You are setting up CI/CD for the Spark dating app using GitHub Actions (free tier).

Create these GitHub Actions workflow files in .github/workflows/:

1. flutter_ci.yml
   - Triggers on: push to main and feature branches, pull_request to main
   - Steps: checkout, setup Flutter, flutter pub get, flutter analyze, dart format --check, flutter test --coverage
   - Upload coverage to Codecov (free)

2. functions_ci.yml
   - Triggers on: push to main, changes in functions/
   - Steps: checkout, setup Node 20, npm install, npm run lint, npm test

3. admin_ci.yml
   - Triggers on: push to main, changes in admin/
   - Steps: checkout, setup Node 20, npm install, npm run lint, npm run type-check, npm run build

4. deploy_functions.yml
   - Triggers on: push to main only
   - Steps: deploy Firebase Functions using FIREBASE_TOKEN secret

Do not use any paid CI/CD tools. GitHub Actions free tier provides 2,000 minutes/month.
```

---

### Phase 0 Validation Checklist

Before moving to Phase 1, confirm:
- [ ] `flutter pub get` runs without errors
- [ ] `firebase emulators:start` starts all emulators locally
- [ ] GitHub Actions workflows are green on a test push
- [ ] Firestore Security Rules deployed successfully
- [ ] `flutter analyze` passes with zero errors

---

## Phase 1 — Authentication and User Profile

**Duration:** 5 weeks | **Goal:** Users can register, log in, and build a full profile with photo upload and on-device image moderation

---

### Prompt 1.1 — Firebase Auth and Registration

```
You are building the authentication system for the Spark dating app. Read AGENT.md before starting.

Implement the following using Flutter, Riverpod, and Firebase Auth (free):

1. Create domain/entities/auth_entity.dart with fields: userId, email, phoneNumber, isEmailVerified, isPhoneVerified, createdAt.

2. Create domain/repositories/auth_repository.dart as an abstract interface with methods:
   signInWithEmail, signUpWithEmail, signInWithGoogle, signInWithApple, signInWithPhone,
   signOut, deleteAccount, getCurrentUser, authStateChanges (Stream).

3. Create data/repositories/firebase_auth_repository.dart implementing the interface using firebase_auth package.

4. Create use cases in domain/usecases/:
   sign_in_email_usecase.dart, sign_up_email_usecase.dart,
   sign_in_google_usecase.dart, sign_in_apple_usecase.dart,
   sign_in_phone_usecase.dart, sign_out_usecase.dart.

5. Create presentation/auth/ screens:
   - login_screen.dart (Email/Password, Google, Apple sign-in buttons)
   - register_screen.dart (Email + Password form with validation)
   - phone_auth_screen.dart (Phone number + OTP verification)
   - forgot_password_screen.dart

6. Create a Riverpod authStateProvider that exposes the current auth state.

7. Use GoRouter to redirect unauthenticated users to the login screen.

Rules from AGENT.md:
- No Firebase calls in domain/ or presentation/ layers.
- All Firebase calls through data/repositories/.
- Use Riverpod for all state — no setState except trivial local UI state.
```

---

### Prompt 1.2 — User Profile Setup Wizard

```
You are building the user profile feature for the Spark dating app. Read AGENT.md and PRD.md Section 6.2 before starting.

Build a multi-step profile setup wizard shown after first login:

Step 1 — Basic Info: Display Name, Date of Birth (DOB picker, must be 18+), Gender (dropdown), Sexual Orientation.
Step 2 — About You: Bio textarea (500 char limit with counter), Interests (multi-select chip grid of 30+ preset tags like "Hiking", "Cooking", "Movies", etc.), Relationship Goal (Casual / Serious / Friendship).
Step 3 — More About You: Height (slider in cm), Occupation (text field), Education (dropdown), Languages (multi-select), Pronouns.
Step 4 — Preferences: Preferred gender(s) (multi-select), Age range (range slider), Max distance (dropdown: 5/10/25/50 km/Worldwide).
Step 5 — Photos (handled by Prompt 1.3 below — placeholder step for now).

Create the Firestore user document following the exact schema in AGENT.md when the wizard completes.
Use FieldValue.serverTimestamp() for createdAt and updatedAt — never DateTime.now().

Also build:
- profile_view_screen.dart (read-only view of own profile)
- profile_edit_screen.dart (edit any field after initial setup)
- profile_preview_screen.dart ("how others see me" mode)
- A profile completion percentage widget

Create a UserModel in data/models/user_model.dart with fromJson/toJson using json_serializable.
Create a UserEntity in domain/entities/user_entity.dart with no Firebase dependencies.
```

---

### Prompt 1.3 — Image Upload with On-Device TFLite Moderation

```
You are building the image upload and on-device moderation system for the Spark dating app.
Read AGENT.md and PRD.md Sections 6.8 before starting. TFLite replaces paid Cloud Vision API — zero cost.

Implement the following:

1. Create services/image_moderation_service.dart:
   - Load a MobileNet NSFW TFLite model from assets/models/nsfw_mobilenet.tflite
   - Method: Future<bool> isSafeImage(File imageFile) — returns true if nsfwScore < 0.7
   - The model runs entirely on-device; no network call, no API cost.

2. Create data/datasources/storage_datasource.dart:
   - Method: Future<String> uploadProfilePhoto(String userId, File imageFile)
   - Before upload: run isSafeImage() — if false, throw ImageNotSafeException and log to Firestore flagged_images/{docId}
   - Compress image client-side using flutter_image_compress (max 2 MB, 85% quality)
   - Upload to Firebase Storage path: users/{userId}/photos/{photoId}_original.jpg
   - Return the download URL

3. Create presentation/profile/widgets/photo_grid_widget.dart:
   - Grid of up to 6 photo slots
   - Empty slots show a "+" button that opens image_picker (camera or gallery)
   - Filled slots show the photo with a delete icon
   - Drag-and-drop reordering using ReorderableGridView

4. On upload failure due to moderation: show a clear, non-alarming error message ("This photo doesn't meet our community guidelines").

5. Add asset declaration in pubspec.yaml for the TFLite model file path.

Add a placeholder nsfw_mobilenet.tflite file and a README in assets/models/ explaining where to download the actual model (NSFWDetector on GitHub — free, Apache 2.0).
```

---

### Phase 1 Validation Checklist

- [ ] User can register with Email, Google, Apple, and Phone
- [ ] Profile setup wizard completes and writes to Firestore with correct schema
- [ ] `isVerified`, `isPremium`, `premiumTier` fields present on user document
- [ ] Image upload works, runs TFLite check before sending to Storage
- [ ] Explicit images are blocked before reaching Firebase Storage
- [ ] Photo grid supports up to 6 photos with reordering
- [ ] `flutter test` passes for all auth and profile use cases

---

## Phase 2 — Swipe Discovery and Match Logic

**Duration:** 3 weeks | **Goal:** Full swipe-to-match experience with Cloud Functions

---

### Prompt 2.1 — Discovery Screen with flutter_card_swiper

```
You are building the discovery and swipe screen for the Spark dating app.
Read AGENT.md and PRD.md Section 6.10 before starting.

Build the following using flutter_card_swiper (free, open-source):

1. Create domain/usecases/swipe_usecase.dart with methods:
   - Future<void> like(String toUserId)
   - Future<void> pass(String toUserId)
   - Future<void> superLike(String toUserId)
   - Future<void> rewind() (Premium only)

2. Create data/repositories/discovery_repository.dart:
   - Fetch profiles not yet seen by the current user from Firestore
   - Filter by user preferences (gender, age range, distance)
   - Pre-fetch 10 profiles and cache locally (prevents re-fetching on each swipe)
   - Exclude banned users, snoozed users, and profiles the user has already swiped on

3. Create presentation/discovery/discovery_screen.dart:
   - Use CardSwiper widget from flutter_card_swiper
   - Swipe Right = like, Left = pass, Up = superlike
   - Show action buttons below the card stack (heart, X, star)
   - Show "You've run out of swipes today" bottom sheet for Free users at 10 swipes
   - Show empty-state screen if no profiles are in range
   - Each card shows: primary photo, name, age, distance, top 3 interest tags

4. Create presentation/discovery/widgets/profile_card_widget.dart:
   - Full-bleed photo with gradient overlay at the bottom
   - Name, age, distance, and interest chip tags over the gradient

5. Create presentation/discovery/widgets/match_celebration_widget.dart:
   - Lottie animation overlay when a mutual match occurs (free Lottie file from LottieFiles.com)
   - "You matched with [Name]!" message with "Send Message" and "Keep Swiping" buttons

Enforce: Free users limited to 10 swipes/day. Swipe limit check must happen client-side AND be re-validated server-side in the Cloud Function (Prompt 2.2).
```

---

### Prompt 2.2 — onSwipe Cloud Function (Match Creation)

```
You are building the core match creation Cloud Function for the Spark dating app.
Read AGENT.md Critical Business Logic section before writing any code.
This is the most critical function in the project — it must be idempotent and thoroughly tested.

Create functions/src/match/onSwipe.ts as a Firestore-triggered Cloud Function on document create:
Trigger: onDocumentCreated("swipes/{swipeId}")

The function must:
1. Parse fromUserId and toUserId from the swipeId (format: "{fromId}_{toId}").
2. Validate: fromUserId != toUserId. If same, log and exit.
3. Validate: fromUserId has swipesRemainingToday > 0 OR isPremium == true. If not, exit silently.
4. If action == "like" or "superlike":
   a. Check if swipes/{toId}_{fromId} exists with action "like" or "superlike".
   b. If mutual match:
      - Use WriteBatch to atomically:
        * Create matches/{matchId} with userIds, matchedAt, expiresAt (now + 7 days), isExpired: false, chatId (new UUID).
        * Create chats/{chatId} with participants: [fromId, toId], lastMessage: "", lastMessageAt: serverTimestamp().
      - After batch commit, send FCM match notification to BOTH users.
   c. If not mutual AND action == "superlike":
      - Send FCM "You received a Super Like" notification to toUserId only.
5. If action == "pass": no further action.
6. Decrement swipesRemainingToday by 1 for Free tier users (isPremium == false).

Idempotency: Before creating a match, check if matches/ already has a document with both userIds. If it does, exit without creating a duplicate.

Create functions/src/match/onSwipe.test.ts with jest unit tests covering:
- Mutual match creation
- Duplicate match prevention (idempotency)
- Super like notification
- Free tier swipe limit enforcement
- Same-user swipe rejection
```

---

### Prompt 2.3 — Match Expiry Scheduled Function

```
You are building the match expiry scheduled Cloud Function for the Spark dating app.
Read AGENT.md before starting.

Create functions/src/match/expireMatches.ts as a scheduled Cloud Function:
Schedule: every day at 02:00 UTC using firebase-functions/v2/scheduler

The function must:
1. Query all matches where expiresAt <= now AND isExpired == false using a Firestore batch query.
2. For matches expiring in exactly 24 hours (expiresAt between now+23h and now+25h):
   - Send FCM push notification to both users: "Your match with [name] expires in 24 hours! Send a message."
3. For matches where expiresAt <= now:
   - Set isExpired = true on the match document.
   - Do NOT delete the chats/ document (message history is retained per data retention policy).
   - Send FCM notification to both users: "Your match with [name] has expired."
4. Process in batches of 500 documents maximum per Firestore WriteBatch.
5. Log total matches expired in each run using functions.logger.info().

Also create functions/src/match/resetDailySwipes.ts:
Schedule: every day at 00:00 UTC
- Reset swipesRemainingToday to 10 and superLikesRemainingToday to 1 for all isPremium == false users.
- Process in batches of 500 to handle large user counts.
```

---

### Phase 2 Validation Checklist

- [ ] Swipe cards animate correctly in all three directions
- [ ] Free user swipe limit enforced at 10/day on both client and server
- [ ] Mutual swipe creates a match document in Firestore
- [ ] Match creation is idempotent (no duplicate matches on retry)
- [ ] Match celebration Lottie animation triggers on mutual match
- [ ] Expiry function sets isExpired: true without deleting chat documents
- [ ] Daily swipe reset function runs and resets counters correctly
- [ ] All onSwipe unit tests pass: `cd functions && npm test`

---

## Phase 3 — Matched Profiles List and Private Chat

**Duration:** 3 weeks | **Goal:** Users can browse matches and have real-time conversations

---

### Prompt 3.1 — Matched Profiles List Screen

```
You are building the matched profiles list for the Spark dating app.
Read AGENT.md and PRD.md Section 6.9 before starting.

Build the following:

1. Create data/repositories/match_repository.dart:
   - Stream<List<MatchEntity>> watchMatches(String userId) — real-time listener on matches/ where userId in userIds and isExpired == false
   - Future<void> unmatch(String matchId) — sets match as expired and removes chat access
   - Stream<List<MatchEntity>> watchExpiringSoon(String userId) — matches expiring within 24 hours

2. Create presentation/matches/matches_screen.dart:
   - Top horizontal row: new uncontacted matches (no messages yet) with animated "New Match" badge
   - Scrollable list below: matches with message activity, sorted by lastActivityAt descending
   - Each list tile: profile photo, name, age, last message preview, unread count badge, time since last activity (timeago package)
   - Search bar to filter matches by name
   - Swipe-to-dismiss on a match tile shows an "Unmatch" confirmation dialog
   - Empty state: "No matches yet. Keep swiping!" with a button to the discovery screen.

3. Match expiry warning: if expiresAt is within 24 hours, show a red timer badge on the match card.

4. Tapping a match navigates to the chat screen.

Use Riverpod StreamProvider to keep the list in sync with Firestore in real time.
```

---

### Prompt 3.2 — Private Chat Screen

```
You are building the private chat system for the Spark dating app.
Read AGENT.md and PRD.md Section 6.3 before starting.

Build the following:

1. Create data/repositories/chat_repository.dart:
   - Stream<List<MessageEntity>> watchMessages(String chatId) — real-time listener with pagination (load 30 messages, load older on scroll)
   - Future<void> sendTextMessage(String chatId, String text)
   - Future<void> sendImageMessage(String chatId, File imageFile)
   - Future<void> sendSticker(String chatId, String giftId, String animationUrl)
   - Future<void> markAsRead(String chatId, String messageId)
   - Future<void> deleteMessage(String chatId, String messageId, bool forBoth)
   - Future<void> reactToMessage(String chatId, String messageId, String emoji)

2. Create presentation/chat/chat_screen.dart:
   - AppBar: match's photo, name, online indicator, and a "..." menu (View Profile, Mute, Report, Block, Unmatch)
   - Message list: grouped by date, newest at bottom
   - Each message bubble shows: content, sent time, delivery status icons (sent tick, delivered double tick, read blue double tick)
   - Long-press message: emoji reaction picker + Delete option
   - Image messages: tappable thumbnail opening photo_view full screen
   - Sticker messages: Lottie animation inline in chat
   - Input bar: text field, emoji picker button, image attachment button, send button
   - "Start Voice Call" and "Start Video Call" icon buttons in the AppBar (Premium only — show paywall if Free tier)

3. Read receipts: update readAt on messages when the chat screen is open and new messages arrive.

4. Create presentation/chat/widgets/message_bubble_widget.dart for sent and received bubble styles.

All Firestore writes use FieldValue.serverTimestamp(). Never use DateTime.now() for message timestamps.
```

---

### Phase 3 Validation Checklist

- [ ] Matches list updates in real time when a new match is created
- [ ] New match badge displays correctly for uncontacted matches
- [ ] Unmatch removes the conversation and prevents re-access for both users
- [ ] Messages appear in real time using Firestore listener
- [ ] Read receipts update when the recipient opens the chat
- [ ] Image and sticker messages send and render correctly
- [ ] Emoji reactions work on messages
- [ ] Chat input bar emoji picker and attachment work correctly

---

## Phase 4 — Push Notifications and Location-Based Matching

**Duration:** 3 weeks | **Goal:** Users receive real-time alerts and discover matches nearby

---

### Prompt 4.1 — Push Notifications (FCM — Free)

```
You are building the push notification system for the Spark dating app using Firebase Cloud Messaging (FCM) — completely free.
Read AGENT.md and PRD.md Section 6.1 before starting.

Build the following:

1. Create services/notification_service.dart:
   - Initialize firebase_messaging and flutter_local_notifications on app start
   - Handle foreground messages: show local notification using flutter_local_notifications
   - Handle background messages: use @pragma('vm:entry-point') background handler
   - Handle notification tap: parse payload and navigate using GoRouter deep link
   - Request notification permission on iOS and Android 13+
   - Save FCM token to users/{userId}/fcmToken in Firestore on login and token refresh

2. Create core/router/deep_link_handler.dart:
   - Parse notification payload type: "match" | "message" | "call" | "gift" | "proximity"
   - Navigate to the appropriate screen based on type

3. Create presentation/notifications/notification_settings_screen.dart:
   - Toggle switches for each category: New Matches, Messages, Proximity Alerts, Gifts, App Updates
   - Store preferences in Firestore under users/{userId}/notificationPreferences
   - Firebase Functions check these preferences before sending targeted notifications

4. Update all Firebase Functions that send notifications (onSwipe.ts, expireMatches.ts, processGift.ts) to:
   - Check the recipient's notificationPreferences before calling FCM
   - Use the recipient's fcmToken from their Firestore document
   - Use firebase-admin messaging().send() with the correct notification and data payload

5. Create a broadcastNotification Cloud Function (HTTP trigger, admin-only):
   - Accepts: { topic, title, body, data }
   - Sends to FCM topic (e.g., "all_users", "premium_users")
   - Called by the Admin Panel push campaign feature
```

---

### Prompt 4.2 — Location-Based Matching (OpenStreetMap — Free)

```
You are building the location-based matching feature for the Spark dating app using OpenStreetMap and geoflutterfire_plus — completely free.
Read AGENT.md and PRD.md Section 6.4 before starting.

Build the following:

1. Create services/location_service.dart:
   - Request location permission using permission_handler
   - Get current position using geolocator
   - Calculate GeoHash from GeoPoint using geoflutterfire_plus
   - Method: Future<void> updateUserLocation(String userId) — writes location (GeoPoint) and geohash to users/{userId}
   - Call updateUserLocation() on app foreground (WidgetsBindingObserver)
   - Ghost Mode: if user has Ghost Mode enabled (Premium), skip location update

2. Create data/repositories/discovery_repository.dart — update the profile fetch to use GeoHash range query:
   - Use GeoCollectionReference from geoflutterfire_plus to query users within the configured radius
   - Filter by preferences (gender, age, not seen before, not banned, not snoozed, not self)
   - Return paginated results (10 at a time)

3. Display distance on profile cards:
   - Compute Haversine distance between current user location and profile GeoPoint
   - Show as "X km away" — never show exact coordinates

4. Create Proximity Notification Cloud Function (functions/src/notifications/sendProximityNotif.ts):
   - Triggered when a user's location is updated (onDocumentUpdated on users/{userId})
   - Query nearby users within the configured proximity_radius_km (from Remote Config)
   - For each nearby user that matches the updated user's preferences (and vice versa):
     * Check if a proximity notification was sent in the last 24 hours (prevent spam)
     * Send FCM notification: "Someone nearby matches your interests!"
   - Respect notificationPreferences.proximityAlerts setting

5. Do NOT use Google Maps or any paid map tile service.
   flutter_map with OpenStreetMap tile URL: "https://tile.openstreetmap.org/{z}/{x}/{y}.png" is free and requires no API key.
```

---

### Phase 4 Validation Checklist

- [ ] Push notifications arrive for all 7 notification types
- [ ] Notification tap navigates to the correct screen via deep link
- [ ] Notification preference toggles correctly suppress specific notification types
- [ ] User location updates in Firestore on app foreground
- [ ] Discovery feed filters by user's configured distance using GeoHash
- [ ] Distance shown on profile cards is approximate (not exact coordinates)
- [ ] Ghost Mode prevents location update (Premium feature)
- [ ] Proximity notifications are throttled (max 1 per 24 hours per user pair)

---

## Phase 5 — In-App Purchases

**Duration:** 2 weeks | **Goal:** Subscription plans and one-time purchases with RevenueCat free tier

---

### Prompt 5.1 — Subscription and IAP with RevenueCat (Free Tier)

```
You are building the in-app purchase and subscription system for the Spark dating app using RevenueCat free tier (free until $2.5k MRR).
Read AGENT.md and PRD.md Section 6.5 before starting.

Build the following:

1. Create services/purchase_service.dart:
   - Initialize RevenueCat (purchases_flutter) with the API key from flutter_dotenv
   - Method: Future<CustomerInfo> getCustomerInfo() — current subscription state
   - Method: Future<void> purchasePackage(Package package) — purchase a plan
   - Method: Stream<CustomerInfo> customerInfoStream — live subscription updates
   - Map RevenueCat entitlements to premiumTier: "free" | "gold" | "platinum"

2. Create a Riverpod premiumTierProvider that exposes the current user's tier.

3. Create presentation/purchases/premium_screen.dart:
   - Plan comparison table: Free vs Gold vs Platinum with feature checkmarks
   - Monthly and annual pricing options
   - "Most Popular" badge on Gold plan
   - Restore Purchases button
   - Terms of Service and Privacy Policy links

4. Create presentation/purchases/paywall_bottom_sheet.dart:
   - Shown when a Free user taps a Premium-only feature (video call, Ghost Mode, etc.)
   - Shows the specific feature they tried to use and what plan unlocks it
   - "Upgrade to Gold" and "See All Plans" buttons

5. Create a RevenueCat webhook Firebase Function (functions/src/purchases/webhookRevenueCat.ts):
   - HTTP endpoint that receives RevenueCat server-to-server webhooks
   - On INITIAL_PURCHASE or RENEWAL: set users/{userId}.isPremium = true, premiumTier = tier
   - On CANCELLATION or EXPIRATION: set isPremium = false, premiumTier = "free"
   - Verify webhook authenticity using RevenueCat webhook secret (stored in Firebase Secret Manager)

6. Never trust isPremium values set by the client. Always verify server-side via the webhook.

Store the RevenueCat API key in .env and load via flutter_dotenv. Never hardcode it.
```

---

### Phase 5 Validation Checklist

- [ ] Premium screen shows all three plans with correct features
- [ ] Paywall bottom sheet appears when Free user accesses Premium features
- [ ] Subscription purchase flows through App Store / Play Store correctly
- [ ] RevenueCat webhook updates Firestore isPremium and premiumTier fields
- [ ] Subscription lapse correctly downgrades user to Free tier
- [ ] Restore Purchases works correctly on reinstall

---

## Phase 6 — Video and Audio Calls with Jitsi Meet (Free)

**Duration:** 2 weeks | **Goal:** Free video and audio calling between matched users — replaces Agora.io

---

### Prompt 6.1 — Jitsi Meet Video and Audio Calls

```
You are building the video and audio call feature using Jitsi Meet SDK (jitsi_meet_flutter_sdk) — completely free, no per-minute charges.
This replaces Agora.io. Read AGENT.md and PRD.md Section 6.6 before starting.

Build the following:

1. Create services/call_service.dart:
   - Method: Future<void> startCall(String matchId, String receiverId, CallType type)
     * Generate roomName = "spark_{matchId}_{uuid()}"
     * Write calls/{callId} to Firestore: { roomName, callerId, receiverId, type, status: "ringing", startedAt: serverTimestamp() }
     * Send FCM data notification to receiver with payload: { type: "incoming_call", callId, roomName, callerName, callerPhoto, callType }
     * Join the Jitsi room: JitsiMeet().join(options)
   - Method: Future<void> answerCall(String callId, String roomName)
     * Update calls/{callId}.status = "answered"
     * Join the Jitsi room
   - Method: Future<void> declineCall(String callId)
     * Update calls/{callId}.status = "declined"
   - Method: Future<void> endCall(String callId)
     * Update calls/{callId}.status = "ended", endedAt: serverTimestamp()

2. Create presentation/calls/incoming_call_screen.dart:
   - Full-screen overlay shown when an FCM data call notification arrives
   - Shows caller's photo, name, and call type (voice/video)
   - Accept button (green) and Decline button (red)
   - Auto-dismiss and mark as "missed" if not answered within 30 seconds

3. Create presentation/calls/call_history_widget.dart:
   - Small call log entry shown in the chat thread after a call ends
   - Shows: call type icon, duration (if answered), status (missed/declined/ended)

4. Jitsi configuration (in call_service.dart):
   - serverURL: load from flutter_dotenv — defaults to "https://meet.jit.si" (free public server)
   - Disable the Jitsi welcome page and meeting name display
   - Set userInfo with displayName and avatar URL from user profile
   - Apply Spark brand color via Jitsi's colorScheme override

5. Restrict call initiation: check premiumTierProvider — if "free", show the paywall instead of starting a call.

6. Missed call Cloud Function (functions/src/notifications/):
   - Triggered by onDocumentUpdated on calls/{callId} where status changes
   - If status becomes "missed": send FCM notification to caller "Your call to [name] was not answered"

The serverURL must come from .env, not hardcode. This allows switching between public Jitsi and self-hosted without a code change.
```

---

### Phase 6 Validation Checklist

- [ ] Video call initiates from chat screen for Premium users
- [ ] Paywall shown to Free users attempting to call
- [ ] Incoming call screen displays with caller info
- [ ] Accept joins the Jitsi room for both users
- [ ] Decline updates Firestore status and dismisses the screen
- [ ] Missed call notification sent after 30 seconds of no answer
- [ ] Call log entry appears in chat thread after the call
- [ ] Switching between public Jitsi and self-hosted works via .env

---

## Phase 7 — Digital Gifts and Sticker Shop

**Duration:** 3 weeks | **Goal:** Users can send gifts and stickers using free Lottie animations

---

### Prompt 7.1 — Gift Shop and Sticker System

```
You are building the digital gift and sticker shop for the Spark dating app using Lottie animations (free from LottieFiles.com).
Read AGENT.md and PRD.md Section 6.7 before starting.

Build the following:

1. Create data/repositories/gift_repository.dart:
   - Stream<List<GiftEntity>> watchGiftCatalogue() — real-time list of active gifts from Firestore gifts/ collection
   - Future<void> sendGift(String chatId, String toUserId, String giftId) — calls processGift Cloud Function
   - Future<int> getSparksBalance(String userId) — reads sparksBalance from users/{userId}

2. Create presentation/gifts/gift_shop_screen.dart:
   - Grid of gift categories: Stickers, Roses, Hearts, Animated (tabs)
   - Each gift card: Lottie animation preview, name, price in Sparks or USD
   - "Free" badge on gifts included in Free tier
   - "Premium" badge on Gold/Platinum exclusive gifts
   - Purchase Sparks button (links to IAP)

3. Create presentation/gifts/widgets/sticker_picker_bottom_sheet.dart:
   - Bottom sheet opened from the chat input bar
   - Shows sticker packs in tabs (each pack is a category of related Lottie stickers)
   - Free packs always available; premium packs greyed out with lock icon for Free users
   - Tap a sticker to send it immediately to the chat

4. Create functions/src/gifts/processGift.ts (HTTP Cloud Function):
   - Verify sender has sufficient Sparks balance OR process real-money IAP
   - Deduct Sparks from sender's balance using a Firestore Transaction
   - Write a gift message to chats/{chatId}/messages/{messageId} with type: "sticker", mediaUrl: animationUrl
   - Increment revenue tracking in Firestore analytics/gifts document
   - Send FCM notification to receiver: "You received a gift from [name]!"
   - Log the transaction to transactions/{transactionId}

5. Lottie animations in chat: use the lottie package to render .json animation files.
   - Store Lottie JSON files in Firebase Storage under gifts/{giftId}/animation.json
   - Use cached_network_image approach for Lottie: download and cache locally

Free Lottie sources to reference in documentation:
- LottieFiles.com free library (CC0 and free-to-use animations)
- Create custom ones with Adobe After Effects + Bodymovin plugin (free)
```

---

### Phase 7 Validation Checklist

- [ ] Gift shop displays catalogue from Firestore in real time
- [ ] Sticker picker bottom sheet opens from chat input
- [ ] Premium stickers are locked for Free users with upgrade prompt
- [ ] Sending a gift deducts Sparks and creates a message in the chat
- [ ] Lottie animations render inline in the chat thread
- [ ] Gift received FCM notification arrives correctly
- [ ] Gift transactions are logged in Firestore

---

## Phase 8 — Admin Panel (Next.js on Vercel Free Tier)

**Duration:** 4 weeks | **Goal:** Fully functional admin panel deployed free on Vercel

---

### Prompt 8.1 — Admin Panel Setup and Authentication

```
You are building the admin panel for the Spark dating app using Next.js 14, TypeScript, Tailwind CSS, shadcn/ui, and NextAuth.js.
The admin panel is hosted on Vercel free tier (zero hosting cost).
Read AGENT.md and PRD.md Section 7 before starting.

Create the admin panel in admin/nextjs/ with:

1. Next.js 14 App Router structure:
   app/(auth)/login/page.tsx — Admin login form
   app/(admin)/layout.tsx   — Sidebar navigation layout with dark theme
   app/(admin)/dashboard/page.tsx
   app/(admin)/users/page.tsx
   app/(admin)/users/[userId]/page.tsx
   app/(admin)/moderation/page.tsx
   app/(admin)/subscriptions/page.tsx
   app/(admin)/gifts/page.tsx
   app/(admin)/notifications/page.tsx
   app/(admin)/settings/page.tsx

2. Authentication with NextAuth.js:
   - Email + password credentials provider
   - 2FA with TOTP (use otplib — free)
   - Role-based: superAdmin and moderator roles stored in Firestore admins/{email}
   - Redirect unauthenticated requests to /login
   - All admin actions log to Firestore audit_log/{docId}: { adminEmail, action, targetId, timestamp }

3. Firebase Admin SDK setup:
   - lib/firebase-admin.ts: initialise firebase-admin using service account from environment variable
   - All Firestore reads/writes in the admin panel go through the Admin SDK (bypasses Security Rules safely)
   - Service account key stored as environment variable FIREBASE_SERVICE_ACCOUNT_KEY (base64 encoded)

4. Sidebar navigation with shadcn/ui:
   - Dashboard, Users, Moderation, Subscriptions, Gifts, Push Notifications, Settings
   - Show logged-in admin email and role
   - Logout button

Deploy to Vercel free tier:
- Add vercel.json with build settings
- Environment variables set in Vercel dashboard (not committed to repo)
```

---

### Prompt 8.2 — Dashboard, User Management, and Moderation

```
You are building the Dashboard, User Management, and Moderation sections of the Spark admin panel.
Read PRD.md Section 7 for feature requirements.

Build the following:

1. Dashboard (app/(admin)/dashboard/page.tsx):
   - KPI cards: Total Users, DAU (today), New Registrations (today), Active Matches, MRR
   - Pull metrics from Firestore analytics/ collection (updated by Cloud Functions)
   - Use recharts (free) for a 30-day DAU line chart and match rate bar chart
   - "System Status" section: Firebase emulator health, last function run timestamps

2. User Management (app/(admin)/users/page.tsx):
   - Server-side paginated table of all users (20 per page) using Firebase Admin SDK
   - Columns: Avatar, Name, Email, Age, Premium Tier, Join Date, Status (Active/Suspended/Banned)
   - Search by name or email, filter by tier and status
   - Action buttons: View, Suspend (7/30 days), Ban Permanently, Delete Account (GDPR)

3. User Detail (app/(admin)/users/[userId]/page.tsx):
   - Full profile info, all photos (with individual remove button)
   - Subscription history from RevenueCat webhook data
   - Activity log: last 20 swipes, matches, messages (counts only, not content)
   - Report history: all reports filed against this user

4. Content Moderation (app/(admin)/moderation/page.tsx):
   - Review queue: images flagged by TFLite on-device moderation (stored in Firestore flagged_images/)
   - Each item: image preview, uploader name, flag reason (TFLite score), Approve or Remove buttons
   - Reported Profiles queue: list of user reports filed via the app
   - Reported Chats queue: flag metadata only (not full chat content) with option to investigate

All admin actions must be logged to Firestore audit_log/{docId} with adminEmail, action, targetId, and timestamp.
```

---

### Prompt 8.3 — Push Campaigns and Settings

```
You are building the Push Notification Campaigns and Settings sections of the Spark admin panel.

Build the following:

1. Push Notification Campaigns (app/(admin)/notifications/page.tsx):
   - Compose form: Title, Body, Target segment (All Users / Premium Users / Free Users / Inactive 7+ days), Schedule (now or future datetime)
   - Preview of how the notification will look on iOS and Android
   - Send button calls the broadcastNotification Cloud Function HTTP endpoint
   - Campaign history table: past campaigns with sent count and status

2. Gift Catalogue Manager (app/(admin)/gifts/page.tsx):
   - Table of all gifts with: preview (Lottie animation), name, category, price, status (active/inactive)
   - Add Gift form: name, category, Lottie JSON file upload (to Firebase Storage), price in Sparks, isPremiumOnly toggle
   - Edit and Deactivate buttons per gift item

3. App Settings (app/(admin)/settings/page.tsx):
   - Firebase Remote Config editor for key feature flags:
     * enable_video_calls (boolean)
     * enable_gift_shop (boolean)
     * match_expiry_days (number)
     * free_daily_swipes (number)
     * proximity_radius_km (number)
   - Save button publishes the Remote Config update immediately
   - Audit log viewer: paginated table of all admin actions

4. Subscriptions (app/(admin)/subscriptions/page.tsx):
   - Table: active subscriber counts by plan (Free / Gold / Platinum)
   - MRR chart using recharts (free)
   - Recent transactions table pulled from Firestore transactions/ collection
```

---

### Phase 8 Validation Checklist

- [ ] Admin login works with 2FA
- [ ] Dashboard KPI cards load from Firestore correctly
- [ ] User list is paginated and searchable
- [ ] Suspend and Ban actions write to Firestore and log to audit_log
- [ ] Moderation queue shows TFLite-flagged images with Approve and Remove actions
- [ ] Push campaign sends FCM broadcast to the correct user segment
- [ ] Gift catalogue CRUD works end-to-end
- [ ] Remote Config feature flag updates are published immediately
- [ ] Admin panel deploys to Vercel free tier successfully

---

## Phase 9 — QA, Performance, and Security Audit

**Duration:** 3 weeks | **Goal:** Production-ready quality gate

---

### Prompt 9.1 — Test Coverage and Performance

```
You are writing tests and optimising performance for the Spark dating app before launch.
Read AGENT.md Testing Requirements before starting.

Write the following tests:

1. Flutter unit tests (test/unit/):
   - All 10+ use cases in domain/usecases/: test happy path and error cases
   - ImageModerationService: test safe images pass and NSFW images are blocked
   - PurchaseService: test Free vs Gold vs Platinum entitlement mapping
   - LocationService: test GeoHash generation from coordinates

2. Flutter widget tests (test/widget/):
   - ProfileCard renders name, age, distance, and interest tags
   - ChatBubble renders correctly for sent, received, and sticker message types
   - MatchCelebration Lottie overlay appears and dismisses correctly

3. Firebase Functions tests (functions/src/match/onSwipe.test.ts):
   - Verify all existing tests still pass after any modifications
   - Add edge case: what happens if Firestore is unavailable during match creation?

4. Performance optimisations:
   - Verify discovery profile cards are pre-fetched (10 cached locally) — no lag on swipe
   - Ensure Lottie animations in chat are cached locally after first load (prevent re-download)
   - Confirm Firestore listeners are properly disposed in widget dispose() methods
   - Check for memory leaks in long chat sessions (use Flutter DevTools)
   - Verify images in chat load via cached_network_image (not fresh fetch each time)

5. Run flutter analyze — fix all warnings and errors.
6. Run dart format lib/ — ensure consistent code formatting.
7. Generate a coverage report: flutter test --coverage — target 80%+ on use cases.
```

---

### Prompt 9.2 — Security Audit

```
You are performing a security audit of the Spark dating app before launch.
Read AGENT.md before starting — pay special attention to the Security Rules section.

Audit and fix the following:

1. Firestore Security Rules review:
   - Confirm no user can read another user's exact location GeoPoint directly.
   - Confirm no user can write to matches/ directly (only Cloud Functions can create matches).
   - Confirm no user can modify another user's isPremium or premiumTier field.
   - Confirm chat messages are only readable by the two participants.
   - Test each rule with Firebase Security Rules Playground.

2. API key and secret audit:
   - Grep the entire codebase for hardcoded API keys, tokens, or secrets. There must be none.
   - Confirm .env is in .gitignore and not committed.
   - Confirm firebase_options.dart is not committed with production credentials.

3. Jitsi call room security:
   - Confirm room names use UUID (unguessable) — not sequential IDs or user names.
   - Confirm only matched users can retrieve the roomName from Firestore.

4. Image upload security:
   - Confirm Firebase Storage rules reject uploads over 2 MB.
   - Confirm only authenticated users can write to their own storage path.
   - Confirm TFLite check runs before every upload — cannot be bypassed client-side.

5. Premium feature enforcement:
   - Test that Free users cannot access video calls even by manipulating local state.
   - Confirm all Premium checks are also enforced server-side in Cloud Functions.

6. GDPR compliance check:
   - Confirm delete account flow purges all user data from Firestore and Storage.
   - Confirm exact location is never written to a publicly readable Firestore path.
   - Confirm privacy policy and terms of service links are accessible before registration.

Document all findings and fixes in a security_audit_report.md file.
```

---

### Phase 9 Validation Checklist

- [ ] `flutter test --coverage` shows 80%+ on domain/usecases/
- [ ] `flutter analyze` — zero errors, zero warnings
- [ ] All Firebase Functions tests pass
- [ ] No hardcoded secrets found in codebase
- [ ] Security Rules tested and confirmed in Firebase Rules Playground
- [ ] Free user cannot access Premium features by any client-side manipulation
- [ ] Delete account flow removes all data from Firestore and Storage
- [ ] security_audit_report.md created and reviewed

---

## Phase 10 — Beta Launch

**Duration:** 2 weeks | **Goal:** Internal and external beta with real users

---

### Prompt 10.1 — Beta Build and Store Setup

```
You are preparing the Spark dating app for beta distribution.

Complete the following:

1. Create flutter_launcher_icons configuration in pubspec.yaml:
   - Add Spark app icon (1024x1024 PNG) for iOS and Android

2. Create flutter_native_splash configuration:
   - Branded splash screen with Spark logo and brand color

3. Create build scripts:
   - scripts/build_android.sh: flutter build apk --release --dart-define-from-file=.env
   - scripts/build_ios.sh: flutter build ios --release --dart-define-from-file=.env

4. Update android/app/build.gradle:
   - Set applicationId, versionCode, versionName
   - Configure signing from environment variables (do not commit keystore)

5. Update ios/Runner/Info.plist with:
   - NSLocationWhenInUseUsageDescription (location permission reason)
   - NSCameraUsageDescription (camera permission reason)
   - NSMicrophoneUsageDescription (microphone for Jitsi calls)
   - NSPhotoLibraryUsageDescription (photo library access)

6. Upgrade Firebase to Blaze plan (pay-as-you-go):
   - Blaze is required for Cloud Functions deployment
   - Development costs remain $0 — billing only starts when free tier is exceeded

7. Create a BETA_TESTING.md guide explaining:
   - How to install via TestFlight (iOS) and Play Internal Testing (Android)
   - Known limitations in beta
   - How to submit bug reports

8. Set up Firebase App Distribution for internal team testing before public beta.
```

---

### Phase 10 Validation Checklist

- [ ] App icon and splash screen display correctly on both platforms
- [ ] Release APK builds successfully
- [ ] iOS release build succeeds
- [ ] App uploaded to TestFlight and Play Internal Testing
- [ ] Firebase upgraded to Blaze plan
- [ ] Beta testers can register, swipe, match, and chat end-to-end

---

## Phase 11 — Public Launch

**Duration:** 1 week | **Goal:** App Store and Play Store submission and launch

---

### Prompt 11.1 — Store Submission Preparation

```
You are preparing the Spark dating app for public App Store and Play Store submission.

Create the following:

1. store_assets/ directory with:
   - App Store screenshots (6.7", 5.5", iPad 12.9") — 5 screenshots minimum
   - Play Store screenshots (phone + tablet) — 2 minimum, 8 maximum
   - Feature graphic for Play Store (1024x500 PNG)
   - App preview video script (optional but recommended)

2. store_metadata.md containing:
   - App Name: Spark — Dating and Chat
   - Subtitle (iOS, 30 chars): Find Your Match Nearby
   - Description (4000 chars): full marketing description covering all 10 features
   - Keywords (iOS, 100 chars): dating, match, chat, meet, singles, swipe, local
   - Category: Social Networking > Dating
   - Age Rating: 17+ (dating apps)
   - Privacy Policy URL (required for dating apps)
   - Support URL

3. launch_checklist.md covering:
   - Firebase Security Rules are deployed and locked down
   - Admin panel is deployed on Vercel and accessible
   - RevenueCat products are configured in App Store Connect and Play Console
   - Jitsi server URL is set to production (public or self-hosted)
   - All environment variables set in production
   - Crash reporting (Firebase Crashlytics) is active
   - Analytics (Firebase Analytics) is active
   - First admin account created in Firestore admins/ collection

4. post_launch_monitoring.md:
   - Firebase Console alerts to set up (error rate, function failures, storage usage)
   - Daily check: Firestore read/write counts vs free tier limits
   - Weekly: review moderation queue in admin panel
   - Monthly: review MRR, churn, and retention in admin panel dashboard
```

---

### Phase 11 Validation Checklist

- [ ] App approved on App Store
- [ ] App approved on Google Play Store
- [ ] Admin panel live on Vercel
- [ ] Firebase Crashlytics receiving data
- [ ] Firebase Analytics receiving data
- [ ] RevenueCat subscription purchases confirmed working in production
- [ ] Jitsi calls working on production app
- [ ] Moderation queue accessible in admin panel

---

## Quick Reference — Free Stack Summary

| Feature | Free Tool Used | Cost |
|---|---|---|
| Video and Audio Calls | Jitsi Meet SDK | $0 |
| Push Notifications | Firebase Cloud Messaging | $0 |
| Image Moderation | TFLite on-device (MobileNet) | $0 |
| Maps and Location | OpenStreetMap + flutter_map | $0 |
| Swipe Cards | flutter_card_swiper | $0 |
| Gift Animations | Lottie + LottieFiles.com | $0 |
| Subscription Management | RevenueCat Free Tier | $0 until $2.5k MRR |
| Admin Hosting | Vercel Free Tier | $0 |
| CI/CD | GitHub Actions | $0 (2000 min/mo) |
| Analytics | Firebase Analytics | $0 |
| Crash Reporting | Firebase Crashlytics | $0 |
| State Management | Riverpod | $0 |
| Navigation | GoRouter | $0 |
| **Total** | | **$0 until real revenue** |

---

*Last updated: February 22, 2026 — v1.0*
*Reference: PRD.md (feature specs) | AGENT.md (coding rules)*
