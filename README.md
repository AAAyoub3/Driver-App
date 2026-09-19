# 🚚 Flowery Driver App

A Flutter-based driver application designed to manage delivery orders, track locations, and keep drivers updated throughout the delivery process.

## 📱 Overview

**Flowery Driver App** is a cross-platform mobile application built with **Flutter and Dart** for delivery drivers. It provides drivers with the tools needed to receive and manage orders, track deliveries using maps, update order statuses, and receive real-time notifications.

## ✨ Features

- 📦 **Order Management**
  - View available delivery orders
  - Accept and manage assigned orders
  - Keep track of active deliveries

- 🗺️ **Map & Location Tracking**
  - View delivery locations on the map
  - Track delivery routes
  - Navigate between delivery points

- 🔄 **Order Status Management**
  - Update order status throughout the delivery process
  - Keep customers informed about delivery progress

- 🔥 **Firebase Integration**
  - Backend services
  - Real-time data synchronization
  - Notification support

- 🔔 **Delivery Notifications**
  - Receive updates about orders
  - Get notified about relevant order-status changes

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **BLoC / Cubit**
- **Clean Architecture**
- **MVVM / MVI**
- **REST APIs**
- **Dio**
- **Dependency Injection**
- **Firebase**
- **Google Maps**

## 🏗️ Architecture

The application follows a structured architecture designed to separate presentation, business logic, domain, and data responsibilities.

```text id="k2x6v1"
Presentation
      ↓
Business Logic
      ↓
Domain
      ↓
Data
      ↓
REST API / Firebase
```

This structure helps keep the application maintainable and allows individual features to be developed and tested independently.

## 🔄 Delivery Flow

```text id="4z0qca"
Receive Order
      ↓
Review Order
      ↓
Accept Order
      ↓
Navigate to Delivery Location
      ↓
Update Order Status
      ↓
Complete Delivery
```

## 📂 Project Structure

```text id="9c7m2e"
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   └── utils/
│
├── data/
│   ├── models/
│   ├── data_sources/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── use_cases/
│
└── presentation/
    ├── cubits/
    ├── screens/
    └── widgets/
```

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Android Emulator or physical Android device

### Installation

Clone the repository:

```bash id="3r7h2p"
git clone <YOUR_REPOSITORY_URL>
```

Navigate to the project:

```bash id="w8k4q1"
cd driver-app
```

Install dependencies:

```bash id="q5m1fz"
flutter pub get
```

Run the application:

```bash id="u2n8jc"
flutter run
```

## 🔥 Backend & Services

The application uses backend services to manage delivery orders, synchronize order information, and provide notifications to drivers.

Firebase is also used as part of the application's backend and notification infrastructure.

## 🗺️ Maps & Delivery Tracking

The driver application integrates **Google Maps** to provide location-based functionality for delivery operations.

Drivers can use the map to:

- View delivery locations
- Track destinations
- Manage delivery routes
- Follow the delivery process

## 🔔 Notifications

The application provides notifications related to order updates, helping drivers stay informed about changes to their assigned deliveries.

## 📸 Screenshots

<img width="5178" height="3611" alt="driver" src="https://github.com/user-attachments/assets/ddf11ec8-fc95-473a-9ef9-510a1d03575c" />

- Flutter & Dart
- Clean Architecture
- BLoC / Cubit
- REST APIs
- Firebase
- Google Maps
- Mobile Application Development

---

⭐ If you find this project useful, consider giving the repository a star.
