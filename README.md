# 🌸 Flowery App

A Flutter-based e-commerce application for browsing products, managing a shopping cart, authentication, and tracking orders.

## 📱 Overview

**Flowery App** is a cross-platform mobile e-commerce application built with **Flutter and Dart**. The application provides a complete shopping experience, from user authentication and product browsing to cart management and order tracking.

## ✨ Features

- 🔐 **User Authentication**
  - User registration and login
  - Secure authentication flow

- 🛍️ **Product Management**
  - Browse available products
  - View product information
  - Manage products through backend integration

- 🛒 **Shopping Cart**
  - Add products to cart
  - Manage cart items
  - Review selected products before ordering

- 📦 **Order Tracking**
  - Place orders
  - Track order status
  - Follow the order through the delivery process

- 🔌 **Backend Integration**
  - REST API integration
  - Communication with the application backend
  - Remote data management

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

## 🏗️ Architecture

The application follows a structured and maintainable architecture using:

```text
Presentation
    ↓
Business Logic
    ↓
Domain
    ↓
Data
    ↓
Remote API / Backend
```

This separation helps keep the application scalable, testable, and easier to maintain.

## 🔄 Application Flow

```text
Authentication
      ↓
Browse Products
      ↓
View Product Details
      ↓
Add to Cart
      ↓
Review Cart
      ↓
Place Order
      ↓
Track Order
```

## 📂 Project Structure

```text
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

```bash
git clone <YOUR_REPOSITORY_URL>
```

Navigate to the project:

```bash
cd flowery-app
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## 🔗 Backend

The application communicates with a backend through REST APIs for operations such as authentication, product management, and order processing.

## 📸 Screenshots

<img width="5178" height="3611" alt="flowery" src="https://github.com/user-attachments/assets/af8bf2ae-be80-46c9-9c0f-c64b8b0499e6" />

- Flutter & Dart
- Clean Architecture
- BLoC / Cubit
- REST APIs
- Firebase
- Mobile Application Development

---

⭐ If you find this project useful, consider giving the repository a star.
