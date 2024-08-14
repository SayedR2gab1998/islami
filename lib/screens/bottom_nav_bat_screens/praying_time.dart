import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/http/geo_locator.dart';
import 'package:islam/http/http_praying_timing_request.dart';

class PrayingTime extends StatefulWidget {
  const PrayingTime({super.key});

  @override
  State<PrayingTime> createState() => _PrayingTimeState();
}

class _PrayingTimeState extends State<PrayingTime> {

   Future<Map<String, String>>? dates;

   Future<Map<String, dynamic>>? prayerTimes;


  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
  }

  void _loadPrayerTimes() async {
    try {
      Position position = await determinePosition();
      setState(() {
        prayerTimes = PrayerTimeService().getPrayerTimes(position.latitude, position.longitude);
        dates = PrayerTimeService().fetchHijriDate(position.latitude, position.longitude);
      });
    } catch (e) {
      print(e);
    }
  }
   Map<String, String> prayerNamesInArabic = {
    "Fajr": "الفجر",
    "Dhuhr": "الظهر",
    "Asr": "العصر",
    "Maghrib": "المغرب",
    "Isha": "العشاء",
    "Sunrise": "الشروق",
    "Sunset": "الغروب",
    "Imsak": "الإمساك",
    "Midnight": "منتصف الليل",
    "Firstthird": "الثلث الأول من الليل",
    "Lastthird": "الثلث الأخير من الليل",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), // The color to blend with the image.
                BlendMode.colorBurn // The blend mode you choose.
            ),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/praying.png'),
          )
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(height: 60,),
                Image.asset('assets/images/logo1.png'),
                SizedBox(height: 10,),
                FutureBuilder<Map<String,String>>(
                  future: dates,
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    else if(snapshot.hasData)
                    {
                      return Card(
                        color: gold,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('التاريج الميلادي',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Janna',
                                      color: black
                                    ),
                                  ),
                                  Text( '${snapshot.data!['gregorian']}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Janna',
                                        color: black
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('التاريج الهجري',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Janna',
                                        color: black
                                    ),
                                  ),
                                  Text( '${snapshot.data!['hijri']}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Janna',
                                        color: black
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    else {
                      return Text('No data available');
                    }
                  }
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: FutureBuilder<Map<String,dynamic>>(
                    future: prayerTimes,
                    builder: (context,snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      else if (snapshot.hasData) {
                        final timings = snapshot.data!;
                        return Column(
                          children: [
                            Text(
                              ' مواقيت الصلاة حسب مدينتك',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Janna',
                                  color: white
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: timings.entries.map((entry) {
                                  String prayerName = prayerNamesInArabic[entry.key] ?? entry.key;
                                  return Column(
                                    children: [
                                      Card(
                                        color: gold,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(prayerName,
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontFamily: 'Janna',
                                                    color: black
                                                ),
                                              ),
                                              Text(
                                                entry.value,
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontFamily: 'Janna',
                                                    color: black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }
                      else{
                        return Text('لا يوجد بيانات لعرضها',
                          style: TextStyle(
                            fontSize: 24,
                            color: white,
                            fontFamily: 'Janna'
                          ),
                        );
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}