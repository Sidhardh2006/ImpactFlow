import 'package:flutter/material.dart';
import 'ngo_screen.dart';
import 'volunteer_screen.dart';
import 'map_screen.dart';
import 'map_dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF673AB7), // Deep Purple
              Color(0xFF512DA8),
              Color(0xFF311B92),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.volunteer_activism,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'ImpactFlow',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Directing aid where it matters most.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w300,
                      ),
                ),
                const SizedBox(height: 60),
                _buildPortalButton(
                  context,
                  title: 'NGO Portal',
                  subtitle: 'Post urgent community needs',
                  icon: Icons.business_rounded,
                  color: Colors.white,
                  textColor: const Color(0xFF673AB7),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NgoScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildPortalButton(
                  context,
                  title: 'Impact Map',
                  subtitle: 'Visualize aid requests on a map',
                  icon: Icons.map_rounded,
                  color: Colors.white.withOpacity(0.2),
                  textColor: Colors.white,
                  borderColor: Colors.white.withOpacity(0.3),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MapScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildPortalButton(
                  context,
                  title: 'Volunteer Portal',
                  subtitle: 'Explore prioritized aid requests',
                  icon: Icons.person_search_rounded,
                  color: Colors.transparent,
                  textColor: Colors.white,
                  borderColor: Colors.white.withOpacity(0.5),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VolunteerScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildPortalButton(
                  context,
                  title: 'Intelligent Dashboard',
                  subtitle: 'AI-driven geographic intelligence',
                  icon: Icons.analytics_rounded,
                  color: Colors.white.withOpacity(0.1),
                  textColor: Colors.white,
                  borderColor: Colors.white.withOpacity(0.2),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MapDashboardScreen()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                Text(
                  'TARGETING UN SDGs',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSdgBadge('2', 'Zero Hunger', Colors.orange),
                      _buildSdgBadge('11', 'Sustainable Cities', Colors.amber),
                      _buildSdgBadge('17', 'Partnerships', Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

  Widget _buildSdgBadge(String number, String title, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              number,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildPortalButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 2)
              : null,
          boxShadow: color != Colors.transparent
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: textColor, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                color: textColor.withOpacity(0.5), size: 18),
          ],
        ),
      ),
    );
  }
}
