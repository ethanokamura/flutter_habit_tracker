# Habit Rabbit

 /)_/)
( •.•)

Welcome to **Habit Rabbit**, your daily companion for habit tracking and achieving your goals! This Flutter-powered app is designed to help you build healthy habits, track your progress month-to-month, and stay motivated with the help of your cheerful rabbit friend.

---

## 📱 Features

### 1. **Habit Tracking**
- Easily add and manage your daily habits.
- Set personalized goals for each habit.
- Track your completion progress with visual indicators.

### 2. **Monthly Progress View**
- View detailed statistics on your habits month-to-month.
- Analyze your performance trends and celebrate your wins!

### 3. **Motivational Rabbit**
- A friendly rabbit greets you on the home page.
- Receive a fresh positive message every time you open the app.

### 4. **Offline-First Structure**
- The app ensures seamless functionality with offline support using the **Isar** database.
- Data syncs to the cloud via **Supabase** when online.

### 5. **Secure Authentication**
- User authentication powered by **Twilio Phone Messaging**.
- Your data is secure and accessible only to you.

---

## 🔧 Technologies Used

### Frontend:
- **Flutter**: For a smooth and beautiful cross-platform experience.

### State Management:
- **Cubit**: Ensures efficient state handling and a seamless user experience.

### Databases:
- **Isar**: Local database for offline-first architecture.
- **Supabase**: Cloud storage and sync for cross-device accessibility.

### Authentication:
- **Twilio**: Secure phone number authentication.

---

## 🚀 Getting Started

### Prerequisites:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A Supabase account for cloud storage
- Twilio account for phone number authentication

### Installation:
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/habit-rabbit.git
   ```

2. Navigate to the project directory:
   ```bash
   cd habit-rabbit
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## 📲 Deployment

### iOS:
- Configure the app for App Store distribution.
- Ensure you have an Apple Developer account.

### Android:
- Generate a release APK or App Bundle.
- Publish the app to Google Play.

---

## 💡 Contribution

We welcome contributions to make Habit Rabbit even better! To contribute:
1. Fork the repository.
2. Create a new branch.
3. Submit a pull request with your changes.

---

## 🛠️ Troubleshooting

- For **Isar database issues**, ensure your Flutter project includes the necessary build_runner configurations.
- Check the Supabase and Twilio configurations in the `pubspec.yaml` file for authentication and cloud storage.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

