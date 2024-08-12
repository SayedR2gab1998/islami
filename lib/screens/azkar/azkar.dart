import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:iconsax/iconsax.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/components/components.dart';
import 'package:islam/screens/azkar/azkar_details.dart';

class Azkar extends StatefulWidget {
  const Azkar({super.key,});

  @override
  State<Azkar> createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {

  late Future<List<dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = loadJsonData();
  }

  Future<List<dynamic>> loadJsonData() async {

    final jsonString = await rootBundle.loadString('assets/azkar.json');

    final jsonResponse = json.decode(jsonString);
    return jsonResponse;
  }



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          leading: IconButton(
            icon: Icon(Iconsax.arrow_right,color: white,),
            onPressed: (){Navigator.pop(context);},
          ),
          title: Text('أذكار',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Janna',
              color: white
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: loadJsonData(),
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found'));
              }
              final data = snapshot.data!;
              return ListView.separated(
                itemBuilder: (context,index){
                  final item = data[index];
                  return GestureDetector(
                    onTap: (){
                      navigateTo(context, AzkarDetails(item: item));
                    },
                    child: Card(
                      color: gold,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/numberOfAyah.png',),
                                ),
                              ),
                              child: Center(
                                child: Text('${item['id']}',
                                  style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Janna',
                                    fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text('${item['category']}',
                                maxLines: 3,
                                style: TextStyle(
                                  fontFamily: 'Janna',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Icon(Iconsax.arrow_left_1),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index)=>SizedBox(height: 10,),
                itemCount: data.length
              );
            }
          ),
        ),
      ),
    );
  }
}
