# Domra Tech
> **Your go-to source for Khmer technical terms.**

## 1. Project Title & Overview
**Project Name:** Domra-Tech  
**Overview:** Domra Tech is a mobile application built using Flutter that serves as a community-driven technology resource platform. It provides users with seamless access to tech terminologies, real-time search capabilities, and the ability to contribute new terms or corrections to existing terms. The application is designed with an offline-first architecture to ensure reliability across varying network conditions and features deep localization to support the Khmer-speaking community.

## 2. Academic Context
This project was developed as part of the **Capstone II** project. It serves as a practical exploration of modern mobile software engineering principles.
* **Relevance:** Demonstrates the application of advanced mobile development techniques in a full-stack context, fulfilling the comprehensive requirements of a Capstone project.
* **Learning Objectives:** Mastering state management, implementing complex search algorithms, handling localized assets, and setting up offline-to-online data synchronization.
* **Technologies Studied:** Flutter/Dart, Provider (State Management), SQLite (Local Database), Firebase (Authentication, Image Storage), GoRouter (Declarative Routing), Bakong KHQR, and AWS (Backend Hosting).

## 3. Professional/Working Field Context
Beyond its academic foundation, Domra-Tech is built to solve real-world accessibility issues in the tech ecosystem.
* **Problem Addressed:** The lack of accessible, localized (Khmer) tech resources and the need for a collaborative platform where professionals and enthusiasts can contribute corrections and updates.
* **Business Relevancy:** The integration of **Bakong KHQR** demonstrates readiness for the Cambodian fintech landscape, enabling micro-transactions, and premium features.
* **Scalability:** Built on a serverless architecture with optimized backend APIs handling contribution workflows, ensuring the platform can scale seamlessly with user growth.

## 4. Installation & Setup
Follow these steps to set up the development environment:

### Prerequisites
* [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.9.2 or higher)
* [Dart SDK](https://dart.dev/get-dart)
* Android Studio / Xcode for emulators
* Appropriate Firebase project configuration (`google-services.json` / `GoogleService-Info.plist` - *must be obtained from project maintainers*)

### Setup Instructions
1. **Clone the repository:**
   ```bash
   git clone https://github.com/sonika-tang/Domra-Tech-App.git
   cd domra_tech
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Configure Firebase:** Ensure your platform-specific Firebase configuration files are placed in the `android/app` and `ios/Runner` directories respectively.

## 5. Usage
To run the application locally in development mode:

```bash
# Run on an active emulator or connected device
flutter run

# Run on web (Chrome)
flutter run -d chrome --web-port=51102
```

### Essential Workflows
* **Search:** Use the Search Bar to query resources. Notice the 500ms debounced real-time throttling that optimizes backend queries.
* **Contributions:** Navigate to the "Contribute" section to upload images or submit correction requests.
* **Offline Mode:** Disconnect your internet connection to test local data persistence and read-only access powered by SQLite.

## 6. System Architecture / Workflow
The system relies on a modular, decoupled architecture:
* **Presentation Layer:** Built with Flutter, utilizing `Provider` for reactive state management and `GoRouter` for deep linking and navigation.
* **Offline Storage Layer:** `SQLite` handles local caching of search results and articles, allowing the app to function without continuous internet access.
* **Cloud Infrastructure:** `Firebase` manages user authentication, and cloud storage for image uploads.
* **External Integrations:** Includes APIs for Bakong KHQR payments and native device features (Speech-to-Text).

## 7. Features
**Academic Innovations:**
* **Real-time Search:** Implementation of real time search with a quick UX/UI experience.
* **Offline-First Synchronization:** Implementation of local data caching ensuring high availability.

**Professional Features:**
* **Khmer Localization:** Full integration of `NotoSansKhmer` typography and localized strings to ensure a massive reduction in the language barrier for Cambodian users.
* **Speech-to-Text:** Accessibility feature allowing voice-powered search queries.
* **Fintech Integration:** Native Bakong KHQR generation for seamless local financial transactions.
* **Community Contribution Flow:** Complete workflow for users to submit content updates, including image uploads and backend validation.

## 8. Results & Evaluation
* **Academic Results:** The state management and local database approaches validating the architectural choices.
* **Professional Results:** The application successfully handles `CorrectionRequest`, and `WordRequest` payloads with strict ENUM-based status validation, proving its readiness for production data integrity requirements.

## 9. Future Work
* **Academic Extensions:** 
  * Implementation of local Machine Learning models for advanced offline-search relevancy and categorization.
  * Research into Conflict-free Replicated Data Types for more robust offline contribution syncing.
* **Industry Roadmap:** 
  * Expansion of the contribution API to support rich text markdown editors.
  * Full commercialization via integrated subscription models using the existing KHQR foundation.

## 10. Contributors
* **Advisor:** Mr. HIM Soklong

* **TANG Sonika:** Project Manager, Handle System Architecture, Core Application Screens, Route Configuration, Backend Hosting, and Offline Intergration.
* **KEM Veysean:** Manage Database and Hosting, Firebase Integration, Authentication Flow, and Core Application Screens.
* **OENG Gechty:** Core Application Widgets, Language Switching, Core Application Screens, Voice Search Implementation, and Word Share Integration.
* **IN Chanaliza:** API Integration, Bakong SDK Integration, Search Restriction, and Core Application Screens.

**Acknowledgments:**
* Specialized thanks to the Capstone II advisory board for their guidance and technical feedback throughout the development lifecycle.
* Appreciation to the open-source Flutter community and the maintainers of the packages that made this application possible.

---
> *Localization Note:* This application natively supports the Khmer language and requires the `NotoSansKhmer` font family to render properly. Ensure your localization maps in `l10n.yaml` are correctly synced when adding new features.
