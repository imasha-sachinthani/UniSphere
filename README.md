<div align="center">

# 🎓 UniSphere

### A Modern University Student Management Platform built with Flutter & Firebase

A production-ready mobile application that centralizes essential university services into a single platform, enabling students to manage assignments, marketplace activities, lost & found, notices, timetables, and personal profiles.

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Backend-FFCA28?logo=firebase)
![Platform](https://img.shields.io/badge/Platform-Android-success)
![License](https://img.shields.io/badge/License-Educational-blue)

</div>

---

# 📖 About

UniSphere is a full-stack Flutter application developed to simplify the daily academic activities of university students.

Instead of using multiple applications for assignments, announcements, student trading, lost & found, and timetable management, UniSphere provides a centralized platform that improves accessibility, organization, and communication.

The project follows a modular architecture, Firebase backend integration, and reusable UI components to provide a scalable and maintainable codebase.

---

# ✨ Key Features

## 🔐 Authentication

- Firebase Authentication
- Secure Login
- Student Registration
- Password Reset

---

## 📝 Assignment Management

- View assignments
- Assignment details
- Deadline tracking
- Assignment submission upload
- Submission management

---

## 📅 Timetable

- Weekly timetable
- Organized academic schedule

---

## 📢 Notices

- University announcements
- Latest notices

---

## 🛒 Marketplace

- Buy & Sell student products
- Product images
- Product management
- Student marketplace

---

## 🔍 Lost & Found

- Report lost items
- Report found items
- Item descriptions
- Contact information

---

## 👤 Student Profile

- Profile management
- Edit information
- Update profile picture

---

# 🏗 Architecture

```
Flutter
      │
      ▼
Provider State Management
      │
      ▼
Controllers
      │
      ▼
Services
      │
      ▼
Firebase
 ├── Authentication
 ├── Firestore
 └── Storage
```

---

# 📂 Project Structure

```
lib
│
├── core
│   ├── constants
│   ├── providers
│   ├── routes
│   ├── services
│   └── theme
│
├── features
│   ├── authentication
│   ├── assignments
│   ├── home
│   ├── lost_found
│   ├── marketplace
│   ├── notices
│   ├── profile
│   └── timetable
│
└── main.dart
```

---

# 🛠 Tech Stack

### Frontend

- Flutter
- Dart

### Backend

- Firebase Authentication
- Cloud Firestore
- Firebase Storage

### State Management

- Provider

### Packages

- Provider
- File Picker
- Image Picker
- HTTP
- Shared Preferences
- URL Launcher
- Intl

---

# 🚀 Installation

Clone the repository

```bash
git clone https://github.com/imasha-sachinthani/UniSphere.git
```

Navigate into the project

```bash
cd UniSphere
```

Install dependencies

```bash
flutter pub get
```

Run the application

```bash
flutter run
```

---

# 🔥 Firebase Setup

1. Create a Firebase Project
2. Enable Authentication
3. Enable Firestore
4. Enable Firebase Storage
5. Add

```
google-services.json
```

into

```
android/app/
```

---

# 📦 Build Release APK

```bash
flutter build apk --release
```

Output

```
build/app/outputs/flutter-apk/app-release.apk
```

---

# 🎯 Project Highlights

- Modular Architecture
- Clean Folder Structure
- Firebase Integration
- Cloud Storage
- Responsive UI
- Reusable Components
- Production Build Ready

---

# 👨‍💻 Developer

**Imasha Sachinthani**

Software Engineering Undergraduate

NSBM Green University

Sri Lanka

GitHub

https://github.com/imasha-sachinthani

---

# 🤝 Contributions

This project was independently designed, implemented, tested, and maintained by **Imasha Sachinthani**.

During development, some Git commits were created using another personal GitHub account owned by the same developer due to local Git configuration. All commits, source code, architecture, implementation, and project ownership belong to the same developer.

---

# 📄 License

This repository is published for educational, learning, and portfolio purposes.

© 2026 Imasha Sachinthani. All Rights Reserved.
