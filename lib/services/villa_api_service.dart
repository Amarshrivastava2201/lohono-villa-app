import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/villa.dart';
import '../models/villa_quote.dart';

class VillaApiService {
  static const String baseUrl = 'http://127.0.0.1:5000';

 static Future<List<String>> fetchLocations() async {
  final today = DateTime.now();

  final uri = Uri.parse('$baseUrl/v1/villas/availability').replace(
    queryParameters: {
      'check_in': today.add(const Duration(days: 1)).toIso8601String(),
      'check_out': today.add(const Duration(days: 4)).toIso8601String(),
    },
  );

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to load locations');
  }

  final decoded = json.decode(response.body);
  final List data = decoded['data'];

  // Extract unique locations from villa data
  return data
      .map((e) => e['location'].toString())
      .toSet()
      .toList();
}


  static Future<List<Villa>> fetchAvailableVillas({
  required String location,
  DateTime? checkIn,
  DateTime? checkOut,
}) async {
  final Map<String, String> queryParams = {
    'location': location,
  };

  if (checkIn != null && checkOut != null) {
    queryParams['check_in'] = checkIn.toIso8601String();
    queryParams['check_out'] = checkOut.toIso8601String();
  }

  final uri = Uri.parse('$baseUrl/v1/villas/availability')
      .replace(queryParameters: queryParams);

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch villas');
  }

  final json = jsonDecode(response.body);
  final List data = json['data'];

  return data.map((e) => Villa.fromJson(e)).toList();
}


 static Future<VillaQuote> fetchVillaQuote({
  required String villaId,
  required DateTime checkIn,
  required DateTime checkOut,
}) async {
  final uri = Uri.parse(
    '$baseUrl/v1/villas/$villaId/quote',
  ).replace(queryParameters: {
    'check_in': checkIn.toIso8601String(),
    'check_out': checkOut.toIso8601String(),
  });

  final response = await http.get(uri);


  if (response.statusCode != 200) {
    throw Exception('Failed to fetch quote');
  }
 
  return VillaQuote.fromJson(
    jsonDecode(response.body),
  );
}



  
}
