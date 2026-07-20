# RideOn - Bike & Scooter Rental Marketplace

RideOn is a modern Flutter application that simulates a Bike & Scooter Rental Marketplace. It includes user authentication, product browsing, search, sorting, detailed product pages, and a complete booking flow. The application is built using clean architecture principles with Provider for state management and Material 3 design.

---

# Features

### Authentication
- Mobile Number Login
- Dummy OTP Verification (`123456`)
- Login Session Persistence using SharedPreferences
- Auto Login via Splash Screen
- Logout Support

### Home Screen
- Fetches products from Fake Store API
- Bike Image
- Bike Name
- Rental Price per Day
- Rating
- Availability Status
- Pull to Refresh

### Search & Sorting
- Live Search by Bike Name
- Sort by Price (Low → High)
- Sort by Price (High → Low)
- Sort by Rating

### Bike Details
- Large Bike Image
- Description
- Rating
- Daily Rental Price
- Availability
- Hero Animation
- Book Now Button

### Booking
- Pickup Date Selection
- Return Date Selection
- Booking Validation
- Total Rental Days
- Total Rental Cost Calculation

### Booking Success
- Success Animation
- Navigate Back to Home

### Error Handling
- Loading State
- Empty State
- Network Error Handling
- Timeout Handling
- Invalid OTP Handling

---

# Tech Stack

- Flutter (Latest Stable)
- Dart (Null Safety)
- Provider
- Dio
- SharedPreferences
- CachedNetworkImage
- Intl
- Material 3

---

# Project Structure

```text
lib/
│
├── main.dart
│
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
├── models/
│   └── product_model.dart
│
├── services/
│   ├── api_service.dart
│   ├── auth_service.dart
│   └── storage_service.dart
│
├── providers/
│   ├── auth_provider.dart
│   ├── product_provider.dart
│   └── booking_provider.dart
│
├── screens/
│   ├── splash/
│   ├── login/
│   ├── otp/
│   ├── home/
│   ├── details/
│   ├── booking/
│   └── success/
│
├── widgets/
│   ├── bike_card.dart
│   ├── custom_button.dart
│   ├── custom_search_bar.dart
│   ├── rating_widget.dart
│   ├── loading_widget.dart
│   ├── empty_widget.dart
│   └── error_widget.dart
│
└── routes/
    └── app_routes.dart
```

---

# Architecture

The project follows a layered architecture.

```
UI (Screens & Widgets)
        │
        ▼
Providers (Business Logic & State)
        │
        ▼
Services (API & Local Storage)
        │
        ▼
Network / SharedPreferences
```

### State Management

The application uses **Provider** with `ChangeNotifier`.

Providers:

- AuthProvider
- ProductProvider
- BookingProvider

Each provider manages its own business logic and notifies the UI using `notifyListeners()`.

---

# API

Products are fetched from:

https://fakestoreapi.com/products

The response is mapped into rental-related data.

| API Field | App Field |
|-----------|-----------|
| title | Bike Name |
| image | Bike Image |
| price | Rental Price |
| description | Description |
| rating.rate | Rating |

Availability is generated locally for demonstration purposes.

---

# Packages Used

| Package | Purpose |
|---------|---------|
| provider | State Management |
| dio | API Requests |
| shared_preferences | Store Login Session |
| cached_network_image | Image Caching |
| intl | Date Formatting |
| flutter_lints | Static Analysis |

---

# Screens

- Splash Screen
- Login Screen
- OTP Verification
- Home Screen
- Bike Details Screen
- Booking Screen
- Booking Success Screen

---

# Screenshots

| Login | OTP | Home |
|-------|-----|------|
| ![](screenshots/1.jpeg) | ![](screenshots/9.jpeg) | ![](screenshots/2.jpeg) |

| Details | Booking | Success |
|----------|----------|----------|
| ![](screenshots/5.jpeg) | ![](screenshots/6.jpeg) | ![](screenshots/7.jpeg) |

---

# Getting Started

## Clone Repository

```bash
git clone <repository-url>
```

## Navigate to Project

```bash
cd rideon
```

## Install Dependencies

```bash
flutter pub get
```

## Run Application

```bash
flutter run
```

---

# Build Release APK

```bash
flutter build apk --release
```

Generated APK:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

# State Flow

```
Splash
      │
      ▼
Check Login
      │
      ▼
Login → OTP
      │
      ▼
Home
      │
      ▼
Bike Details
      │
      ▼
Booking
      │
      ▼
Success
```

---

# Error Handling

The application handles:

- No Internet Connection
- API Timeout
- Server Errors
- Invalid OTP
- Empty Product List
- Image Loading Errors

---

# Future Improvements

- Firebase Authentication
- Real OTP Verification
- Real Booking Backend
- Payment Gateway Integration
- Google Maps Integration
- Dark Mode
- Favorites
- Booking History
- Unit & Widget Testing

---

# Git Commit History

Example commit sequence:

- Initial Flutter project setup
- Setup clean folder structure
- Implement authentication flow
- Integrate Fake Store API
- Add Provider state management
- Implement search functionality
- Add sorting feature
- Build booking flow
- Improve UI & animations
- Update README

---

# Assignment Requirements Covered

✅ Mobile Login

✅ Dummy OTP Verification

✅ Local Login Persistence

✅ Splash Screen

✅ Product API Integration

✅ Search

✅ Sorting

✅ Product Details

✅ Booking Flow

✅ Success Screen

✅ Loading State

✅ Error State

✅ Empty State

✅ Pull to Refresh

✅ Cached Images

✅ Material 3 UI

✅ Provider State Management

---

## Author

**Jaskeerat Singh**

Flutter Developer
