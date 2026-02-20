# Service Booking App

A full-featured Service Booking Mobile Application built using **Flutter & Firebase**, implementing real-time database integration, authentication, pagination, dark mode, and clean UI architecture using **GetX State Management**.

---

## 📱 Application Overview

The Service Booking App allows users to:

- Register & Login securely
- Browse service categories
- View professionals under each category
- Sort professionals by price or rating
- Book appointments
- View their appointments in real-time
- Toggle between Light and Dark Mode

This project demonstrates complete integration between Flutter frontend and Firebase backend.

---

## 🛠 Tech Stack

- **Flutter** – Mobile App Development
- **Firebase Authentication** – User Login & Signup
- **Cloud Firestore** – Database Storage
- **GetX** – State Management & Navigation
- **Firestore Pagination** – Lazy Loading
- **ThemeData** – Light/Dark Mode
- **StreamBuilder** – Real-time Updates

---

## 🔐 Authentication Module

- Email & Password Authentication
- Secure Login & Signup
- Firebase User Management
- Persistent Authentication State

### Firebase Console Location
Firebase Console → Authentication → Users

Registered users can be viewed inside the Authentication section.

---

## 🏠 Dashboard Module

### UI Features:
- Greeting Header
- Search Bar
- Animated Banner
- Category Grid
- Bottom Navigation

### Data Source:
Categories are fetched dynamically from Firestore.

Collection:
```
categories
```

Each category contains:
- name
- image (URL)

---

## 👨‍💼 Professional Listing Module

When a category is selected:

- Professionals are fetched from Firestore
- Displayed in a styled card layout

### Fields:
- name
- category
- experience
- rating
- price

### Sorting Options:
- Price: Low → High
- Price: High → Low
- Rating: High → Low

### Pagination:
- Lazy loading implemented
- More professionals load automatically when scrolling

---

## 📄 Professional Detail Screen

Displays:

- Name
- Category
- Experience
- Rating
- Price

User can proceed to booking from here.

---

## 📅 Appointment Booking System

### Features:
- Date Selection
- Time Selection
- Input Validation
- Loading Indicators
- Firestore Integration

### Stored Fields in Firestore

Collection:
```
appointments
```

Fields:
- userId
- professionalId
- professionalName
- category
- date
- time
- status
- createdAt

All bookings are stored in Firestore in real-time.

---

## 📋 My Appointments Screen

- Displays user-specific bookings
- Real-time updates using StreamBuilder
- Status badge (Pending / Confirmed / Cancelled)
- Data filtered using current user ID

---

## 👤 Profile Screen

Displays:
- User Email
- User ID

Includes:
- Dark Mode Toggle
- Logout functionality

---

## 🌙 Dark Mode

- Full application theme switching
- Implemented using GetX + ThemeData
- Changes:
  - Background colors
  - Text colors
  - Cards
  - AppBar
  - Buttons

---

## 📂 Firestore Database Structure

```
categories
   └── name
   └── image

professionals
   └── name
   └── category
   └── experience
   └── rating
   └── price

appointments
   └── userId
   └── professionalId
   └── professionalName
   └── category
   └── date
   └── time
   └── status
   └── createdAt
```

## 🎥 Demo Includes

- Authentication Demo
- Firebase Console Demo
- Category Fetching
- Sorting
- Pagination
- Booking System
- Real-time Firestore Update
- Dark Mode Toggle

---

## 🧠 State Management

GetX is used for:

- State management
- Navigation
- Theme switching
- Reactive UI updates

---

## 🚀 Key Highlights

✔ Firebase Authentication  
✔ Firestore Integration  
✔ Real-time Updates  
✔ Pagination  
✔ Sorting  
✔ Dark Mode  
✔ Clean Architecture  
✔ GetX State Management  
✔ Responsive UI  
✔ Validation & Error Handling  

---

## 👩‍💻 Developer

Sreeshna C

---
