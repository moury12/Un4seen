# Un4seen — Rider Community & Syndicate Mobile App

**Un4seen** is a mobile application built for motorcycle enthusiasts, riders, and Syndicate members. The platform connects passionate bikers through real-time communication, custom bike showcases, interactive competitions, weekly giveaways, story sharing, and an integrated **Shred Points** rewards economy.

---

## 📑 Table of Contents

- [Architecture & Tech Stack](#-architecture--tech-stack)
- [Authentication & User Onboarding](#-authentication--user-onboarding)
- [Key Features](#-key-features)
  - [1. Shred Points & Rewards Economy](#1-shred-points--rewards-economy)
  - [2. User Profile & Bike Garage](#2-user-profile--bike-garage)
  - [3. Official Announcements & Admin Stories](#3-official-announcements--admin-stories)
  - [4. Real-Time Stories (Instagram-style Editor)](#4-real-time-stories-instagram-style-editor)
  - [5. Chat & Community Channels](#5-chat--community-channels)
  - [6. Competitions](#6-competitions)
  - [7. Weekly Giveaways](#7-weekly-giveaways)
  - [8. Rate My Ride & Home Feed](#8-rate-my-ride--home-feed)
  - [9. Test Rider Program, Orders & Shop](#9-test-rider-program-orders--shop)
- [Project Directory Structure](#-project-directory-structure)
- [Automated Deployment with Fastlane](#-automated-deployment-with-fastlane)
  - [Git Production Workflow](#git-production-workflow)
  - [iOS Deployment (TestFlight & App Store)](#ios-deployment-testflight--app-store)
  - [Android Deployment (Internal & Production)](#android-deployment-internal--production)
- [Environment & Setup Guide](#-environment--setup-guide)

---

## 🛠 Architecture & Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (Dart SDK `^3.10.7`)
- **State Management & Dependency Injection**: [GetX](https://pub.dev/packages/get)
- **Navigation & Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Networking & API**: [Dio](https://pub.dev/packages/dio)
- **Real-Time Communication**: [Socket.io Client](https://pub.dev/packages/socket_io_client)
- **Push Notifications**: Firebase Core, Firebase Messaging & Flutter Local Notifications
- **Media & Editing**: `pro_image_editor`, `image_picker`, `image_cropper`, `video_player`, `just_audio`
- **CI/CD & Release Automation**: [Fastlane](https://fastlane.tools)

---

## 🔐 Authentication & User Onboarding

> **Important**: There is no public user registration inside the mobile app.

1. **Web-Based Membership Registration**:
   - Users join the Syndicate or community via the official Un4seen website.
   - The admin/backend creates the account and emails credentials (login email & generated password) to the user.
2. **In-App Login**:
   - Users sign in using the emailed credentials.
3. **Password Management**:
   - Users can update their password anytime inside the app (`Profile > Change Password`).
   - If forgotten, users can reset their password via email OTP verification.
4. **Profile & Ride Setup**:
   - On first login, members complete their profile (Country, Date of Birth, Bio, Avatar) and set up their primary motorcycle specs.

---

## 🚀 Key Features

### 1. Shred Points & Rewards Economy
The app features an integrated gamified points ecosystem called **Shred Points**:
- **Daily Login Bonus**: Claim daily reward points just by opening the app.
- **Profile Completion Bonus**: Instant +100 point reward upon completing 100% of user and ride setup.
- **Social Proof Submissions**: Users post Un4seen content on **Facebook**, **Instagram**, or **TikTok**, upload proof (screenshot + post link) in the app, and receive verified Shred Points upon admin approval.
- **Refer & Earn**: Share a personalized referral code; earn points for each invited rider.
- **Milestones**:
  - **Individual Milestones**: Unlock tiers as your personal points stack up.
  - **Community Milestones**: Collective member targets unlocking community-wide prizes.
- **Shopify Reward Redemption**: Convert earned Shred Points directly into exclusive **Shopify Discount Codes** to spend on official Un4seen merchandise and parts.

---

### 2. User Profile & Bike Garage
- **Member Overview**: Displays member number, total Shred Points, follower count, following count, and Syndicate status badge.
- **Bike Profile (Garage)**:
  - Add and showcase multiple motorcycles with photos, make, model, year, and detailed modification lists.
  - Explore community bike profiles, save favorite builds, and view individual member profiles.
  - Dedicated **Bike Gallery** per vehicle.

---

### 3. Official Announcements & Admin Stories
- Official announcements created directly by admins are featured in the app and profile views.
- **Interactive Multimedia**: Supports video players and high-resolution photo cards.
- **Background Music**: Announcements can feature tagged music tracks and categories.
- **Engagement**: Users can like (heart), save/bookmark announcements, and see countdown timers for time-sensitive news.

---

### 4. Real-Time Stories (Instagram-style Editor)
- **Create & Post Stories**: Post real-time photo/video stories to the rider feed.
- **Rich In-App Image Editor (`pro_image_editor`)**:
  - Creative filters, brush/drawing tools, text captions, and crop/rotate tools.
  - Select and attach background audio tracks with category selectors.
- **Viewing & Expiration**: Stories expire automatically, with options for bookmarking and saving highlights to user profiles.

---

### 5. Chat & Community Channels
- **Real-Time Engine**: Powered by WebSockets (`socket_io_client`).
- **Channels & Groups**: Public and interest-based topic channels.
  - Users can request new channels (`+Create a Channel - Admin Approval Required`).
- **Builds & Mods Discussions**: Specialized channel categories for motorcycle modifications, build advice, and technical discussions.
- **1-on-1 Direct Messaging**: Private conversations with fellow riders.
- **Admin Support Chat**: Direct real-time line to Un4seen official support.

---

### 6. Competitions
- **Admin-Managed Contests**: Competitions created and scheduled by admins (Active, Upcoming, and Ended).
- **Design, Upload, Vote, Win**:
  - Riders upload build designs, bike pictures, or custom modifications.
  - Community members vote on entries in the **Entries Gallery**.
  - Winners are awarded points, prizes, and spotlight features.

---

### 7. Weekly Giveaways
- **52 Weeks of Prizes**: Ongoing weekly giveaway draws (e.g. drawn every Friday).
- **Automated Participation**: Syndicate members and eligible point-holders are entered into prize pools.
- **Live & Past Results**: View active weekly giveaway prizes, countdown timers, and past winners.

---

### 8. Rate My Ride & Home Feed
- **Rate My Ride**:
  - Riders upload photos of their bikes and modifications.
  - Community members review and submit ratings on bikes.
  - Weekly cycles end every Sunday; admins evaluate top-rated submissions to crown winners.
  - Track individual submissions under **My Ride Uploads**.
- **Home Feed Highlights**:
  - **Bike of the Week** spotlight.
  - **Weekly Winners** showcase.
  - Quick action links: Un4seen World, Crew Choice, Ideas & Feedback, and Shop.

---

### 9. Test Rider Program, Orders & Shop
- **Test Rider Program**: Apply and qualify to become official gear/bike test riders for upcoming Un4seen releases.
- **Orders & Merchandise**: Integrated store for apparel, motorcycle gear, and accessories with Shopify order tracking.

---

## 📁 Project Directory Structure

```text
lib/
├── main.dart                               # App entry point & global initializations
├── src/
│   ├── core/                               # Core utilities, services, routes, theme & reusable widgets
│   │   ├── routes/                         # GoRouter configuration (app_router.dart, app_routes.dart)
│   │   ├── services/                       # ApiService (Dio), Storage, Notification services
│   │   ├── theme/                          # Colors, gradients, typography
│   │   └── widgets/                        # CustomButton, CustomTextField, CustomScaffold, etc.
│   └── features/
│       ├── auth/                           # Login, OTP verification, Reset password, Splash
│       ├── bike_profiles/                  # Garage, Add bike, Bike gallery, Member bike details
│       ├── chat/                           # Channels, 1-on-1 chat, Support chat, Socket controllers
│       ├── competitions/                   # Active/upcoming competitions, Entries gallery
│       ├── giveaway/                       # Weekly giveaways, Winner showcase
│       ├── home/                           # Home feed, Rate My Ride, Crew Choice, Ideas/Feedback
│       ├── navigation/                     # Bottom navigation bar controller & wrapper
│       ├── orders/                         # Order history & status
│       ├── points/                         # Shred points dashboard, Milestones, Proof submissions, Redemptions
│       ├── profile/                        # User profile, Settings, Announcements, Test Rider program
│       └── stories/                        # Post story with Pro Image Editor, Story viewer, Audio picker
```

---

## 🚀 Automated Deployment with Fastlane

The project uses Fastlane for automated build, signing, versioning, and deployment to Apple TestFlight, App Store, and Google Play.

### Git Production Workflow

When preparing a release branch:
```bash
git checkout -b production
git push origin production
```

---

### iOS Deployment (TestFlight & App Store)

*TestFlight Public Link*: [https://testflight.apple.com/join/F9cp7b39](https://testflight.apple.com/join/F9cp7b39)

From the project root:
```bash
cd ios
```

#### 1. Upload Beta to TestFlight
Automatically fetches the latest build number from TestFlight, increments it, signs with Match, builds the `.ipa`, and uploads to TestFlight:
```bash
fastlane beta
```

#### 2. Release to App Store Production
Builds and releases directly to App Store review:
```bash
fastlane production
```

---

### Android Deployment (Internal & Production)

From the project root:
```bash
cd android
```

#### 1. Upload to Google Play Internal Testing
Fetches the current version code from Google Play, increments it, builds the release App Bundle (`.aab`), and uploads to the Internal track:
```bash
fastlane internal
```

#### 2. Release to Google Play Production
Builds and uploads directly to the live production track with a 100% rollout:
```bash
fastlane production
```

#### 3. Promote Internal to Production
Promotes an already uploaded and tested Internal track build directly to Production without re-compiling:
```bash
fastlane promote_to_production
```

---

## ⚙️ Environment & Setup Guide

1. **Prerequisites**:
   - Flutter SDK `^3.10.7` or later
   - Xcode (for iOS builds, macOS required) & CocoaPods
   - Android Studio / Android SDK (for Android builds)
   - Fastlane installed (`brew install fastlane` or `gem install fastlane`)
   - App Store Connect API Key (`AuthKey_WNSMV275TJ.p8`) configured in `ios/`
   - Google Play API Service Account JSON key configured in `android/`

2. **Installation**:
   ```bash
   flutter pub get
   cd ios && pod install && cd ..
   ```

3. **Run in Development**:
   ```bash
   flutter run
   ```

---

## 🍎 App Store Submission & Review Notes

To prevent common Apple App Store rejections (such as Guidelines **2.1 App Completeness**, **3.1 Payments/Points**, **1.2 UGC Safety**, and **5.1 Privacy**), copy and customize the following information in **App Store Connect > App Review Information**:

### 📋 App Review Notes (Copy & Paste for Apple Review Team)

```text
Dear Apple Review Team,

Thank you for reviewing the Un4seen mobile application. Below is essential context regarding how the app works, its authentication model, and feature compliance:

1. ACCOUNT CREATION & AUTHENTICATION (Guideline 2.1):
   - Un4seen is an exclusive companion mobile application for registered members of the Un4seen Moto Syndicate / community.
   - Member accounts are registered and provisioned through our official web portal (un4seen.com). Once an account is provisioned, login credentials (username/email and temporary password) are securely emailed to the member.
   - Users can log in directly using the provided credentials, update their password in the app, or use the email OTP password recovery feature.
   
   DEMO CREDENTIALS FOR REVIEW:
   - Email: reviewer@un4seen.com (or your active demo account)
   - Password: [DemoPassword123!]
   - Note: This demo account is pre-populated with active bike profiles, story entries, chat channels, and Shred Points for full review.

2. SHRED POINTS & REWARD SYSTEM (Guideline 3.1):
   - Shred Points are a free, gamified loyalty reward system earned purely through active engagement (daily app opens, completing profile info, sharing on social channels, and community milestones).
   - Points CANNOT be purchased with real money and do not bypass Apple In-App Purchases.
   - Points are redeemable for promotional discount codes for physical merchandise on the external Un4seen Shopify web store.

3. RATE MY RIDE & COMPETITIONS (Guideline 5.3):
   - "Rate My Ride" and "Competitions" are community-driven voting and showcase features where members vote on bike builds and custom modifications.
   - They are free to participate in, based on skill/customization voting, and do not constitute gambling or paid sweepstakes.

4. USER GENERATED CONTENT & SAFETY (Guideline 1.2):
   - All user-generated content (Stories, Rate My Ride posts, and Chat) includes content reporting and user blocking mechanisms.
   - Terms of Use (EULA) and Privacy Policy are accessible directly in the app before and after authentication.

5. PERMISSIONS & USAGE:
   - Camera & Photo Library: Used solely for capturing/uploading photos of motorcycles for bike profiles, story posts, and proof of social sharing.

Please let us know if any additional details or test environments are needed.
```

### 📝 App Store Metadata Suggestions

- **App Name**: `Un4seen`
- **Subtitle**: `Rider Community, Garage & Perks`
- **Keywords**: `motorcycle,bikes,rider community,moto,rate my ride,bike garage,custom bikes,shred points`
- **Category**: `Lifestyle` or `Sports` (Secondary: `Social Networking`)