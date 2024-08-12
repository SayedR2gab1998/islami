import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/components/components.dart';
import 'package:islam/models/radio_model.dart';
import 'package:http/http.dart' as http;
import 'package:islam/screens/radio_details.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {


  late Future<RadioStation> futureRadioStations;

  Future<List<dynamic>> fetchRadioStations() async {
    final response = await http.get(
        Uri.parse('https://mp3quran.net/api/v3/radios?language=ar'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['radios'];
    } else {
      throw Exception('Failed to load radio stations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8), // The color to blend with the image.
              BlendMode.colorBurn // The blend mode you choose.
            ),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/radio_background.png'),
          )
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 60,),
            Center(child: Image.asset('assets/images/logo1.png')),
            SizedBox(height: 10,),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: fetchRadioStations(),
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No radio stations available.'));
                  }
                  else{
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                          var radioStation = snapshot.data![index];
                          return GestureDetector(
                            onTap: (){navigateTo(context,RadioDetails(
                                name: radioStation['name'],
                                url: radioStation['url'],
                            ));},
                            child: Card(
                              color: gold,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(Iconsax.radio),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(radioStation['name'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Janna'
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context,index)=>SizedBox(height: 10,),
                        itemCount: snapshot.data!.length
                      ),
                    );
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

