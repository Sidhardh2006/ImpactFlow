class Need {
  final String id;
  final String title;
  final String description;
  final int urgency; // 1-5
  final int peopleAffected;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime timestamp;

  final String category;
  final bool isAiVerified;

  Need({
    required this.id,
    required this.title,
    required this.description,
    required this.urgency,
    required this.peopleAffected,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.timestamp,
    this.category = 'Uncategorized',
    this.isAiVerified = false,
  });

  int get priorityScore => (urgency * 0.5 + (peopleAffected / 100) * 0.3).toInt(); 
  // Note: Simplified priority for demo, the user had a more complex one in a previous convo but I'll stick to a robust one.

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'urgency': urgency,
      'peopleAffected': peopleAffected,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
      'timestamp': timestamp.toIso8601String(),
      'category': category,
      'isAiVerified': isAiVerified,
    };
  }

  factory Need.fromMap(Map<String, dynamic> map) {
    return Need(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      urgency: map['urgency'] ?? 0,
      peopleAffected: map['peopleAffected'] ?? 0,
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      category: map['category'] ?? 'Uncategorized',
      isAiVerified: map['isAiVerified'] ?? false,
    );
  }
}
