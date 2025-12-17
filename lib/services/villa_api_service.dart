import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/villa.dart';
import '../models/villa_quote.dart';


class VillaApiService {
  // IMPORTANT: use localhost for Windows desktop app
  static const String baseUrl = 'http://127.0.0.1:5000';


  static Future<List<Villa>> fetchAvailableVillas() async {
    final uri = Uri.parse(
      '$baseUrl/v1/villas/availability'
      '?check_in=2025-01-10&check_out=2025-01-13',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load villas');
    }

    final decoded = json.decode(response.body);
    final List data = decoded['data'];

    return data.map((e) => Villa.fromJson(e)).toList();
  }

  static Future<VillaQuote> fetchVillaQuote(String villaId) async {
  final uri = Uri.parse(
    '$baseUrl/v1/villas/$villaId/quote'
    '?check_in=2025-01-10&check_out=2025-01-13',
  );

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to load quote');
  }

  final decoded = json.decode(response.body);
  return VillaQuote.fromJson(decoded);
}

}
