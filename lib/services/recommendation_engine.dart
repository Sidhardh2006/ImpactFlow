import '../models/need.dart';

class RecommendationEngine {
  /// Ranks needs based on urgency, people affected, and recency.
  static List<Need> getRecommendedNeeds(List<Need> needs) {
    if (needs.isEmpty) return [];

    final sortedNeeds = List<Need>.from(needs);
    
    sortedNeeds.sort((a, b) {
      final scoreA = _calculateAIRecommendationScore(a);
      final scoreB = _calculateAIRecommendationScore(b);
      return scoreB.compareTo(scoreA); // Higher score first
    });

    return sortedNeeds;
  }

  static double _calculateAIRecommendationScore(Need need) {
    // Recency Score: newer needs get a higher score.
    // Scale: 0-100 based on hours since creation (up to ~4 days).
    final hoursSinceCreated = DateTime.now().difference(need.timestamp).inHours;
    final recencyScore = (100.0 - hoursSinceCreated).clamp(0.0, 100.0);

    // New Formula: priority = (urgency * 0.5) + (peopleAffected * 0.3) + (recencyScore * 0.2)
    double priority = (need.urgency * 0.5) + (need.peopleAffected * 0.3) + (recencyScore * 0.2);
    
    return priority;
  }
}
