# Car Coop Mobile App

The mobile companion app for **Car Coop**, a self-hosted platform designed for small, private car-sharing groups to manage bookings, trips, and expenses effectively.

## Features

- **📅 Booking Management**: Schedule and view car usage with support for both calendar and list views.
- **🚗 Trip Logging**: Record mileage, duration, and trip types (Vacation, Transport, Workshop).
- **💰 Expense & Payment Tracking**: Manage shared costs, fuel receipts, and settle balances between members.
- **💬 Communication**: Integrated message board for group updates and automated system notifications.
- **📍 Parking**: Save the vehicle's current location and get navigation back to it.
- **🌍 Multilingual**: Support for English, German, Spanish, French, Dutch, and Polish.

## Tech Stack

*   **Framework**: [Flutter](https://flutter.dev)
*   **State Management**: [Riverpod](https://riverpod.dev) (using code generation)
*   **API Client**: [Dio](https://pub.dev/packages/dio)
*   **Localization**: [Flutter Gen-l10n](https://docs.flutter.dev/accessibility-and-localization/internationalization)
*   **Storage**: [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) for credentials and Shared Preferences for settings.

## Getting Started

### Prerequisites

*   Flutter SDK (stable channel)
*   A running [Car Coop Server](https://github.com/haukepauke/car-coop) instance.

### Configuration

Upon first launch, the app will request the **Server URL** of your Car Coop instance. Once connected, you can sign in with your account credentials.

## License

This project is licensed under the GNU General Public License v3.0.

## F-Droid

The Android app is prepared for F-Droid publication:

- only FOSS runtime dependencies are used in the Android app build
- odometer OCR uses Tesseract with bundled language data
- the app connects to a user-configurable Car Coop server
- Android store metadata is included in `fastlane/metadata/android/`

### Development

1.  Clone the repository.
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Generate code (for Riverpod and JSON serialization):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  Run the app:
    ```bash
    flutter run
    ```
