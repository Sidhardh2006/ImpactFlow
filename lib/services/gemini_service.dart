import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/need.dart';

class GeminiService {
  // IMPORTANT: The user must provide their own API key.
  // In a real app, this should be handled via a secure backend or environment variable.
  static const String _apiKey = 'AIzaSyDGO1r3A9ed14MC6NuXUcygAasVxpEAhaY'; 

  final GenerativeModel _model;

  GeminiService()
      : _model = GenerativeModel(
          model: 'gemini-3-flash-preview',
          apiKey: _apiKey,
        );

  Future<Map<String, dynamic>> analyzeNeed(String title, String description) async {
    if (_apiKey.contains('YOUR_GEMINI') || _apiKey.isEmpty) {
      return {
        'category': 'General',
        'suggestedUrgency': 3,
        'isVerified': false,
      };
    }

    final prompt = '''
    Analyze the following community need and provide a JSON response with:
    1. "category": Choose one from [Healthcare, Food Security, Disaster Relief, Infrastructure, Education, Water & Sanitation].
    2. "suggestedUrgency": A number from 1 to 5 based on how life-threatening or time-sensitive it is.
    3. "isVerified": True if the description sounds legitimate and detailed, false otherwise.

    Title: $title
    Description: $description
    ''';

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      // Basic JSON extraction from response (Gemini sometimes wraps in ```json)
      String text = response.text ?? '{}';
      text = text.replaceAll('```json', '').replaceAll('```', '').trim();
      
      // In a production app, use a proper JSON parser with error handling
      // For the prototype, we return the raw text or a mock if it fails
      return {
        'raw': text,
        'isVerified': text.contains('true'),
      };
    } catch (e) {
      print('Gemini Error: $e');
      return {
        'category': 'Pending Review',
        'suggestedUrgency': 3,
        'isVerified': false,
      };
    }
  }
}
