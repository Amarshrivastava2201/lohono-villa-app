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

<img width="364" height="278" alt="image" src="https://github.com/user-attachments/assets/242b86b3-659e-4e6e-a4ea-f49fb32c986b" />


---

## ⚙️ Setup Instructions

### 1️⃣ Prerequisites
- Flutter SDK installed
- Backend server running locally on port `5000`

Verify Flutter:
flutter doctor
2️⃣ Install dependencies
flutter pub get
3️⃣ Run the app
flutter run
When prompted, select:

Windows (desktop)

🔗 Backend Dependency
The app expects the backend API to be running at:

http://127.0.0.1:5000
Endpoints used:

GET /v1/villas/availability

GET /v1/villas/:villa_id/quote

📌 Notes

API dates are currently hardcoded for assignment scope.

Architecture separates models, services, and UI layers for clarity.

The app can be easily extended to Android/iOS with minimal changes.
