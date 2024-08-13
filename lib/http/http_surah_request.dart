import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:islam/models/surah_response.dart';




class QuranService {
  final String baseUrl = "https://api.alquran.cloud/v1";

  Future<List<dynamic>> fetchSurahs() async {
    final response = await http.get(Uri.parse("$baseUrl/surah"));

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> surahList = jsonResponse['data'];
      return surahList;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load Surah list');
    }
  }
}
