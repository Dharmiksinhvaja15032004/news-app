# 📰 News Explorer App

A modern Flutter-based News Application that fetches real-time news using API and provides a smooth, user-friendly experience with offline support, dark mode, and more.

---

## 🚀 Features

* 🌐 **Live News API Integration**
* 📶 **Offline Mode (Hive Local Storage)**
* 🔄 **Auto Refresh on Internet Reconnect**
* 🌙 **Dark & Light Theme Toggle**
* ❤️ **Like / Favorite News Feature**
* 🔍 **Search News by Title & Description**
* 📱 **Responsive & Clean UI**
* 🧠 **Smart Data Handling (Provider State Management)**
* 🔄 **Pull to Refresh with Custom Animation**
* 🧭 **Drawer Navigation (Home, Liked News, Theme Toggle)**

---

## 📸 Screenshots

> *(Add your app screenshots here)*
> Example:

* Home Screen
* Detail Screen
* Liked News Screen
* Dark Mode UI

---

## 🛠️ Tech Stack

* **Flutter**
* **Dart**
* **Provider (State Management)**
* **Hive (Local Storage)**
* **REST API Integration**
* **Connectivity Plus (Internet Check)**

---

## 📂 Project Structure

```
# 📰 News Explorer App

A modern Flutter-based News Application that fetches real-time news using API and provides a smooth, user-friendly experience with offline support, dark mode, and more.

---

## 🚀 Features

* 🌐 **Live News API Integration**
* 📶 **Offline Mode (Hive Local Storage)**
* 🔄 **Auto Refresh on Internet Reconnect**
* 🌙 **Dark & Light Theme Toggle**
* ❤️ **Like / Favorite News Feature**
* 🔍 **Search News by Title & Description**
* 📱 **Responsive & Clean UI**
* 🧠 **Smart Data Handling (Provider State Management)**
* 🔄 **Pull to Refresh with Custom Animation**
* 🧭 **Drawer Navigation (Home, Liked News, Theme Toggle)**

---

## 📸 Screenshots

> *(Add your app screenshots here)*
> Example:

* Home Screen
* Detail Screen
* Liked News Screen
* Dark Mode UI

---

## 🛠️ Tech Stack

* **Flutter**
* **Dart**
* **Provider (State Management)**
* **Hive (Local Storage)**
* **REST API Integration**
* **Connectivity Plus (Internet Check)**

---

## 📂 Project Structure

```
lib/
│
├── core/              
│   └── error/
│        └── exceptions.dart
│
├── features/
│   └── news/
│       │
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
├── main.dart```<img width="297" height="658" alt="Screenshot 2026-05-06 at 2 09 15 AM" src="https://github.com/user-attachments/assets/4711f7fb-a492-426b-a3f8-4184cd8dd2a5" />


---

## ⚙️ How It Works

* App starts → checks internet connection
* If internet available → fetch fresh data from API
* If no internet → load cached data from Hive
* User can like news → stored locally
* Theme toggle → updates UI dynamically

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
* 📊 Category Personalization

---

## 👨‍💻 Developer

**Dharmiksinh Vaja**
Flutter Developer 🚀

---

## 💙 Support

If you like this project, give it a ⭐ on GitHub!
```

---

## ⚙️ How It Works

* App starts → checks internet connection
* If internet available → fetch fresh data from API
* If no internet → load cached data from Hive
* User can like news → stored locally
* Theme toggle → updates UI dynamically

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
* 📊 Category Personalization

<img width="295" height="657" alt="Screenshot 2026-05-06 at 2 09 54 AM" src="https://github.com/user-attachments/assets/12bf4263-3cb7-4ee5-a0f9-5aa76c41306a" /><img width="222" height="499" alt="Screenshot 2026-05-06 at 2 14 18 AM" src="https://github.com/user-attachments/assets/92c42526-eb3a-4b81-944d-703f0d4cc4dc" />
<img width="299" height="652" alt="Screenshot 2026-05-06 at 2 12 03 AM" src="https://github.com/user-attachments/assets/38c9faab-4717-4067-8e24-a71d2f01840f" />
<img width="289" height="645" alt="Screenshot 2026-05-06 at 2 11 52 AM" src="https://github.com/user-attachments/assets/cebbe07a-9e71-413f-9b70-504ed0c04204" />
<img width="297" height="650" alt="Screenshot 2026-05-06 at 2 11 41 AM" src="https://github.com/user-attachments/assets/699cceca-df0f-449e-b4be-c7bc9c2d63fd" />
<img width="300" height="654" alt="Screenshot 2026-05-06 at 2 11 29 AM" src="https://github.com/user-attachments/assets/02da7e7d-e423-4c52-8651-87e107ede3a3" />
<img width="296" height="644" alt="Screenshot 2026-05-06 at 2 11 13 AM" src="https://github.com/user-attachments/assets/f464fef9-48ef-4e9d-becb-5ac79486c5b2" />
<img width="292" height="661" alt="Screenshot 2026-05-06 at 2 10 26 AM" src="https://github.com/user-attachments/assets/1d3e57be-00e9-4ca0-bff1-f15bb6623f8a" />
<img width="292" height="645" alt="Screenshot 2026-05-06 at 2 10 14 AM" src="https://github.com/user-attachments/assets/e405a56b-95b9-4952-8bbe-cd6ba6861f22" />


## 👨‍💻 Developer

**Dharmiksinh Vaja**
Flutter Developer 🚀

---

## 💙 Support

If you like this project, give it a ⭐ on GitHub!
