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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'center_latitude': centerLatitude,
      'center_longitude': centerLongitude,
      'radius': radius,
      'intensity': intensity.name,
    };
  }

  factory ImpactZone.fromMap(Map<String, dynamic> map) {
    return ImpactZone(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      centerLatitude: (map['center_latitude'] as num?)?.toDouble() ?? 0.0,
      centerLongitude: (map['center_longitude'] as num?)?.toDouble() ?? 0.0,
      radius: (map['radius'] as num?)?.toDouble() ?? 0.0,
      intensity: ZoneIntensity.values.firstWhere(
        (e) => e.name == map['intensity'],
        orElse: () => ZoneIntensity.moderate,
      ),
    );
  }

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
