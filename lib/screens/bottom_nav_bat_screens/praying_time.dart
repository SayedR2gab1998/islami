import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/components/components.dart';
import 'package:islam/http/http_praying_timing_request.dart';

class PrayingTime extends StatefulWidget {
  const PrayingTime({super.key});

  @override
  State<PrayingTime> createState() => _PrayingTimeState();
}

class _PrayingTimeState extends State<PrayingTime> {
  String text='';
  var searchCon = TextEditingController();
  late Future<Map<String, String>> dates;


  late Future<Map<String, dynamic>> prayerTimes;
  @override
  void initState() {
    super.initState();
    dates = PrayerTimeService().fetchHijriDate(searchCon.text,);
    prayerTimes = PrayerTimeService().fetchPrayerTimes(searchCon.text);
  }
  @override
  void dispose() {
    searchCon.dispose();
    super.dispose();
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
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
                SizedBox(height: 20,),
                defaultTextFormField(
                  controller: searchCon,
                  validator: (value)=>value!.isEmpty?'Required':null,
                  inputType: TextInputType.text,
                  label: 'مواقيت الصلاه',
                  prefix: 'assets/images/time.png',
                  context: context,
                  onSubmit: (value){
                    setState(() {
                      searchCon.text =value;
                      PrayerTimeService().fetchPrayerTimes(value);
                    });
                  }
                ),
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
                                  Text('التاريج الميلادي',
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
                        Map<String, dynamic> timings = snapshot.data!;
                        if(searchCon.text == ''){
                          return  Text(
                            'ابحث عن مدينتك',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Janna',
                                color: white
                            ),
                          );
                        }
                        else{
                          return Column(
                            children: [
                              Text(
                                'مواقيت الصلاة بمدينة ${searchCon.text}',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: white
                                ),
                              ),

                              Expanded(
                                child: ListView(
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