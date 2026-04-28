import 'package:flutter/material.dart';

enum ZoneIntensity {
  critical, // Red
  moderate, // Yellow
  safe,     // Green
}

class ImpactZone {
  final String id;
  final String name;
  final double centerLatitude;
  final double centerLongitude;
  final double radius; // In relative units or meters
  final ZoneIntensity intensity;

  ImpactZone({
    required this.id,
    required this.name,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.radius,
    required this.intensity,
  });

  Color get color {
    switch (intensity) {
      case ZoneIntensity.critical:
        return const Color(0xFFEF4444); // Red
      case ZoneIntensity.moderate:
        return const Color(0xFFF59E0B); // Amber/Yellow
      case ZoneIntensity.safe:
        return const Color(0xFF10B981); // Green
    }
  }
}
