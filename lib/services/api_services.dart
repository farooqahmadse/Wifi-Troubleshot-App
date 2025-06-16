// lib/services/api_service.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://192.168.100.17:5000';

  static Future<Map<String, dynamic>> getDevices() async {
    final response = await http.get(Uri.parse('$baseUrl/devices'));
    return json.decode(response.body);
  }

  static Future<List<dynamic>> getSuggestions() async {
    final response = await http.get(Uri.parse('$baseUrl/suggestions'));
    return json.decode(response.body);
  }
}
