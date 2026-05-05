# 📰 News Explorer App

A modern Flutter-based News Application that fetches real-time news using API and provides a smooth, fast, and user-friendly experience with offline support, dark mode, and more.

---

## 🚀 Features

* 🌐 Live News API Integration
* 📶 Offline Mode using Hive Local Storage
* 🔄 Auto Refresh on Internet Reconnect
* 🌙 Dark & Light Theme Toggle
* ❤️ Like / Favorite News Feature
* 🔍 Search News by Title & Description
* 📱 Responsive & Clean UI
* 🧠 Smart State Management using Provider
* 🔄 Pull to Refresh Animation
* 🧭 Drawer Navigation (Home, Liked News, Theme)

---

## 📸 Screenshots

### 🏠 Home Screen
<img width="295" height="657" alt="Screenshot 2026-05-06 at 2 09 54 AM" src="https://github.com/user-attachments/assets/044229b5-e85f-47c1-9cdc-78cc874aca31" />
<img width="299" height="652" alt="Screenshot 2026-05-06 at 2 12 03 AM" src="https://github.com/user-attachments/assets/dbb8c56b-c9a5-425b-9a5f-9e6d5f133eda" />


### 📄 Detail Screen

<img width="292" height="645" alt="Screenshot 2026-05-06 at 2 10 14 AM" src="https://github.com/user-attachments/assets/d70b7604-d767-4801-8b96-0e7728bc0a55" />
<img width="289" height="645" alt="Screenshot 2026-05-06 at 2 11 52 AM" src="https://github.com/user-attachments/assets/3b1dd74c-87b4-4696-99bf-d7ecd5a223e0" />


### ❤️ Liked News Screen

<img width="297" height="650" alt="Screenshot 2026-05-06 at 2 11 41 AM" src="https://github.com/user-attachments/assets/4d835637-cab1-43a1-a1c8-5820a928a75e" />

<img width="296" height="644" alt="Screenshot 2026-05-06 at 2 11 13 AM" src="https://github.com/user-attachments/assets/a4a47376-ceae-4761-9d37-769167e3fd5c" />



### 🌙 Dark Mode

<img width="297" height="650" alt="Screenshot 2026-05-06 at 2 11 41 AM" src="https://github.com/user-attachments/assets/d33746a0-d58c-41f2-a365-0f5a420600f5" />
<img width="300" height="654"<img width="299" height="652" alt="Screenshot 2026-05-06 at 2 12 03 AM" src="https://github.com/user-attachments/assets/ec6f93e9-33c7-45fd-bf08-b965550bec1c" />
 alt="Screenshot 2026-05-06 at 2 11 29 AM" src="https://github.com/user-attachments/assets/7a9831cd-b996-4e0d-9f61-c2de7207b4c2" />
<img width="289" height="645" alt="Screenshot 2026-05-06 at 2 11 52 AM" src="https://github.com/user-attachments/assets/108cda21-e2b1-4fa7-aa61-accbfcbbce13" />


🚀 Splash Screen
<img width="222" height="499" alt="Screenshot 2026-05-06 at 2 14 18 AM" src="https://github.com/user-attachments/assets/866fad40-cf98-4f06-8d08-a93bcaf19238" />

🧭 Drawer Navigation

<img width="292" height="661" alt="Screenshot 2026-05-06 at 2 10 26 AM" src="https://github.com/user-attachments/assets/459edd28-9876-40ad-bf74-4b82b6ec1b5a" />

<img width="300" height="654" alt="Screenshot 2026-05-06 at 2 11 29 AM" src="https://github.com/user-attachments/assets/d73f8d7e-68b4-4676-af9d-bf6c08888aa9" />

---

## 🛠️ Tech Stack

* Flutter
* Dart
* Provider (State Management)
* Hive (Local Storage)
* REST API
* Connectivity Plus

---

## 📂 Project Structure

```
lib/
│
├── core/
│   └── error/
│       └── exceptions.dart
│
├── features/
│   └── news/
│
│       ├── data/
│       │   ├── datasource/
│       │   │   ├── news_remote_data_source.dart
│       │   │   └── news_local_data_source.dart
│       │   │
│       │   ├── models/
│       │   │   └── article_model.dart
│       │   │
│       │   └── repository/
│       │       └── news_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── article.dart
│       │   │
│       │   ├── repository/
│       │   │   └── news_repository.dart
│       │   │
│       │   └── usecases/
│       │       └── get_news.dart
│       │
│       ├── presentation/
│       │   ├── provider/
│       │   │   ├── news_provider.dart
│       │   │   └── theme_provider.dart
│       │   │
│       │   ├── screens/
│       │   │   ├── splash_screen.dart
│       │   │   ├── home_screen.dart
│       │   │   ├── detail_screen.dart
│       │   │   └── liked_screen.dart
│       │   │
│       │   └── widgets/
│       │       ├── app_loader.dart
│       │       ├── custom_drawer.dart
│       │       ├── news_card.dart
│       │       └── category_tabs.dart
│
├── main.dart
```

---

## ⚙️ How It Works

* App starts → checks internet connection
* If online → fetches latest news from API
* If offline → loads cached news from Hive
* Users can like articles → saved locally
* Theme toggle → updates UI instantly

---

## ▶️ Installation

```bash
git clone https://github.com/Dharmiksinhvaja15032004/news-app.git
cd news-app
flutter pub get
flutter run
```

---

## 📌 Future Improvements

* 🔔 Push Notifications (Breaking News)
* 🌍 Multi-language Support
* 🤖 AI-based News Summary
* 📊 Personalized Categories

---

## 👨‍💻 Developer

**Dharmiksinh Vaja**
Flutter Developer 🚀

---
