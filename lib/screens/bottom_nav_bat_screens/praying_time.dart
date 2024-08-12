import 'package:flutter/material.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/components/components.dart';
import 'package:islam/http/http_praying_timing_request.dart';
import 'package:islam/models/praying_model.dart';

class PrayingTime extends StatefulWidget {
  const PrayingTime({super.key});

  @override
  State<PrayingTime> createState() => _PrayingTimeState();
}

class _PrayingTimeState extends State<PrayingTime> {

  var searchCon = TextEditingController();

  PrayerTimesData? prayerTimesData;


  @override
  void dispose() {
    searchCon.dispose();
    super.dispose();
  }

  Future<void> fetchPrayerTimes() async {

    String city = searchCon.text.trim();

    PrayerTimesService service = PrayerTimesService();
    PrayerTimesData? data = await service.fetchPrayerTimes(
      city: city,
    );

    setState(() {
      prayerTimesData = data;
    });
  }

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
                      fetchPrayerTimes();
                    });
                  }
                ),
                SizedBox(height: 20,),
                if(searchCon.text == '')
                  Text('ابحث عن مواقيت الصلاه في مدينتك',
                    style: TextStyle(
                      fontFamily: 'Janna',
                      color: white,
                      fontSize: 24,
                    ),
                  ),
                if(searchCon.text != '')
                  Center(
                    child: Text('مواقيت الصلاه بمدينة ${searchCon.text}',
                    style: TextStyle(
                      fontFamily: 'Janna',
                      color: white,
                      fontSize: 24,
                    ),
                                    ),
                  ),
                if(searchCon.text != '')
                  Expanded(
                    child: ListView(
                      children: [
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('الفجر',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.fajr,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('الشروق',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.sunrise,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('الظهر',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.dhuhr,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('العصر',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.asr,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('الغروب',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.sunset,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('المغرب',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.maghrib,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('العشاء',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.isha,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('منتصف الليل',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.midnight,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('الثلث الأول من الليل',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.firstThird,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: gold,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('الثلث الأحير من الليل',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                                Text(prayerTimesData!.timings.lastThird,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Janna',
                                    color: black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                // isLoading
                //     ? Center(child: CircularProgressIndicator())
                //     : prayerTimesData == null
                //     ? Center(child: Text('ابحث عن مدينتك',
                //   style: TextStyle(
                //     fontFamily: 'Janna',
                //     fontSize: 24,
                //     color: white
                //   ),
                // ))
                //     :
              ],
            ),
          ),
        ),
      ),
    );
  }
}