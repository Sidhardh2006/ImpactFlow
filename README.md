# ImpactFlow 🌊
**Google Solutions Challenge Prototype**

ImpactFlow is an intelligent volunteer coordination platform designed to bridge the gap between community needs and humanitarian aid. By leveraging AI-driven prioritization and real-time geographic data, ImpactFlow ensures that resources are deployed where they are needed most, instantly.

---

## 🎯 UN Sustainable Development Goals (SDGs)
ImpactFlow directly addresses three key UN SDGs:
- **SDG 2: Zero Hunger**: Facilitating immediate food and water distribution in crisis areas.
- **SDG 11: Sustainable Cities and Communities**: Building community resilience through faster disaster response.
- **SDG 17: Partnerships for the Goals**: Connecting NGOs, local authorities, and volunteers on a single unified platform.

---

## 🚀 Google Technology Stack
To achieve maximum impact and scalability, we utilized:
- **Flutter**: For a beautiful, responsive, and cross-platform UI (Web, Android, iOS).
- **Firebase (Firestore & Auth)**: For real-time data synchronization and secure user management.
- **Gemini AI (Google Generative AI)**: To intelligently verify NGO posts, categorize needs, and calculate priority scores based on text analysis.
- **Google Maps Platform**: To provide geographic intelligence and visualize aid requests on an interactive map.

---

## ✨ Key Features
- **Intelligent Posting**: NGOs post needs that are automatically categorized and verified by **Gemini AI**.
- **Dynamic Prioritization**: Our custom **Recommendation Engine** ranks needs based on urgency, people affected, and AI-verified legitimacy.
- **Real-time Map**: A live geographic overview for volunteers to find nearby high-impact tasks.
- **NGO Dashboard**: A high-level analytics dashboard for resource deployment and status tracking.

---

## 🛠️ Setup & Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/impact_flow.git
   ```
2. **Setup Firebase**:
   - Create a project in the [Firebase Console](https://console.firebase.google.com/).
   - Run `flutterfire configure` to generate `firebase_options.dart`.
3. **API Keys**:
   - Add your **Google Maps API Key** to `web/index.html`.
   - Add your **Gemini API Key** to `lib/services/gemini_service.dart`.
4. **Run the app**:
   ```bash
   flutter pub get
   flutter run -d chrome
   ```

---

## 👥 The Team
*University students dedicated to solving global challenges with technology.*
