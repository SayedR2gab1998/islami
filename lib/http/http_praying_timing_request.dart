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


class PrayerTimeService {
  final String baseUrl = "https://api.aladhan.com/v1/timingsByCity";

  Future<Map<String, dynamic>> fetchPrayerTimes( String city,) async {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final String url = 'https://api.aladhan.com/v1/timingsByCity/$date?city=$city&country=egypt';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      Map<String, dynamic> timings = jsonResponse['data']['timings'];

      Map<String, dynamic> formattedTimings = {};
      timings.forEach((key, value) {
        final time = DateFormat("HH:mm").parse(value);
        final formattedTime = DateFormat("hh:mm a").format(time);
        formattedTimings[key] = formattedTime;
      });


      return formattedTimings;

    } else {
      throw Exception('Failed to load prayer times');
    }
  }


  Future<Map<String,String>> fetchHijriDate( String city) async {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final String url = 'https://api.aladhan.com/v1/timingsByCity/$date?city=$city&country=egypt';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      Map<String, dynamic> data = jsonResponse['data']['date'];

      Map<String, dynamic> hijriDate = data['hijri'];
      Map<String, dynamic> gregorianDate = data['gregorian'];

      String hijri = "${hijriDate['day']} ${hijriDate['month']['ar']} ${hijriDate['year']}";
      String gregorian = "${gregorianDate['date']}";

      return {
        "hijri": hijri,
        "gregorian": gregorian,
      };
    } else {
      throw Exception('Failed to load Hijri date');
    }
  }
}