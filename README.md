# Service Booking App

A complete Service Booking Mobile Application built using **Flutter & Firebase** with **GetX State Management**.

---

## 📱 Tech Stack

- Flutter
- Firebase Authentication
- Cloud Firestore
- GetX (State Management)
- Pagination
- Dark Mode
- Responsive UI

---

## 🔐 Features

### ✅ Authentication
- Email & Password Login
- Secure Signup
- Firebase Authentication Integration

### 🏠 Dashboard
- Greeting Header
- Search Bar UI
- Animated Banner
- Category Grid (Fetched from Firestore)

### 👨‍💼 Professional Listing
- Filter by Category
- Sorting:
  - Price: Low → High
  - Price: High → Low
  - Rating: High → Low
- Pagination (Lazy Loading)

### 👤 Professional Details
- Name
- Category
- Experience
- Rating
- Price

### 📅 Appointment Booking
- Date Selection
- Time Selection
- Validation
- Booking Stored in Firestore
- Real-time Updates

### 📋 My Appointments
- Shows bookings of current user
- Displays:
  - Professional Name
  - Category
  - Date
  - Time
  - Status
- Real-time Firestore Stream

### 🌙 Dark Mode
- Complete theme switching
- Managed using GetX
- Light & Dark Theme support

---

## 🗂 Firestore Collections

### categories
- name
- image

### professionals
- name
- category
- experience
- rating
- price

### appointments
- userId
- professionalId
- professionalName
- category
- date
- time
- status
- createdAt

---




## 👩‍💻 Developed By

Sreeshna C
