import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:islam/models/surah_response.dart';




Future<List<Surah>> fetchSurahs() async {
  final response = await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List surahs = data['data'];
    return surahs.map((json) => Surah.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load surahs');
  }
}
