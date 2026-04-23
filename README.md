# 📅 Optimized Timetable Management System

An intelligent **Timetable Management System** that generates **clash-free academic timetables** using constraint optimization (OR-Tools), integrated with a **Flask backend** and **MySQL database**.

---

## 🚀 Features

- 🔐 **User Authentication**
  - Secure login with SHA-256 password hashing
  - Forgot password interface

- 📚 **Dynamic Program & Course Selection**
  - Fetch programs from database
  - Load courses dynamically based on selected programs

- ⚙️ **Automated Timetable Generation**
  - Uses **Google OR-Tools (Constraint Programming)**
  - Ensures:
    - No room clashes
    - No professor conflicts
    - Proper lab/theory allocation
    - Balanced distribution of lectures

- 🏫 **Multi-View Timetable**
  - 📅 Week-wise (Program)
  - 👨‍🏫 Professor-wise
  - 🏢 Room-wise

- 🎨 **Modern UI**
  - Responsive dashboard with sidebar navigation
  - Clean login & reset password pages

---

## 🏗️ Tech Stack

| Layer        | Technology |
|-------------|-----------|
| Frontend     | HTML, CSS, JavaScript |
| Backend      | Flask (Python) |
| Database     | MySQL |
| Optimization | Google OR-Tools |
| Authentication | SHA-256 hashing |

---
