import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  const backendUrl = 'https://kanpai-backend.onrender.com/extract-keywords';
  return ConversationRepository(backendUrl);
});

class ConversationRepository {
  final String _backendUrl;

  ConversationRepository(this._backendUrl);

  Future<List<String>> extractKeywords(String conversation) async {
    try {
      var body = json.encode({'message': conversation});

      var response = await http.post(
        Uri.parse(_backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // レスポンスをデコードし、リストとして返す
      var data = json.decode(response.body);
      return List<String>.from(data);
    } catch (e) {
      print('Error extracting keywords: $e');
      return [];
    }
  }
}
