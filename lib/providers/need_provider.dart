import 'package:flutter/material.dart';
import '../models/need.dart';
import '../models/impact_zone.dart';
import '../services/recommendation_engine.dart';
import '../services/gemini_service.dart';
import '../services/supabase_service.dart';
import '../data/sample_data.dart';

class NeedProvider with ChangeNotifier {
  final GeminiService _geminiService = GeminiService();
  final SupabaseService _supabaseService = SupabaseService();
  List<Need> _needs = [];
  List<ImpactZone> _zones = SampleData.sampleZones; // Initialize with sample data for demo
  bool _isLoading = true;

  NeedProvider() {
    _listenToNeeds();
    _listenToZones();
  }

  List<Need> get needs {
    return RecommendationEngine.getRecommendedNeeds(_needs);
  }

  List<ImpactZone> get zones => _zones;

  bool get isLoading => _isLoading;

  List<Need> getTopRecommended(int count) {
    final recommended = needs;
    return recommended.take(count).toList();
  }

  void _listenToNeeds() {
    _supabaseService.needsStream.listen((updatedNeeds) {
      if (updatedNeeds.isEmpty) {
        // If Supabase is empty, we could optionally show sample data 
        // but typically in a live app we wait for real data.
        _needs = [];
      } else {
        _needs = updatedNeeds;
      }
      _isLoading = false;
      notifyListeners();
    }, onError: (error) {
      debugPrint('Supabase Stream Error: $error');
      _isLoading = false;
      notifyListeners();
    });
  }

  void _listenToZones() {
    _supabaseService.zonesStream.listen((updatedZones) {
      if (updatedZones.isNotEmpty) {
        _zones = updatedZones;
      }
      notifyListeners();
    }, onError: (error) {
      debugPrint('Supabase Zones Stream Error: $error');
    });
  }

  // Post a need with AI verification (Saved to Supabase)
  Future<void> addNeedWithAI(Need need) async {
    Map<String, dynamic> analysis = {
      'category': 'General',
      'isVerified': false,
    };

    try {
      // 1. Try to analyze with Gemini
      analysis = await _geminiService.analyzeNeed(need.title, need.description);
    } catch (e) {
      debugPrint('Gemini Analysis Failed, using defaults: $e');
      // We continue anyway so the user can still publish their need!
    }
    
    try {
      // 2. Create updated need with findings (or defaults)
      final updatedNeed = Need(
        id: need.id,
        title: need.title,
        description: need.description,
        urgency: need.urgency,
        peopleAffected: need.peopleAffected,
        latitude: need.latitude,
        longitude: need.longitude,
        createdAt: need.createdAt,
        timestamp: DateTime.now(), // Use current time for sorting
        category: analysis['category'] ?? 'General',
        isAiVerified: analysis['isVerified'] ?? false,
      );

      // 3. Save to Supabase
      await _supabaseService.addNeed(updatedNeed);
    } catch (e) {
      debugPrint('Error adding need to Supabase: $e');
      rethrow;
    }
  }

  Future<void> deleteNeed(String id) async {
    try {
      await _supabaseService.deleteNeed(id);
    } catch (e) {
      debugPrint('Error deleting need from Supabase: $e');
    }
  }

  // Helper to seed sample data to Supabase if it's empty
  Future<void> seedSampleData() async {
    for (var need in SampleData.sampleNeeds) {
      await _supabaseService.addNeed(need);
    }
  }
}
