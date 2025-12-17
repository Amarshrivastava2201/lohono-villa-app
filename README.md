# Lohono Villa Availability & Pricing – Flutter App

This repository contains the Flutter frontend application for the Lohono villa availability and pricing assignment.  
The app consumes backend APIs to display available villas and generate pricing quotes.

---

## 🛠 Tech Stack

- Flutter (Windows Desktop)
- Dart
- HTTP package for API integration

---

## 📱 Features

- Villa listing screen with:
  - Name
  - Location
  - Average price per night
  - Number of nights
- Quote screen with:
  - Availability status
  - Subtotal
  - GST (18%)
  - Total payable amount
- Loading, error, and empty states handled gracefully
- Navigation between listing and quote screens

---

## 📁 Project Structure

lib/
├── main.dart
├── models/
│ ├── villa.dart
│ └── villa_quote.dart
├── services/
│ └── villa_api_service.dart
├── screens/
│ ├── villa_list_screen.dart
│ └── villa_quote_screen.dart

---

## ⚙️ Setup Instructions

### 1️⃣ Prerequisites
- Flutter SDK installed
- Backend server running locally on port `5000`

Verify Flutter:
```bash
flutter doctor
2️⃣ Install dependencies
bash
Copy code
flutter pub get
3️⃣ Run the app
bash
Copy code
flutter run
When prompted, select:

Windows (desktop)

🔗 Backend Dependency
The app expects the backend API to be running at:

http://127.0.0.1:5000
Endpoints used:

GET /v1/villas/availability

GET /v1/villas/:villa_id/quote
