# OLX-CLONE: Next-Generation C2C Marketplace Platform

This project implements a **scalable, secure, and feature-rich Consumer-to-Consumer (C2C) marketplace**, developed as a core deliverable for a Bachelor’s Degree in Computer Science. It addresses critical vulnerabilities and feature gaps found in traditional classifieds platforms, especially in user fraud detection and ad lifecycle management.

---

## 💡 Core Innovation & Value Proposition

* **Robust Trust & Safety Framework:** Enables immediate reporting and blocking of fraudulent users.
* **Ad Lifecycle Management (ALM):** Gives sellers full control to activate, deactivate, or mark products as sold.
* **Data Integrity Enforcement:** Admins can block/unblock products based on authenticity or policy violations, ensuring a cleaner marketplace.

---

## 🛠️ Technology Stack

| Layer            | Component                     | Technical Edge                                                                                  |
| ---------------- | ----------------------------- | ----------------------------------------------------------------------------------------------- |
| Front-End        | Python                        | High-level, readable, object-oriented scripting; fast iteration; extensive standard library     |
| Back-End         | MySQL                         | Open-source RDBMS, high performance, scalable, suitable for high-volume transactional workloads |
| Data Integrity   | Normalization (1NF, 2NF, 3NF) | Reduces redundancy, ensures data integrity, builds flexible and adaptable schema                |
| Operating System | Windows 10                    | Development and deployment environment                                                          |

---

## ⚙️ System Architecture & Modules

### 1. Administrator (Governance Module)

Responsible for maintaining platform integrity and content moderation:

* **User Management:** Block/unblock users.
* **Content Moderation:** Block/unblock products, monitor sold ads.
* **Catalog Management:** Add and configure product categories.

### 2. Customer (Client Module)

Supports full user journey:

* **Secure Access:** Registration, login, profile management.
* **Commerce & Listing:** Submit, edit, delete ads; mark products as sold; control ad status.
* **Engagement & Retention:** Favorites, built-in chat for communication.
* **Feedback Loop:** Report fraudulent or inappropriate users.

---

## 🛡️ Quality Assurance Lifecycle

* **Unit Testing:** Tests individual modules for coding or logic errors.
* **Integration Testing:** Validates smooth data flow between modules (e.g., Admin ↔ Customer).
* **Validation Testing:** Confirms the software meets specifications.
* **User Acceptance Testing (UAT):** Ensures end-user satisfaction and functional compliance.

---

## 📈 Key Advantages

* **Enhanced Security:** Proactive fraud detection and content moderation.
* **Seller Autonomy:** Full control over ads and product lifecycle.
* **Data Reliability:** Administratively enforced data integrity and authenticity.
* **Scalable Architecture:** Modular design allows rapid feature additions and maintenance.
