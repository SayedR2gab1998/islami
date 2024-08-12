import 'dart:convert';

import 'package:islam/models/radio_model.dart';
import 'package:http/http.dart'as http;

Future<RadioStation> fetchRadioStations() async {
  final response = await http.get(
      Uri.parse('https://mp3quran.net/api/v3/radios?language=ar'));

  if (response.statusCode == 200) {
    return RadioStation.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load radio stations');
  }
}