# Samay UpHomes test

[![Flutter Version](https://img.shields.io/badge/Flutter-3.27.1-blue?logo=flutter)](https://flutter.dev)
[![License](https://img.shields.io/github/license/cristiancamilo070/uphomes_bt)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20|%20iOS%20|%20Web-orange)](https://flutter.dev)
[![Last Commit](https://img.shields.io/github/last-commit/cristiancamilo070/uphomes_bt)](https://github.com/cristiancamilo070/uphomes_bt/commits/main)
[![Issues](https://img.shields.io/github/issues/cristiancamilo070/uphomes_bt)](https://github.com/cristiancamilo070/uphomes_bt/issues)
[![Stars](https://img.shields.io/github/stars/cristiancamilo070/uphomes_bt?style=social)](https://github.com/cristiancamilo070/uphomes_bt)

## Running the Flutter Project Locally

To run this Flutter project locally, follow these steps:

- Make sure you have Flutter and Dart installed on your machine.
- Clone the GitHub repository to your local machine using the following command:

```bash
git clone https://github.com/cristiancamilo070/uphomes_bt.git
```

- then run

```bash
flutter pub get
```

```bash
flutter run
```

# Frontend Overview

<div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
  <img src="assets/screenshots/0.jpg" alt="Screenshot 1" width="170" height="350">
  <img src="assets/screenshots/1.jpg" alt="Screenshot 2" width="170" height="350">
  <img src="assets/screenshots/2.jpg" alt="Screenshot 3" width="170" height="350">
</div>
<div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
  <img src="assets/screenshots/3.jpg" alt="Screenshot 4" width="170" height="350">
  <img src="assets/screenshots/4.jpg" alt="Screenshot 5" width="170" height="350">
  <img src="assets/screenshots/5.jpg" alt="Screenshot 6" width="170" height="350">
</div>
<div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
  <img src="assets/screenshots/6.jpg" alt="Screenshot 7" width="170" height="350">
  <img src="assets/screenshots/7.jpg" alt="Screenshot 8" width="170" height="350">
  <img src="assets/screenshots/8.jpg" alt="Screenshot 9" width="170" height="350">
</div>
<div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
  <img src="assets/screenshots/9.jpg" alt="Screenshot 10" width="170" height="350">
  <img src="assets/screenshots/10.jpg" alt="Screenshot 11" width="170" height="350">
  <img src="assets/screenshots/11.jpg" alt="Screenshot 12" width="170" height="350">
</div>
<div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
  <img src="assets/screenshots/12.jpg" alt="Screenshot 13" width="170" height="350">
  <img src="assets/screenshots/13.jpg" alt="Screenshot 14" width="170" height="350">
  <img src="assets/screenshots/14.jpg" alt="Screenshot 15" width="170" height="350">
</div>
<div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
  <img src="assets/screenshots/15.jpg" alt="Screenshot 16" width="170" height="350">
  <img src="assets/screenshots/17.jpg" alt="Screenshot 17" width="170" height="350">
  <img src="assets/screenshots/18.jpg" alt="Screenshot 18" width="170" height="350">
</div>

## Clean Architecture and Code

This Flutter frontend follows the principles of Clean Architecture and Clean Code, providing a structured and maintainable codebase.

---

## Features Implemented in the Project

1. **Bluetooth Integration**:

   - Integration with `flutter_blue_plus` for real Bluetooth device scanning, connection, and management.
   - Simulation of Bluetooth devices for testing without real hardware.
   - Signal strength (RSSI) displayed with corresponding icons:
     - **Green**: Strong signal.
     - **Blue**: Medium signal.
     - **Red**: Weak signal.

2. **Device Commands**:

   - Support for executing commands on both real and simulated devices:
     - `Turn On`
     - `Turn Off`
     - `Fetch Data`

3. **Dynamic UI**:

   - Real-time status updates for connected devices, including:
     - Device name.
     - Connection state.
     - Signal strength (RSSI).
   - Seamless integration of simulated devices alongside real devices.

4. **UI Enhancements**:

   - Responsive design compatible with multiple screen sizes.
   - Modern and clean UI adhering to Material Design principles.

5. **Clean Architecture**:

   - Code structured into three layers:
     - `Domain`: Business logic and entities.
     - `Data`: Repositories and data sources.
     - `Presentation`: UI and state management.
   - Use of `GetX` for efficient state management and dependency injection.

6. **Project Filtering**:

   - Dynamic filtering of projects by:
     - Name.
     - Location.
     - Agency.
   - Integrated search functionality for better user experience.

7. **Edit and Delete Projects**:

   - Real-time UI updates for editing or deleting projects.
   - Smooth animations for transitions during user interactions.

8. **Error Handling**:

   - Comprehensive error handling for:
     - Bluetooth-related issues (e.g., Bluetooth not enabled).
     - Database export errors.
     - Connection failures.
   - User-friendly error messages and prompts.

9. **Theming**:

   - Dynamic theming based on user preferences or agency settings.

10. **Hero Animations**:

    - Seamless transitions across the app using Flutter's `Hero` widget.
    - Applied to project images and key UI elements for smooth visual effects:
      - Project details open with a shared image animation.
      - Consistent transitions between list views and detail views.
    - Enhances user experience by providing visual continuity and a polished feel throughout the app.

---
