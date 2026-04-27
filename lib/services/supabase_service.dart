import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/need.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  // Stream of needs for real-time updates
  Stream<List<Need>> get needsStream {
    return _client
        .from('needs')
        .stream(primaryKey: ['id'])
        .order('timestamp', ascending: false)
        .map((data) => data.map((map) => Need.fromMap(map)).toList());
  }

  // Fetch needs once (initial load)
  Future<List<Need>> getNeeds() async {
    final response = await _client
        .from('needs')
        .select()
        .order('timestamp', ascending: false);
    
    return (response as List).map((map) => Need.fromMap(map)).toList();
  }

  // Add a new need
  Future<void> addNeed(Need need) async {
    await _client.from('needs').insert(need.toMap());
  }

  // Update a need
  Future<void> updateNeed(Need need) async {
    await _client
        .from('needs')
        .update(need.toMap())
        .eq('id', need.id);
  }

  // Delete a need
  Future<void> deleteNeed(String id) async {
    await _client.from('needs').delete().eq('id', id);
  }
}
