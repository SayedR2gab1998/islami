import 'dart:convert';
import 'package:http/http.dart'as http;



class PrayerTimeService {
  final String apiUrl = "https://api.aladhan.com/v1/timings";
  Future<Map<String,String>> fetchHijriDate( double latitude, double longitude) async {
    final response = await http.get(Uri.parse('$apiUrl?latitude=$latitude&longitude=$longitude&method=2'));
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
  Future<Map<String, dynamic>> getPrayerTimes(double latitude, double longitude) async {

    final response = await http.get(Uri.parse('$apiUrl?latitude=$latitude&longitude=$longitude&method=2'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['timings'];
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}



// data by location


