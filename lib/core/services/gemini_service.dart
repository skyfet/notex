import 'package:google_generative_ai/google_generative_ai.dart';

/// Simple wrapper around the Google Gemini generative API.
class GeminiService {
  GeminiService(String apiKey)
      : _model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: apiKey,
        );

  final GenerativeModel _model;

  /// Generates a text response for the provided [prompt].
  Future<String> generateText(String prompt) async {
    final response = await _model.generateContent(
      [Content.text(prompt)],
    );
    return response.text ?? '';
  }
}
