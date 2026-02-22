# DESIGN_PROMPTS.md — Screen Design Prompts
## 💘 ഇണ (Ina) Dating App — Every Screen

> These prompts are written for AI design tools (Midjourney, DALL·E, Figma AI, Galileo AI, Uizard, or any UI generation tool) and for passing to an AI coding agent to build Flutter screens. Each prompt includes layout, colors, typography, components, interactions, and states.

---

## Brand Identity Reference

Use these values across ALL screen prompts for consistency.

```
App Name:        ഇണ (Ina)
Tagline:         Find Your Soulmate Nearby

Primary Color:   #E91E8C  (Deep Pink / Magenta)
Secondary:       #FF6B6B  (Coral Red)
Accent:          #FFD93D  (Golden Yellow — used sparingly)
Background:      #0D0D0D  (Near Black) for dark mode
                 #FFF8FC  (Blush White) for light mode
Card Surface:    #1A1A2E  (Deep Navy) dark / #FFFFFF light
Text Primary:    #FFFFFF dark / #1A1A2E light
Text Secondary:  #B0B0C3 dark / #6B6B8A light
Success:         #00C896  (Mint Green)
Error:           #FF4757  (Alert Red)

Gradient 1:      linear-gradient(135deg, #E91E8C, #FF6B6B)
Gradient 2:      linear-gradient(180deg, #E91E8C 0%, #9B1FDB 100%)
Gradient 3:      linear-gradient(135deg, #FFD93D, #E91E8C)

Typography:
  Display Font:  Playfair Display (romantic, elegant serifs)
  Body Font:     DM Sans (clean, modern, readable)
  Accent Font:   Dancing Script (for decorative text only)

Corner Radius:   Cards = 24px, Buttons = 48px (pill), Chips = 20px
Shadow:          0 20px 60px rgba(233, 30, 140, 0.25)
Bottom Nav:      5 tabs — Discover, Matches, Chat, Gifts, Profile
```

---

## Screen Index

| # | Screen | Category |
|---|---|---|
| 01 | Splash Screen | Onboarding |
| 02 | Language Selection | Onboarding |
| 03 | Welcome / Landing | Onboarding |
| 04 | Register — Email | Auth |
| 05 | Register — Phone OTP | Auth |
| 06 | Login | Auth |
| 07 | Forgot Password | Auth |
| 08 | Profile Setup — Step 1 (Basic Info) | Profile Setup |
| 09 | Profile Setup — Step 2 (About You) | Profile Setup |
| 10 | Profile Setup — Step 3 (More Details) | Profile Setup |
| 11 | Profile Setup — Step 4 (Preferences) | Profile Setup |
| 12 | Profile Setup — Step 5 (Photos) | Profile Setup |
| 13 | Discovery / Swipe Screen | Core |
| 14 | Profile Card — Full View | Core |
| 15 | Match Celebration Overlay | Core |
| 16 | Matched Profiles List | Core |
| 17 | Private Chat Screen | Chat |
| 18 | Chat — Sticker Picker | Chat |
| 19 | Incoming Call Screen | Calls |
| 20 | Video / Audio Call Screen (Jitsi) | Calls |
| 21 | Gift Shop Screen | Gifts |
| 22 | My Profile Screen | Profile |
| 23 | Edit Profile Screen | Profile |
| 24 | View Other's Profile | Profile |
| 25 | Subscription / Premium Screen | Purchases |
| 26 | Paywall Bottom Sheet | Purchases |
| 27 | Notification Settings | Settings |
| 28 | App Settings Screen | Settings |
| 29 | Report / Block Screen | Safety |
| 30 | Empty States (3 variants) | States |
| 31 | Swipe Limit Reached | States |
| 32 | Admin Panel — Dashboard | Admin |
| 33 | Admin Panel — User Management | Admin |
| 34 | Admin Panel — Moderation Queue | Admin |

---

## 01 — Splash Screen

```
Design a mobile splash screen for a Malayalam dating app called "ഇണ (Ina)" meaning Soulmate.

LAYOUT:
- Full screen, dark background: deep near-black #0D0D0D
- Center: App logo — a stylised pair of interlinked hearts formed from the Malayalam letter "ഇ"
  rendered in the brand gradient (pink #E91E8C to coral #FF6B6B)
- Below logo: App name "ഇണ" in Playfair Display, 48px, white
- Below that: tagline "കൂടെ ഉണ്ടാകും" (Will Be Together) in DM Sans, 16px, muted white #B0B0C3
- Very bottom: a soft radial glow/bloom effect behind the logo (pink at 10% opacity)
- Animated: logo scales from 0.5 to 1.0 with a spring bounce over 800ms on load

ATMOSPHERE:
- Romantic, dark, cinematic
- Subtle particle effect: 20–30 tiny floating hearts at 5% opacity drifting upward
- No status bar visible (full immersive mode)

DIMENSIONS: 390×844px (iPhone 14 reference frame)
OUTPUT: Flutter-ready Figma frame or Flutter widget code
```

---

## 02 — Language Selection Screen

```
Design a language selection screen for the ഇണ (Ina) dating app.

LAYOUT:
- Dark background #0D0D0D
- Top: ഇണ logo small (40px) centered
- Heading: "Choose Your Language" in DM Sans Bold 28px, white
  Sub-heading: "നിങ്ങളുടെ ഭാഷ തിരഞ്ഞെടുക്കൂ" (Choose Your Language in Malayalam) 16px muted
- Language option cards (3 visible, scrollable):
  Each card: 100% width, 72px tall, rounded 16px, border 1px solid #2A2A3E
  Left: flag emoji + language name in its native script
  Right: radio button circle (filled pink when selected)
  Languages shown: Malayalam (മലയാളം) ← pre-selected, English, Hindi (हिंदी), Tamil (தமிழ்)
- Selected card has a subtle pink left border accent and background tint #E91E8C10
- Bottom: "Continue" pill button, full width, gradient #E91E8C→#FF6B6B, 56px tall

STYLE: Clean, minimal dark. Soft card hover states.
INTERACTION: Tap language → card highlights with spring animation → Continue button activates
```

---

## 03 — Welcome / Landing Screen

```
Design the welcome/landing screen for ഇണ (Ina) dating app. This is the first emotional impression.

LAYOUT (Swipeable onboarding — 3 slides):

SLIDE 1 — "Find Your ഇണ":
- Full-bleed illustration: two abstract silhouettes reaching toward each other
  rendered in the pink-coral gradient against a starry dark background
- Bottom sheet panel (rounded top 32px): slides up from bottom, 60% screen height
- Title: "Find Your ഇണ" — Playfair Display Italic, 36px, white
- Body: "Discover people nearby who share your interests and heart" — DM Sans 16px, #B0B0C3
- Slide dots indicator: 3 dots, active = pink pill, inactive = grey circles

SLIDE 2 — "Match. Chat. Meet.":
- Illustration: phone screen with swipe cards and floating hearts
- Title: "Swipe. Match. Connect." 
- Body: "A right swipe could change everything. Find your person nearby."

SLIDE 3 — "Safe & Private":
- Illustration: shield icon with a heart inside, soft glow
- Title: "Your Privacy, Protected"
- Body: "Your exact location is never shared. You're always in control."

BOTTOM (visible on all slides):
- "Get Started" gradient button — full width, 56px, pill shape
- "Already have an account? Sign In" — text link, muted, 14px
- Social proof text: "50,000+ people found their match ❤️" — tiny, centered, #B0B0C3

ANIMATION: Slides transition with horizontal parallax. Illustrations move at 0.7x scroll speed.
```

---

## 04 — Register Screen (Email)

```
Design a registration screen for ഇണ (Ina) dating app using Email.

LAYOUT:
- Background: #0D0D0D dark with subtle mesh gradient blob (pink-purple, 15% opacity) in top-right corner
- Top: back arrow (left) + "Create Account" title (center) in DM Sans Bold 22px
- Avatar placeholder circle (80px): dashed border, pink, camera icon inside
  (Profile photo optional at this stage)
- Form fields (rounded 14px, dark fill #1A1A2E, border #2A2A3E, active border #E91E8C):
  * Full Name — person icon prefix
  * Email Address — email icon prefix
  * Password — lock icon, eye toggle suffix
  * Confirm Password — lock icon
  * Date of Birth — calendar icon (must be 18+, shows age picker)
  * Gender — dropdown with custom options (Man/Woman/Non-binary/Prefer not to say)
- Field labels float upward when active (Material-style animated label)
- Age validation: real-time — if DOB makes user under 18, show red inline error "Must be 18 or older"
- "Create Account" gradient button — full width, 56px, gradient pink→coral, disabled until all valid
- Divider: "— or sign up with —"
- Social buttons row: Google (white card), Apple (white card), Phone (outlined)
- Bottom: "By creating an account you agree to our Terms of Service and Privacy Policy" — 12px, muted, linked

VALIDATION STATES:
- Valid field: green checkmark suffix icon
- Invalid field: red border + inline error message below field
- Password strength meter: 4-segment bar below password field

COLORS: All inputs dark fill on dark background. Pink accents only on active/focus state.
```

---

## 05 — Phone OTP Verification Screen

```
Design a phone number verification screen for ഇണ (Ina) dating app.

LAYOUT:
- Dark background. Centered layout.
- Top: back arrow. No title.
- Large icon: illustrated phone with signal waves in pink, 100px, centered
- Heading: "Verify Your Number" — Playfair Display 32px, white, centered
- Sub: "We sent a 6-digit code to +91 98765 43210" — DM Sans 16px, muted, centered
  "+91 98765 43210" is bolded white inline
- Phone number input (shown only on first step before OTP):
  Flag picker + country code prefix + number field
  
OTP INPUT (after number submitted):
- 6 separate square input boxes (48×56px each) spaced with 10px gap
- Active box: pink border glow + blinking cursor
- Filled box: white border, white digit, larger font 28px
- Error state: all boxes shake + turn red border
- Auto-advance to next box on digit input

- Countdown: "Resend code in 00:45" — muted text. After countdown: "Resend OTP" becomes a tappable pink link
- "Verify" gradient button — full width, 56px, activates when all 6 digits are filled
- Keyboard type: numericKeyboard, auto-shows on screen load

ANIMATION:
- OTP boxes appear with staggered scale-in animation (50ms delay each)
- Success: all boxes flash green → checkmark animation → navigate to next screen
- Error: haptic + shake animation on all boxes
```

---

## 06 — Login Screen

```
Design the login screen for ഇണ (Ina) dating app.

LAYOUT:
- Split design: top 35% is a full-width gradient panel (#E91E8C → #9B1FDB)
  with the ഇണ logo (white, 64px) and tagline "ഇണയെ കണ്ടെത്തൂ" (Find Your Soulmate) centered
- Bottom 65%: dark card (#0D0D0D) with rounded top corners (32px radius)
- "Welcome Back 👋" heading — Playfair Display Italic 30px, white
- "Sign in to continue your journey" — DM Sans 15px, muted #B0B0C3
- Email field (icon prefix, dark fill)
- Password field (icon prefix, eye toggle, dark fill)
- "Forgot Password?" — right-aligned, pink text link, 14px
- "Sign In" gradient button — full width, 56px
- Divider: "or"
- Social sign-in row: Google · Apple · Phone — outlined pill buttons
- Bottom: "New to ഇണ? Create Account" — centered, muted text with pink link

MICRO-INTERACTIONS:
- Shake animation + red border on wrong credentials
- Success: button shows loading spinner → checkmark → navigate
- Keyboard pushes the bottom card upward (bottom sheet behavior)
```

---

## 07 — Forgot Password Screen

```
Design a forgot password screen for ഇണ (Ina) dating app.

LAYOUT:
- Minimal, calm. Dark background.
- Back arrow top-left
- Centered illustration: envelope with a lock icon, rendered in pink gradient, 100px
- Heading: "Reset Password" — Playfair Display 32px, white
- Body: "Enter your email and we'll send you a reset link." — DM Sans 16px, muted, centered
- Email input field — dark fill, email icon prefix, pink active border
- "Send Reset Link" gradient button — full width, 56px
- After submit: success state replaces button with:
  - Green checkmark animation (Lottie)
  - "Email sent! Check your inbox." — success green text
  - "Back to Login" text link

STATES:
- Default: form visible
- Loading: button shows spinner
- Success: checkmark + success message
- Error (email not found): red inline error under field
```

---

## 08 — Profile Setup Step 1 — Basic Info

```
Design Step 1 of 5 of the profile setup wizard for ഇണ (Ina) dating app.

LAYOUT:
- Progress bar at top: 5-segment, segment 1 filled pink, others grey #2A2A3E. Height 4px.
- Step label: "Step 1 of 5 — Basic Info" — DM Sans 13px, muted
- Heading: "Tell us about yourself 😊" — Playfair Display Italic 30px, white
- Sub: "This helps us find your best matches" — DM Sans 15px, muted

FORM FIELDS (dark card inputs):
1. Display Name — text field, person icon
2. Date of Birth — date picker, shows computed age "You are 24 years old" below in green
   Red error if under 18: "You must be 18 or older to use ഇണ"
3. Gender — custom bottom sheet picker with illustrated icons:
   Man (blue silhouette), Woman (pink silhouette), Non-binary (purple), Other, Prefer not to say
   Selected gender card has pink border + soft glow
4. Sexual Orientation — dropdown: Straight, Gay, Lesbian, Bisexual, Pansexual, Prefer not to say
   (shown only after gender selected)

- "Next →" gradient button — full width, 56px, bottom of screen (sticks above keyboard)
- Each field has a smooth focus animation (label floats, pink border glow)

VISUAL DETAIL:
- Subtle dotted grid pattern on background (1% opacity pink dots)
- Section dividers are 1px #2A2A3E lines
- Emoji adds warmth — not childish, matches the romantic tone
```

---

## 09 — Profile Setup Step 2 — About You

```
Design Step 2 of 5 of the profile setup wizard for ഇണ (Ina) dating app.

LAYOUT:
- Progress: segment 2 of 5 filled
- Heading: "What makes you, you? ✨"
- Sub: "Your matches will see this on your profile"

COMPONENTS:

BIO SECTION:
- Multiline text area (5 lines visible), dark fill, rounded 14px
- Placeholder: "Write something that shows who you really are..."
- Character counter bottom-right: "142 / 500" — turns orange at 450, red at 500
- Soft gradient border on focus (pink)

INTERESTS SECTION:
- Label: "Your Interests" with info icon
- 3-column chip grid of 30+ interest tags:
  Row examples: 🎵 Music, 🎬 Movies, 🍳 Cooking, 🏋️ Gym, ✈️ Travel, 
  📚 Reading, 🎮 Gaming, 🌿 Nature, 🐾 Pets, 💃 Dancing,
  🎨 Art, ☕ Coffee, 🏊 Swimming, 🧘 Yoga, 🌙 Nightlife, etc.
- Unselected chip: dark fill #1A1A2E, border #2A2A3E, grey text
- Selected chip: gradient fill (#E91E8C→#FF6B6B), white text, no border, subtle shadow
- Selected chips slightly scale up (1.05x) with spring animation
- Max 10 selectable — when at 10, unselected chips dim to 40% opacity
- "Select up to 10" helper text below

RELATIONSHIP GOAL:
- Label: "I'm looking for..."
- 3 large illustrated option cards (horizontal row):
  * 💫 Serious Relationship
  * ✨ Casual Dating
  * 🤝 Friendship
- Selected card: pink border + check icon top-right + subtle background tint
- Unselected: dark border, no fill

- "Next →" button fixed at bottom
```

---

## 10 — Profile Setup Step 3 — More Details

```
Design Step 3 of 5 of the profile setup wizard for ഇണ (Ina) dating app.

LAYOUT:
- Progress: segment 3 filled
- Heading: "A few more things 📋"
- Sub: "Optional but helps find better matches"

FORM COMPONENTS:

Height Slider:
- Custom range slider from 140cm to 220cm
- Pink filled track, white thumb circle with shadow
- Value displayed large in center above slider: "174 cm" — Playfair Display 36px, pink
- Feet/inches equivalent shown below: "5'8\"" — muted, small
- Toggle: "cm / ft" switch to the right

Occupation:
- Text input field with search/suggestions
- Shows popular options as chips when tapped: Engineer, Doctor, Student, Designer, Teacher, etc.

Education:
- Bottom sheet dropdown: High School, Bachelor's, Master's, PhD, Trade School, Other

Languages Spoken:
- Multi-select chip picker (same style as interests)
- Pre-populated: Malayalam (selected by default), English, Hindi, Tamil, etc.
- Shows up to 6 visible, "+ More" to expand

Pronouns:
- Pill selector: He/Him, She/Her, They/Them, Other (custom input if Other selected)

- All fields marked "(Optional)" with subtle label
- "Next →" button fixed at bottom
- "Skip for now" text link above button (muted, 14px)
```

---

## 11 — Profile Setup Step 4 — Preferences

```
Design Step 4 of 5 of the profile setup wizard for ഇണ (Ina) dating app.

LAYOUT:
- Progress: segment 4 filled
- Heading: "Who are you looking for? 🔍"
- Sub: "These filter your discovery feed"

PREFERENCE CONTROLS:

Show Me (Gender preference):
- Multi-select pill row: Women, Men, Everyone
- Selected pills: gradient fill. Unselected: outlined.

Age Range:
- Dual-handle range slider
- Min: 18, Max: 60 (configurable)
- Both handles: pink circles with white border
- Range fill: gradient pink between handles
- Values shown above each handle: "22" and "32"
- Helper: "You'll see profiles aged 22 to 32"

Maximum Distance:
- Custom segmented control (not slider):
  5 km · 10 km · 25 km · 50 km · 🌍 Worldwide
- Selected segment: gradient background, white text, pill shape
- Unselected: dark background, muted text

Additional toggles (styled as card rows with switch):
- Show my distance to others: ON by default
- Show my age on profile: ON by default
- Receive proximity alerts: ON by default (info icon explaining this)

INFO CALLOUT BOX:
- Rounded card, border 1px pink at 40% opacity, pink tint background
- 💡 "You can change these anytime in Settings"

- "Next →" button fixed at bottom
```

---

## 12 — Profile Setup Step 5 — Photos

```
Design Step 5 of 5 of the profile setup wizard for ഇണ (Ina) dating app — the photo upload step.

LAYOUT:
- Progress: all 5 segments filled (celebrate this!)
- Heading: "Add your photos 📸"
- Sub: "Profiles with 3+ photos get 5x more matches"

PHOTO GRID:
- 2-column grid, 6 slots total (3 rows × 2 columns)
- Slot 1 (top-left, 1.5x height — featured slot):
  * Label: "Main Photo ⭐" in small pink text at bottom
  * If empty: dashed border pink, large "+" icon, "Add Main Photo" text
  * If filled: photo with gradient overlay at bottom, white checkmark badge top-right
- Slots 2–6 (standard size):
  * Empty: dashed border grey, "+" icon centered
  * Filled: photo with small delete "×" button top-right corner

- Tap empty slot → bottom sheet appears:
  Bottom sheet options: 📷 Take Photo | 🖼️ Choose from Gallery | ❌ Cancel

- Below grid:
  Progress indicator: "3 of 6 photos added" — dots
  Tip card: "✨ Tip: Your first photo is what people see first. Make it count!"

- MODERATION NOTICE (subtle):
  🛡️ "Photos are checked for community guidelines" — small, muted text with shield icon

- "Complete Profile 🎉" gradient button — full width, 56px
  Disabled until at least 1 photo added
  
SUCCESS STATE (after tapping Complete Profile):
- Full-screen success overlay:
  Lottie confetti animation
  "Your profile is ready! 🎉"
  "ഇണ-യ്ക്ക് സ്വാഗതം!" (Welcome to Ina!)
  "Start Discovering" button
```

---

## 13 — Discovery / Swipe Screen

```
Design the main discovery screen for ഇണ (Ina) dating app — the core swipe experience.

LAYOUT:
- Dark background #0D0D0D
- Top bar (no standard AppBar):
  Left: ഇണ logo (pink, 28px)
  Center: location indicator "📍 Kochi, Kerala" — DM Sans 14px, muted
  Right: filter icon (sliders) button — outlined circle 40px

CARD STACK:
- 3 cards visible in a stacked perspective (top card fully visible, 2 peeking behind)
- Card dimensions: 90% screen width, 70% screen height, rounded 28px
- Card content:
  * Full-bleed profile photo
  * Bottom gradient overlay (transparent → black 80%)
  * Over gradient: 
    - Name + Age "Anjali, 24" — Playfair Display Italic 30px, white
    - "📍 3 km away" — DM Sans 14px, white 80%
    - Interest chips row (3 max): small pill chips with emoji, frosted glass style
    - Compatibility teaser: "💫 8 interests in common"
  * Top-right: online indicator dot (green) if active in last 30 min

SWIPE INDICATORS (appear during swipe):
- Swipe Right → "LIKE" badge top-left of card (green border, white text, rotated -15°)
- Swipe Left → "NOPE" badge top-right of card (red border, white text, rotated 15°)
- Swipe Up → "SUPER ⭐" badge top-center (gold border + star, rotated 0°)

ACTION BUTTONS ROW (below card stack):
- 5 buttons in a row, centered:
  * Rewind ↩️ — small grey outlined circle, 44px (Premium only — greyed out for Free)
  * Pass ✕ — medium outlined circle, 56px, red icon
  * Super Like ⭐ — small outlined circle, 44px, gold icon + counter badge "1"
  * Like ❤️ — medium filled circle, 56px, gradient pink→coral
  * Boost ⚡ — small outlined circle, 44px, yellow icon (Premium)

SWIPE LIMIT INDICATOR (Free users):
- Small pill badge above buttons: "7 swipes left today"
- Turns orange at 3, red at 1

BOTTOM NAV:
- 5-tab bar, dark background #0D0D0D, thin top border #2A2A3E
- Active tab: pink icon + pink dot indicator beneath
- Icons: 🔍 Discover · ❤️ Matches · 💬 Chat · 🎁 Gifts · 👤 Profile
```

---

## 14 — Profile Card Full View

```
Design the full profile view that opens when a user taps a discovery card in ഇണ (Ina).

LAYOUT:
- Full screen modal sheet (slides up from bottom, drag-to-dismiss)
- Scrollable vertically

PHOTO GALLERY (top):
- Full-width swipeable photo gallery (PageView)
- Photo dots indicator at top (small white dots, active = white pill)
- Swipe photos left/right
- Back button (←) top-left over photo
- "..." more menu top-right over photo
- Gradient overlay at bottom of last photo transitioning to the content section

PROFILE INFO (below photos):
- Name + Age (large): "Ananya Krishnan, 26" — Playfair Display 32px, white
- Verified badge ✓ if verified (blue tick)
- "📍 4 km away · 🕐 Active recently" — muted row
- Relationship goal chip: "💫 Looking for Serious Relationship" — outlined pink chip

BIO SECTION:
- Section label "About Me" — DM Sans Semibold 14px, pink uppercase
- Bio text — DM Sans 16px, white/light, max 3 lines with "Read more" expansion

INTERESTS SECTION:
- Label "Interests" + count badge
- Chip grid: all interests displayed with emoji, 3-column wrap layout
- Shared interests highlighted with golden star ⭐ prefix: "⭐ Music" (you both like it)

DETAILS SECTION (icon rows):
- 🎓 Bachelor's in Computer Science
- 💼 Software Engineer at Infosys
- 📏 168 cm
- 🗣️ Malayalam, English
- 🏠 From Thrissur, Kerala

FIXED BOTTOM ACTION BAR (always visible, above scroll):
- Two large buttons side by side:
  Left: "✕ Pass" — outlined, rounded, dark background
  Right: "❤️ Like" — gradient fill, pink→coral
- Super Like button center above the two: ⭐ small, floating gold button
```

---

## 15 — Match Celebration Overlay

```
Design the match celebration overlay for ഇണ (Ina) dating app shown when a mutual match occurs.

LAYOUT:
- Full-screen overlay (appears over the discovery screen)
- Dark semi-transparent background (#0D0D0D at 90% opacity)
- Lottie confetti animation plays full-screen (colourful hearts + sparkles raining down)

CENTER CONTENT:
- "It's a Match! 💘" — Playfair Display Italic 42px, gradient text (pink→coral)
  Subtitle: "You and Meera both liked each other"

- Two profile photos side by side:
  * Current user photo — circular, 100px, pink glow border
  * Match's photo — circular, 100px, pink glow border
  * Small pink heart icon floating between them, pulsing animation
  * Photos animate: slide in from left and right, then bump together at center

- Match name banner below photos: "ഇണ found: Meera ✨" — DM Sans 18px, muted white

TWO ACTION BUTTONS:
- "💬 Send Message" — gradient fill, full width, 56px, pill
- "Keep Swiping →" — outlined, full width, 52px, muted border

MICRO-ANIMATION SEQUENCE:
1. 0ms: dark overlay fades in
2. 200ms: photos slide in from sides
3. 500ms: photos bump + heart pops with spring
4. 700ms: "It's a Match!" text scales in from 0.5 with bounce
5. 1000ms: confetti rains for 3 seconds
6. Buttons fade in at 1200ms

FEEL: Euphoric, celebratory, warm. This is the emotional peak of the app.
```

---

## 16 — Matched Profiles List

```
Design the matches screen for ഇണ (Ina) dating app.

LAYOUT:
- Dark background. Standard header: "ഇണകൾ" (Matches) — Playfair Display 26px, white
- Search bar below header: rounded, dark fill, 🔍 icon, "Search your matches..."

NEW MATCHES ROW (horizontal scroll, above message list):
- Label "New Matches ✨" — small, pink, DM Sans 13px
- Horizontal scrolling row of circular avatars (72px)
- Each: profile photo + name below (DM Sans 11px, white)
- Unread/new badge: small pink ring animation around avatar (pulsing)
- "+" at start of row = swipe more (links to Discovery)
- Empty slot message: "Keep swiping to get more matches!"

CONVERSATION LIST (below new matches):
- Each list item (80px height):
  * Left: circular avatar (56px) with online green dot if active
  * Center: 
    - Name (bold, DM Sans 16px, white) + verified tick if applicable
    - Last message preview (14px, muted) OR "Say hi! 👋" if no messages yet
    - Unread badge (pink circle with count) if unread
  * Right: timestamp ("2m ago", "Yesterday") — muted 12px
             + unread count badge

EXPIRING SOON INDICATOR:
- Matches expiring within 24h show a small red timer ⏰ badge on their avatar
- Tooltip on tap: "This match expires in 18 hours. Send a message!"

EMPTY STATE (if no matches yet):
- Illustration: two empty chairs facing each other, pink gradient
- "No matches yet" — Playfair Display 24px, white
- "Start swiping to find your ഇണ" — muted body text
- "Discover Now →" gradient button

UNMATCH:
- Swipe left on a conversation tile reveals a red "Unmatch" button
- Confirmation bottom sheet before unmatching
```

---

## 17 — Private Chat Screen

```
Design the private chat screen for ഇണ (Ina) dating app.

LAYOUT:

APP BAR:
- Back arrow ← (left)
- Profile photo (circular 40px) + name "Meera" (DM Sans Semibold 18px, white)
- Online indicator: green dot + "Active now" OR "Active 3h ago" — DM Sans 12px, muted
- Right icons: 📞 voice call, 📹 video call, ⋮ more menu

MESSAGE LIST (scrollable, newest at bottom):
- Date separators: "Today", "Yesterday", "14 Feb" — centered, pill label, dark fill, muted text
- RECEIVED message bubble:
  * Left-aligned, dark card #1A1A2E, rounded 18px (flat top-left)
  * DM Sans 16px, white text
  * Timestamp below-right: "2:34 PM" — muted 11px
- SENT message bubble:
  * Right-aligned, gradient fill pink→coral, rounded 18px (flat top-right)
  * White text
  * Timestamp + tick icons below-right: ✓ sent, ✓✓ delivered, 🔵✓✓ read

IMAGE MESSAGE:
- Rounded image (16px radius) inline in bubble
- Tap: full screen photo_view
  
STICKER MESSAGE:
- Lottie animation plays inline (120×120px), no bubble background
- Heart reaction appears below if reacted

EMOJI REACTION:
- Long press any message → reaction picker floats up (5 emoji: ❤️ 😂 😮 😢 👍)
- Selected reaction shows below message as small badge with count

INPUT BAR (fixed bottom, above keyboard):
- Dark fill #1A1A2E, top border 1px #2A2A3E
- Left: 😊 emoji button | 📎 attachment button
- Center: text input (expands up to 5 lines, rounded pill)
- Right: when text is empty → 🎁 gift/sticker button
         when text has content → ➤ send button (gradient circle, 40px)

TYPING INDICATOR:
- Animated 3-dot pulse in a received-style bubble: "Meera is typing..."
```

---

## 18 — Chat Sticker Picker Bottom Sheet

```
Design the sticker and gift picker bottom sheet for ഇണ (Ina) dating app chat.

LAYOUT:
- Bottom sheet, slides up 60% of screen height
- Drag handle at top center (40px wide, 4px tall, grey pill)
- Tab bar at top: [Stickers] [Gifts] [GIFs] — pill tabs, active = pink fill

STICKER PACK SECTION:
- Horizontal scrollable row of sticker pack icons (40px square) — pack selector
- Active pack indicator: pink underline
- Main grid: 4-column grid of sticker previews (70×70px each)
- Each sticker: Lottie animation plays on hover/tap
- Sticker categories: ❤️ Love, 😂 Funny, 🌹 Flowers, 🔥 Flirty, 🥺 Cute, 🎉 Celebrate
- Premium pack stickers: show lock icon overlay with golden shimmer
  Tap locked sticker → "Unlock with Gold subscription" tooltip

RECENT STICKERS:
- Top row: "Recently used" — horizontal scroll of last 8 used stickers

GIFT SECTION (2nd tab):
- Grid of virtual gift items: animated roses, hearts, teddy bear, chocolates, etc.
- Each item: animation preview + name + price in Sparks "💎 50 Sparks" or "Free"
- "Buy Sparks" button top-right if balance is low

SEND BUTTON:
- Appears as floating gradient button bottom-right when a sticker/gift is selected
- "Send 🎁" — fades in with scale animation
```

---

## 19 — Incoming Call Screen

```
Design the incoming call screen for ഇണ (Ina) dating app — shown as a full-screen overlay.

LAYOUT:
- Full screen. Blurred background (caller's profile photo blurred to fill screen)
- Dark overlay at 70% opacity over the blur

TOP SECTION:
- "ഇണ" app logo + "Incoming Call" — small, muted, DM Sans 14px, centered

CENTER:
- Caller's profile photo — circular, 120px, white border 3px, subtle pink glow pulsing
- Animated rings radiating outward from photo (3 rings, pink, fading in/out on repeat)
- Caller name: "Meera" — Playfair Display Italic 36px, white
- Call type indicator: 
  📹 "Video Call" OR 📞 "Voice Call" — DM Sans 16px, muted white

BOTTOM ACTION AREA:
- Two large action buttons, centered with space between:
  LEFT: Decline button — circular 72px, red fill (#FF4757), ☎️ rotated-45° white icon
         Label "Decline" below — DM Sans 12px, muted white
  RIGHT: Accept button — circular 72px, green fill (#00C896), ☎️ white icon
          Label "Accept" below — DM Sans 12px, muted white

- Buttons have ripple/ring animation (pulsing glow effect)

TIMER:
- "Call ends in 00:28" countdown at very bottom — muted, 13px

ANIMATION:
- Screen fades in over 400ms
- Profile photo rings pulse at 1.5 second intervals
- Slight vertical bounce on the photo (sine wave, subtle)

FEEL: Elegant, unmistakable. Like FaceTime but warmer and more romantic.
```

---

## 20 — Video Call Screen (Jitsi)

```
Design the video call screen overlay for ഇണ (Ina) dating app (wrapping Jitsi Meet SDK).

LAYOUT:
- Full screen video call
- Remote user (match): fills full screen (large video feed)
- Self preview: picture-in-picture, top-right corner, 120×160px, rounded 12px, draggable
- Self preview border: 2px pink when mic is unmuted, 2px grey when muted

TOP BAR (fades out after 3 seconds of no interaction, tap to show):
- Left: ← end-call back arrow
- Center: caller name "Meera 💗" + call timer "04:23"
- Right: ⋮ more options (switch to audio only, report)
- Background: top gradient dark overlay for readability

BOTTOM CONTROL BAR (always visible):
- Always docked at bottom, frosted glass background (dark, blur)
- 5 control buttons centered in a row:
  * 🔇 Mic toggle — circular 56px dark fill, white icon. Muted state = red fill
  * 📷 Camera toggle — circular 56px dark fill, white icon. Off state = red fill
  * 🔄 Flip camera — circular 48px, outlined
  * ☎️ End call — circular 64px, red fill (#FF4757), white phone-end icon
  * 📺 Switch audio/video — circular 48px, outlined

NETWORK INDICATOR:
- Top-left of remote video: WiFi bars icon showing connection quality
  - 3 bars green = excellent
  - 2 bars yellow = fair
  - 1 bar red = poor + "Connection unstable" toast

RECONNECTING STATE:
- Full overlay: "Reconnecting..." — pulsing text + spinner over frozen video frame

AUDIO-ONLY MODE:
- Remote video hidden, replaced by:
  Large circular profile photo of match (160px) with pulsing rings
  Audio waveform animation below photo
```

---

## 21 — Gift Shop Screen

```
Design the gift shop screen for ഇണ (Ina) dating app.

LAYOUT:
- Header: "🎁 Gift Shop" — Playfair Display 26px, white
  Right: Sparks balance "💎 150 Sparks" — pill badge, golden fill, DM Sans 14px bold

TAB BAR (below header):
- Horizontal tabs: All · Stickers · Roses · Hearts · Animated · Premium
- Active tab: pink bottom border + pink text

GIFT GRID (2-column):
Each gift card (card surface #1A1A2E, rounded 20px, shadow):
- Top: Lottie animation preview (auto-plays on loop) — 120px height
- Gift name: DM Sans Semibold 14px, white
- Price row:
  * Free: green "Free" badge
  * Paid: "💎 50 Sparks" in gold
  * Premium-only: lock icon 🔒 + "Gold Required" — muted text

FEATURED BANNER (top, full width):
- Gradient card (pink→purple): "💝 Valentine's Special Gifts — Limited Time"
- Animated sparkle effect on banner

SPARKS SHOP SECTION (bottom of list):
- Card with gradient: "Need more Sparks? 💎"
- Package options: 100 Sparks ($0.99) · 500 Sparks ($3.99) · 1500 Sparks ($9.99)
- Each: rounded card, amount bold, price muted below, "Buy" pill button

SEND GIFT FLOW:
- Tap gift → bottom sheet appears:
  * Gift animation plays large (200px)
  * "Send to Meera?" confirmation
  * "Add a message" optional text field
  * "Send Gift 🎁" gradient button
  * Sparks deducted shown: "💎 50 Sparks will be used"
```

---

## 22 — My Profile Screen

```
Design the personal profile screen for ഇണ (Ina) dating app (the logged-in user viewing their own profile).

LAYOUT:
- Header: "My Profile" — DM Sans Semibold 22px, white (left-aligned)
  Right: Edit ✏️ button (outlined pill)

PROFILE HEADER:
- Large profile photo (circular, 110px, centered) with pink glow ring
- Verified ✓ badge overlaid bottom-right of photo
- Name + Age: "Anjali Nair, 24" — Playfair Display 28px, white
- Location: "📍 Kochi, Kerala" — muted 14px
- "Preview Profile 👁️" — small outlined pill button (see how others see you)

PROFILE COMPLETION CARD:
- Gradient card (pink border, dark fill)
- "Complete your profile ✨ — 80% done"
- Linear progress bar: 80% filled pink
- "Add 2 more photos to get 3× more matches" — muted tip
- "Complete Now →" link

STATS ROW (3 cards in a row):
- Matches: 47 | Likes Received: 124 | Profile Views: 312
  Each: dark card, number bold pink, label muted below

PHOTO GALLERY PREVIEW:
- Horizontal scroll row of profile photos (80×80px rounded squares)
- Last slot = "+" add photo
- "Manage Photos" text link

ABOUT SECTION:
- Bio text (truncated to 3 lines)
- Interest chips (truncated, "+8 more" link)

PREMIUM UPSELL BANNER (for Free users):
- Full-width card: gradient gold shimmer
- "⭐ Upgrade to Gold — See who liked you + unlimited swipes"
- "View Plans" button

BOTTOM SECTION:
- Account actions: Edit Preferences, Privacy Settings, Notification Settings, Help & Support
- "Pause Profile" toggle (Snooze Mode)
- "Delete Account" — muted red text link at very bottom
```

---

## 23 — Edit Profile Screen

```
Design the edit profile screen for ഇണ (Ina) dating app.

LAYOUT:
- Back arrow ← + "Edit Profile" title + "Save" button (pink, top-right)
- Scrollable form sections separated by subtle dividers

PHOTO SECTION (top):
- 2-column photo grid (6 slots) — same design as Profile Setup Step 5
- Drag-to-reorder enabled: long-press a photo to grab, drag to new position
- Photos have a drag handle icon (⋮⋮) when in edit mode

FORM SECTIONS (grouped card-style, dark #1A1A2E):

Section "Basic":
- Display Name (editable)
- Bio (text area with character count)
- Date of Birth (read-only after registration — show "Contact support to change")

Section "Interests":
- Chip grid (same as setup step 2, currently selected highlighted)

Section "Details":
- Height slider
- Occupation text
- Education dropdown
- Languages multi-select
- Pronouns pills

Section "Preferences":
- Show me (gender) pills
- Age range slider
- Distance dropdown
- Toggles: show distance, show age

SAVE BEHAVIOR:
- "Save" button in header becomes active (pink) on any change
- Unsaved changes warning if user tries to navigate back
- Success toast: "Profile updated ✓" — green, slides in from bottom
```

---

## 24 — View Other's Profile

```
Design the public profile view screen for ഇണ (Ina) dating app — what you see when viewing another user's profile.

This is similar to Screen 14 (Full Profile Card View) but with different action buttons since this is viewed from the chat or matches list rather than the discovery swipe deck.

LAYOUT:
- Full-screen modal or navigation push
- Back button top-left
- "⋮" more menu top-right: Report User, Block User

PHOTO GALLERY:
- Full-width swipeable photos with dot indicators

PROFILE CONTENT (scrollable, same structure as Screen 14):
- Name, age, verified badge
- Distance + activity status
- Bio
- Shared interests highlighted ⭐
- All details (education, job, height, languages)

ACTION BAR (bottom, fixed — replaces the Like/Pass buttons):
Different based on relationship:
- If NOT matched yet: "❤️ Like" + "✕ Pass" buttons (same as discovery)
- If MATCHED: "💬 Message" gradient button (full width) + "📞 Call" outlined button
- If already chatting: "💬 Open Chat" gradient button

MUTUAL INTERESTS CALLOUT:
- If 5+ shared interests: special highlighted card:
  "🌟 You have 8 interests in common!"
  Shows the shared interest chips in a mini grid
```

---

## 25 — Subscription / Premium Screen

```
Design the premium subscription screen for ഇണ (Ina) dating app.

LAYOUT:
- Dark background with subtle golden shimmer gradient at top (#FFD93D at 8% opacity)
- Header: ← back button + "ഇണ Premium" title
- Crown icon 👑 + "Unlock Your Full Potential" — Playfair Display Italic 28px, white

BILLING TOGGLE:
- "Monthly / Annual" toggle pill — switch between pricing
- Annual shows: "-40%" badge in red + "Best Value" label

PLAN CARDS (3 cards, vertically stacked):

FREE CARD:
- Dark fill, thin grey border
- "Free" — bold, 24px
- Feature list with ✓ / ✗ icons:
  ✓ 10 swipes/day · ✓ Basic matching
  ✗ Unlimited swipes · ✗ Video calls · ✗ See who liked you
- "Current Plan" grey pill button

GOLD CARD (highlighted — "Most Popular"):
- Gradient border (pink→coral) with glow
- "⭐ Gold" — pink bold, 28px
- "$9.99/month" — large, white · "$5.99/month" (annual shown smaller, muted strikethrough)
- Feature list all ✓:
  ✓ Unlimited swipes ✓ Video & Voice Calls
  ✓ See who liked you ✓ 1 Boost/month ✓ Read receipts
- "Get Gold ⭐" gradient button — full width, pink→coral
- "Most Popular" badge top-right corner — gold pill

PLATINUM CARD:
- Darker gradient border (gold shimmer)
- "💎 Platinum" — gold bold, 28px
- "$19.99/month"
- All Gold features + Priority discovery, unlimited boosts, all sticker packs
- "Get Platinum 💎" button — dark gold fill

COMPARISON TABLE:
- Below cards: expandable "Compare all features" link
- Opens a full feature comparison table

BOTTOM:
- "Restore Purchases" text link
- "Terms · Privacy" links — tiny, muted
- Payment badges: Apple Pay, Google Pay icons
```

---

## 26 — Paywall Bottom Sheet

```
Design the paywall bottom sheet for ഇണ (Ina) dating app — shown when a Free user tries a Premium feature.

LAYOUT:
- Bottom sheet, 65% screen height, rounded top 28px
- Dark fill #1A1A2E
- Drag handle at top

CONTENT:
- Feature icon (the specific blocked feature): e.g., 📹 (for video calls) — 56px, centered, gradient background circle
- Locked feature name: "Video & Voice Calls" — DM Sans Bold 22px, white
- Short benefit: "Meet your match face-to-face before meeting in person" — muted 15px
- Plan recommendation badge: "Available in ⭐ Gold and above"

MINI PLAN COMPARISON (2 columns):
- Gold: "$9.99/mo" + bullet list of 4 key features
- Platinum: "$19.99/mo" + bullet list with "includes Gold +"

TWO BUTTONS:
- "Upgrade to Gold ⭐" — gradient full width, 56px
- "See All Plans" — outlined, full width, 52px, muted

DISMISS:
- "Maybe later" text link at very bottom — small, muted grey
- Swipe down to dismiss

ANIMATION:
- Sheet slides up with spring (overshoot slightly then settle)
- Feature icon does a small bounce on appear
```

---

## 27 — Notification Settings Screen

```
Design the notification settings screen for ഇണ (Ina) dating app.

LAYOUT:
- Back arrow + "Notifications" title
- Dark background. Grouped settings list.

MASTER TOGGLE (top card):
- "Push Notifications" — DM Sans Semibold 18px, white
- Large toggle switch (right side) — pink when ON, grey when OFF
- Sub-text when OFF: "Turn on to never miss a match" — muted 13px

NOTIFICATION CATEGORIES (grouped card sections):

Section "Matches & Discovery":
- 🎉 New Matches — toggle ON
- 👋 Likes & Super Likes — toggle ON
- 📍 Someone Nearby — toggle ON + "ℹ️ info" link explaining proximity

Section "Messages":
- 💬 New Messages — toggle ON
- 🎁 Gifts Received — toggle ON

Section "Calls":
- 📞 Incoming Calls — toggle ON (note: "Turning off will miss calls")

Section "App Updates":
- 📢 Promotions & Offers — toggle OFF (default)
- 🔔 App Updates — toggle ON

EACH ROW STYLE:
- Icon (left, 40px rounded square with category color fill)
- Label (DM Sans 16px, white)
- Sub-label (DM Sans 13px, muted) — what the notification does
- Toggle switch (right, pink/grey)

BOTTOM NOTE:
- 📱 "Notifications are also controlled by your device settings"
  "Open Device Settings →" — pink link
```

---

## 28 — App Settings Screen

```
Design the main settings screen for ഇണ (Ina) dating app.

LAYOUT:
- Back arrow + "Settings" title
- Scrollable grouped list on dark background

USER HEADER (top card):
- Profile photo (circular 64px) + Name + Email/Phone
- "Edit Profile →" pink link

SETTINGS GROUPS:

Group "Account":
- 🔒 Privacy Settings →
- 🔔 Notification Settings →
- 🌍 Language (shows current: "Malayalam") →
- 📍 Location Settings →

Group "Subscription":
- ⭐ My Plan (shows tier: "Free" or "Gold") →
- 💎 Buy Sparks →
- 🧾 Purchase History →
- 🔄 Restore Purchases →

Group "Safety":
- 🛡️ Block List →
- 🚨 Safety Tips →
- 📋 Community Guidelines →

Group "Support":
- ❓ Help Centre →
- 💬 Contact Support →
- ⭐ Rate ഇണ on App Store →

Group "Legal":
- 📄 Terms of Service →
- 🔏 Privacy Policy →

DANGER ZONE:
- "Pause Profile (Snooze)" — toggle switch
  Shows: "Your profile won't appear in discovery while snoozed"
- "Delete Account" — red text, 16px
  Tap → confirmation bottom sheet with consequences listed

App version at very bottom: "ഇണ v1.0.0 · Made with ❤️ in Kerala"
```

---

## 29 — Report / Block Screen

```
Design the report and block flow for ഇണ (Ina) dating app.

ENTRY: Accessed from the "⋮" menu on any profile or within a chat.

STEP 1 — Choose Action (Bottom Sheet):
- "⚠️ Report [Name]" — red text with flag icon
- "🚫 Block [Name]" — dark, block icon
- Cancel — grey text

STEP 2A — Report Reason (if Report chosen):
- Full screen or modal sheet
- Title: "Why are you reporting Meera?"
- Reason list (single select, radio):
  * Fake profile / Impersonation
  * Inappropriate photos
  * Harassment or spam
  * Scam or fraud
  * Underage user
  * Other (shows text input)
- Each reason: row with radio button + description
- Selected: pink radio, row background tint
- "Add details (optional)" — text area below list, dark fill
- "Submit Report" red button + "Cancel" text link

STEP 2B — Block Confirmation (if Block chosen):
- Centered illustration: shield icon
- "Block Meera?" — bold 22px
- Consequences explained:
  ✓ They won't see your profile
  ✓ Your chats will be removed
  ✓ They won't be shown in your discovery
- "Block" red button + "Cancel" outlined button

CONFIRMATION STATE:
- Success overlay: shield checkmark animation
- "Report submitted. Our team will review it within 24 hours." — for reports
- "Meera has been blocked." — for blocks
- Auto-dismisses after 2 seconds → returns to previous screen
```

---

## 30 — Empty States

```
Design 3 empty state screens for ഇണ (Ina) dating app. Each should feel warm and encouraging, not cold.

EMPTY STATE 1 — No More Profiles in Discovery:
- Illustration: a telescope looking at stars, pink gradient sky
- Heading: "You've seen everyone nearby! 🔭"
- Body: "We're looking for more people in your area. Check back soon or expand your distance."
- Two action buttons:
  * "Expand Distance 📍" — gradient, full width
  * "Invite a Friend 👫" — outlined, full width
- Soft particle animation in background (slow floating dots)

EMPTY STATE 2 — No Matches Yet:
- Illustration: two empty chairs with a candle on a table between them, romantic, pink tones
- Heading: "No matches yet 💫"
- Body: "Your perfect ഇണ is out there. Keep swiping and let the magic happen!"
- "Start Discovering →" gradient button

EMPTY STATE 3 — No Messages:
- Illustration: an empty chat bubble with a small heart inside
- Heading: "Start the conversation! 💬"
- Body: "You have matches waiting. Don't be shy — say hi! 👋"
- "See My Matches →" gradient button

VISUAL STYLE FOR ALL:
- Illustrations use the pink-coral-purple brand palette
- Soft, rounded, friendly illustration style (not flat, not 3D — somewhere in between)
- Subtle looping Lottie animation on the illustration
- White text headings, muted body text
- Dark background with very subtle gradient blob
```

---

## 31 — Swipe Limit Reached Screen

```
Design the swipe limit reached state for ഇണ (Ina) dating app (Free tier, 10 swipes/day used up).

LAYOUT:
- Shown as an overlay bottom sheet over the discovery screen (cards are blurred behind)
- 70% screen height, rounded top 28px, dark fill #1A1A2E

CONTENT:
- Lottie animation: hourglass flipping, pink gradient
- Heading: "You've used all your swipes today ⏰"
- Body: "Free members get 10 swipes per day. Resets at midnight."
- Countdown timer: "Resets in 06:42:18" — large, monospace font, pink — counting down live

UPGRADE UPSELL:
- Separator line with "or"
- "Get Unlimited Swipes with Gold ⭐"
- Mini feature bullets:
  ⚡ Unlimited swipes every day
  👀 See who liked you
  📹 Video & voice calls
- "Upgrade to Gold" gradient button — full width, 56px
- "$9.99/month · Cancel anytime" — tiny muted text below button

- "Come back tomorrow" text link at bottom — muted, dismisses the sheet

FEEL: Not punishing. Friendly, warm, with a clear value proposition.
```

---

## 32 — Admin Panel Dashboard

```
Design the admin dashboard for ഇണ (Ina) dating app admin panel built with Next.js and Tailwind CSS.

LAYOUT: Desktop web UI. Sidebar left + main content right.

SIDEBAR (240px wide, dark #0D0D0D):
- Top: ഇണ logo (white, 32px) + "Admin Panel" label
- Nav items (icon + label, 48px rows):
  📊 Dashboard (active — pink left border + pink text)
  👥 Users
  🛡️ Moderation
  💳 Subscriptions
  🎁 Gift Catalogue
  📢 Push Campaigns
  ⚙️ Settings
- Bottom: admin avatar + email + "Logout" button

MAIN CONTENT (light dark #111827 background):

TOP HEADER BAR:
- "Good morning, Admin 👋" — DM Sans 22px
- Date + "Refresh" button right

KPI CARDS ROW (4 cards):
- Total Users: "102,483" — large bold, green up arrow "+1.2% today"
- Daily Active: "14,821" — large bold, muted trend line sparkline
- Active Matches: "6,204" — large bold
- Today's Revenue: "$842" — large bold, gold color

CHARTS ROW:
- Left (60%): Line chart — 30-day DAU with pink line, grid, tooltip on hover
- Right (40%): Donut chart — Free vs Gold vs Platinum subscribers with legend

RECENT ACTIVITY TABLE:
- Last 10 new user registrations: avatar, name, email, join time, tier badge
- Columns sortable
- "View All Users →" link

MODERATION ALERTS:
- Red badge card: "🚨 12 images pending review" + "Review Now" button

FEEL: Dark, data-dense but clean. Inspired by Vercel/Linear dashboard aesthetics.
Typography: DM Mono for numbers, DM Sans for labels.
```

---

## 33 — Admin Panel — User Management

```
Design the user management screen for ഇണ (Ina) admin panel (Next.js, Tailwind, shadcn/ui).

LAYOUT: Same sidebar as Screen 32.

HEADER:
- "Users" title + total count "102,483 total"
- Right: search input + filter dropdown (by tier, by status) + "Export CSV" button

DATA TABLE:
- Columns: [Avatar + Name] [Email] [Age] [Tier] [Joined] [Status] [Actions]
- Avatar: circular 36px photo
- Tier badge: "Free" grey · "Gold" gold · "Platinum" purple
- Status badge: "Active" green · "Suspended" orange · "Banned" red
- Actions column: "View" link · "⋮" dropdown (Suspend 7d / Suspend 30d / Ban / Delete)

ROW HOVER STATE:
- Subtle background highlight #1A1A2E

PAGINATION:
- "Showing 1–20 of 102,483" with page navigation arrows and page size selector

USER DETAIL DRAWER (opens on "View" click):
- Right-side drawer (400px wide, slides in)
- Profile photo + name + all profile data
- Subscription history timeline
- Report history list
- Admin action history log
- Action buttons: Suspend / Ban / Delete / Close Drawer

SEARCH:
- Real-time search by name or email
- Debounced 300ms, results highlight matched text
```

---

## 34 — Admin Panel — Moderation Queue

```
Design the content moderation queue screen for ഇണ (Ina) admin panel.

LAYOUT: Same sidebar. Main content split into two panels.

LEFT PANEL — Queue List (380px):
- Header: "Moderation Queue" + badge "23 pending"
- Tab bar: "Images (18)" | "Profiles (3)" | "Chats (2)"
- Each queue item card (80px):
  * Thumbnail (if image) or avatar (if profile)
  * Report type: "NSFW Detected" or "User Reported" — small badge
  * Reported at: "2 minutes ago"
  * Priority badge: "High" red / "Medium" orange
- Selected item: highlighted blue-left border

RIGHT PANEL — Review Area:
- For Image Review:
  * Full size image (max 400px) displayed
  * TFLite score bar: "NSFW Score: 0.82" — red progress bar
  * Uploader info: avatar + name + join date + report history count
  * Moderator notes input field
  * Action buttons:
    ✓ "Approve Image" — green outlined button
    🗑️ "Remove Image" — red button
    🚫 "Suspend User (7 days)" — orange
    ⛔ "Ban User" — dark red
- For Profile Report:
  * Full profile preview (name, photos, bio)
  * Report reason + reporter info
  * Same action buttons

AUDIT LOG (below action buttons):
- "Last action: approved by admin@spark.app · 3 mins ago"

KEYBOARD SHORTCUTS:
- ← → navigate queue items | A = approve | D = remove | S = suspend
```

---

## Design System Reference (All Screens)

```
SPACING SYSTEM: 4px base grid
  xs: 4px | sm: 8px | md: 16px | lg: 24px | xl: 32px | 2xl: 48px | 3xl: 64px

BORDER RADIUS:
  Button (pill): 9999px
  Card: 24px
  Input field: 14px
  Avatar: 9999px (circle)
  Chip/badge: 20px
  Bottom sheet: 28px top-only
  Image: 16px

SHADOWS:
  Card: 0 20px 60px rgba(233, 30, 140, 0.15)
  Button: 0 8px 24px rgba(233, 30, 140, 0.40)
  Input (focused): 0 0 0 3px rgba(233, 30, 140, 0.25)
  Modal: 0 -10px 40px rgba(0, 0, 0, 0.50)

ANIMATION TIMINGS:
  Instant: 100ms (feedback taps)
  Fast: 200ms (micro-interactions)
  Normal: 300ms (transitions)
  Slow: 500ms (page transitions)
  Spring: duration 600ms, damping 0.7 (cards, modals)

TYPOGRAPHY SCALE:
  Display: 42px — Playfair Display Italic (match celebration, hero headings)
  H1: 32px — Playfair Display Bold (screen titles)
  H2: 26px — Playfair Display (section headers)
  H3: 22px — DM Sans Bold (card titles, names)
  Body Large: 18px — DM Sans Regular
  Body: 16px — DM Sans Regular (default)
  Body Small: 14px — DM Sans Regular (secondary info)
  Caption: 12px — DM Sans Regular (timestamps, legal)
  Micro: 11px — DM Sans Regular (badges, tags)

DARK MODE COLORS (default):
  Background 1: #0D0D0D (screen background)
  Background 2: #111827 (admin panel)
  Surface 1: #1A1A2E (cards)
  Surface 2: #2A2A3E (inputs, dividers)
  Border: #2A2A3E
  Border Active: #E91E8C
  Text Primary: #FFFFFF
  Text Secondary: #B0B0C3
  Text Muted: #6B6B8A

ICON SYSTEM: Phosphor Icons (free, open-source)
ILLUSTRATION STYLE: Soft-gradient vector, rounded forms, romantic theme
LOTTIE ANIMATIONS: LottieFiles.com free library + custom brand animations
```

---

*Last updated: February 22, 2026 — v1.0*
*Reference: PRD.md · AGENT.md · PROMPT.md*
*App: ഇണ (Ina) — Find Your Soulmate*
