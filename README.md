# ImpactFlow 🌊
**Intelligent Humanitarian Coordination | Google Solutions Challenge 2024**

ImpactFlow is a real-time coordination platform that bridges the gap between ground-level humanitarian needs and volunteer action. By combining **Gemini 3 AI** for automated triage with **Supabase** for zero-latency data streaming, ImpactFlow ensures that life-critical resources reach the right people at the right time.

---

## 🎯 UN Sustainable Development Goals (SDGs)
ImpactFlow directly addresses three key UN SDGs:
- **SDG 3: Good Health and Well-being**: Prioritizing urgent medical needs in disaster zones.
- **SDG 11: Sustainable Cities and Communities**: Strengthening community resilience through faster disaster response.
- **SDG 17: Partnerships for the Goals**: Connecting NGOs and volunteers on a unified, real-time platform.

---

## 🚀 Google & Modern Tech Stack
To achieve maximum impact and scalability, we utilized:
- **Flutter**: For a high-performance, premium, and cross-platform UI.
- **Gemini 3 Flash AI**: Our "Intelligence Engine" that automatically analyzes, categorizes, and verifies the legitimacy of crisis reports.
- **Supabase (PostgreSQL)**: To handle real-time data synchronization via PostgreSQL Streams, ensuring zero-latency updates for volunteers.
- **GitHub Actions**: For automated CI/CD and deployment.

---

## ✨ Key Features
- **AI-Powered Triage**: Uses Gemini 1.5 Flash to intelligently analyze NGO posts and assign priority scores based on severity and impact.
- **Zero-Latency Sync**: Volunteers see new disaster signals instantly on their dashboard without needing to refresh the page.
- **Dynamic Impact Map**: A geographic overview using **Impact Zones** (Red/Yellow/Green) to visualize crisis hotspots and safe hubs.
- **Intelligent Recommendation Engine**: A custom algorithm that ranks tasks using a weighted formula: `(Urgency * 0.5) + (Affected People * 0.3) + (Recency * 0.2)`.

---

## 🛠️ Setup & Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/Sidhardh2006/ImpactFlow.git
   ```
2. **Environment Variables**:
   Ensure you have your **Supabase URL/Key** and **Gemini API Key** configured in your environment or service files.
3. **Run the app**:
   ```bash
   flutter pub get
   flutter run -d chrome
   ```

---

## 👥 The Team
*University students dedicated to solving global challenges through advanced agentic coding and AI.*
