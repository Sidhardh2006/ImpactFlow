# 🚀 ImpactFlow: Presentation & Technical Guide

This guide summarizes the workflow, limitations, and future improvements for your demo.

---

## 🏗️ 1. Working Flow (The "Story")

1.  **Need Identification (NGO Side)**:
    *   An NGO user enters a crisis requirement (e.g., "Medical Supplies Needed") in the **NGO Portal**.
2.  **AI-Powered Triage (The Intelligence)**:
    *   The app sends the request to **Gemini 3 Flash Preview**.
    *   The AI instantly analyzes the text to determine the **Category** (Healthcare, Food, etc.) and suggests an **Urgency Level**.
    *   It performs a **Legitimacy Check** to verify if the description sounds realistic.
3.  **Real-Time Sync (The Cloud)**:
    *   The analyzed "Need" is saved to **Supabase**.
    *   Because we use **PostgreSQL Streams**, every other user (Volunteers) gets a real-time update on their device without even refreshing the page.
4.  **Prioritized Action (Volunteer Side)**:
    *   The **Recommendation Engine** calculates a priority score.
    *   The **Volunteer Dashboard** automatically sorts the most critical, life-threatening needs to the top.
    *   The **Impact Map** visualizes the crisis signals geographically.

---

## ⚠️ 2. Current Limitations (Honest Assessment)

*   **Authentication**: We are currently using a "Public" access mode (`anon` role). In a production app, we would add secure logins for NGOs and Volunteers.
*   **Human Verification**: While the AI triage is fast, a real-world system would eventually need a human "Command Center" to confirm high-urgency reports.
*   **Map API**: We are currently using a simulated map environment for the prototype. A full deployment would require a live Google Maps Billing Key.
*   **Media Support**: Currently, we only handle text. Future versions should allow users to upload photos of the crisis area for better verification.

---

## 📈 3. Future Improvements (The Roadmap)

*   **Volunteer Commitment**: Add a "I can help" button that allows volunteers to claim a task and update its status to "In Progress" or "Fulfilled."
*   **Proximity Alerts**: Implement push notifications that alert volunteers when a high-urgency need is posted within 5km of their location.
*   **SMS Integration**: For areas with poor internet, allow NGOs to post needs via a simple SMS gateway that the AI can still process.
*   **Analytics for Governments**: A heat-map dashboard for government officials to see which resources (e.g., Water vs. Medicine) are in highest demand across the country.

---

## 💡 4. Top 3 "Wow" Factors for Judges
1.  **Zero-Latency Sync**: Show how posting on one device updates the other instantly via Supabase.
2.  **Gemini 3 Intelligence**: Show how the AI "understands" the difference between a minor request and a life-threatening crisis.
3.  **Scalable Tech**: You are using the same tech (Flutter + Postgres) that massive apps like Instagram or Robinhood use.
