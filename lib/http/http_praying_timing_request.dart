import 'dart:convert';


import 'package:intl/intl.dart';
import 'package:islam/models/praying_model.dart';
import 'package:http/http.dart'as http;



class PrayerTimesService {
  Future<PrayerTimesData?> fetchPrayerTimes({required String city,}) async {

    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final String apiUrl = 'https://api.aladhan.com/v1/timingsByCity/$date?city=$city&country=egypt';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the JSON data
        final Map<String, dynamic> data = json.decode(response.body)['data'];
        return PrayerTimesData.fromJson(data);
      } else {
        // Handle other status codes
        print('Failed to load prayer times: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error fetching prayer times: $e');
      return null;
    }
  }
}