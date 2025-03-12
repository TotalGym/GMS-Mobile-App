import 'dart:convert';
import 'dart:io';

import 'package:gmn/values/open_ai.dart';

Future<String> fetchOpenAIResponse(String prompt) async {
  const apiKey = AIChatValues.key;
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $apiKey',
  };
  final body = jsonEncode({
    'model': 'gpt-4o',
    'messages': [
      {'role': 'user', 'content': prompt}
    ],
  });

  final client = HttpClient();
  try {
    final request = await client.postUrl(url);
    headers.forEach((key, value) {
      request.headers.set(key, value);
    });
    request.add(utf8.encode(body));
    final response = await request.close();

    if (response.statusCode == 200) {
      final responseBody = await response.transform(utf8.decoder).join();
      final data = jsonDecode(responseBody);
      return data['choices'][0]['message']['content'];
    } else {
      return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
    }
  } catch (e) {
    return 'Exception: $e';
  } finally {
    client.close();
  }
}
