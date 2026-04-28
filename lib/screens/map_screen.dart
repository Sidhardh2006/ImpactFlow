import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/need_provider.dart';
import '../models/need.dart';
import '../models/impact_zone.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulated Impact Map'),
      ),
      body: Consumer<NeedProvider>(
        builder: (context, provider, child) {
          final needs = provider.needs;

          return Container(
            color: const Color(0xFF0F172A), // Dark blueprint background
            child: Stack(
              children: [
                // Grid Pattern
                Positioned.fill(
                  child: CustomPaint(
                    painter: GridPainter(),
                  ),
                ),
                // "Scanning" Effect
                _buildScanningEffect(),
                // Impact Zones
                ...provider.zones.map((zone) => _buildImpactZone(context, zone)),
                // Mock Markers
                ...needs.map((need) => _buildMockMarker(context, need)),
                // Legend
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: _buildLegend(),
                ),
                // Status Bar
                Positioned(
                  top: 20,
                  right: 20,
                  child: _buildStatusBar(needs.length),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildScanningEffect() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            Colors.blue.withOpacity(0.05),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildMockMarker(BuildContext context, Need need) {
    // Map GPS to relative screen coordinates for simulation (Centered on Mumbai)
    const double centerLng = 72.8777;
    const double centerLat = 19.0760;
    final double relX = (need.longitude - centerLng) * 8000 + MediaQuery.of(context).size.width / 2;
    final double relY = -(need.latitude - centerLat) * 8000 + MediaQuery.of(context).size.height / 2;

    final Color color = _getPriorityColor(need.priorityScore);

    return Positioned(
      left: relX.clamp(20, MediaQuery.of(context).size.width - 20),
      top: relY.clamp(20, MediaQuery.of(context).size.height - 120),
      child: GestureDetector(
        onTap: () => _showNeedDetails(need),
        child: Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.6), blurRadius: 12, spreadRadius: 4),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Container(
              constraints: const BoxConstraints(maxWidth: 120),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color.withOpacity(0.5), width: 1),
              ),
              child: Text(
                need.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactZone(BuildContext context, ImpactZone zone) {
    const double centerLng = 72.8777;
    const double centerLat = 19.0760;
    final double relX = (zone.centerLongitude - centerLng) * 8000 + MediaQuery.of(context).size.width / 2;
    final double relY = -(zone.centerLatitude - centerLat) * 8000 + MediaQuery.of(context).size.height / 2;

    final double screenRadius = zone.radius * 8000;

    return Positioned(
      left: relX - screenRadius,
      top: relY - screenRadius,
      child: Container(
        width: screenRadius * 2,
        height: screenRadius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: zone.color.withOpacity(0.15),
          border: Border.all(color: zone.color.withOpacity(0.3), width: 1),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _legendItem('High Urgency', Colors.redAccent),
          _legendItem('Medium Urgency', Colors.orangeAccent),
          _legendItem('Standard', Colors.greenAccent),
          const Divider(color: Colors.white10),
          _legendItem('Critical Zone', Colors.red.withOpacity(0.3)),
          _legendItem('Moderate Zone', Colors.orange.withOpacity(0.3)),
          _legendItem('Safe Hub', Colors.green.withOpacity(0.3)),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Container(width: 8, height: 8, color: color),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildStatusBar(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Text(
        'ACTIVE SIGNALS: $count',
        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }

  Color _getPriorityColor(int score) {
    if (score >= 4) return const Color(0xFFEF4444); // Bright Red
    if (score >= 3) return const Color(0xFFF59E0B); // Amber
    return const Color(0xFF10B981); // Emerald Green
  }

  void _showNeedDetails(Need need) {
    final provider = context.read<NeedProvider>();
    final sortedNeeds = provider.needs;
    final index = sortedNeeds.indexWhere((n) => n.id == need.id);
    final isRecommended = index != -1 && index < 3;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (isRecommended)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.withOpacity(0.5)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bolt, size: 14, color: Colors.amber),
                        SizedBox(width: 4),
                        const Text(
                          'AI RECOMMENDED',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (need.isAiVerified)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.withOpacity(0.5)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, size: 14, color: Colors.blue),
                        SizedBox(width: 4),
                        const Text(
                          'AI VERIFIED',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purple.withOpacity(0.5)),
                  ),
                  child: Text(
                    need.category.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    need.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Score: ${need.priorityScore}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              need.description,
              style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Interested in "${need.title}"'),
                          const Text(
                            'You are a strong match for this task based on urgency and impact',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
                child: const Text('Express Interest'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    const step = 40.0;
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
