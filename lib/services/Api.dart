import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> fetchImages(String query) async {
  final String clientId = 'YOUR_UNSPLASH_ACCESS_KEY'; // Sostituisci con il tuo access key
  final String baseUrl = 'https://api.unsplash.com';
  final String path = '/search/photos';
  final String queryParameters = '?query=$query';

  final Uri uri = Uri.parse('$baseUrl$path$queryParameters');

  try {
    final response = await http.get(uri, headers: {
      'Authorization': 'Client-ID $clientId',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      
      print(responseData);
    } else {
      print('Errore nella richiesta: ${response.statusCode}');
    }
  } catch (e) {
    print('Errore durante la richiesta: $e');
  }
}
