import 'package:flutter/material.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/components/components.dart';
import 'package:islam/http/http_surah_request.dart';
import 'package:islam/screens/azkar/azkar.dart';

class Quran extends StatefulWidget {
  const Quran({super.key});

  @override
  State<Quran> createState() => _QuranState();
}


class _QuranState extends State<Quran> {



  late Future<List<dynamic>> surahList;

  @override
  void initState() {
    super.initState();
    surahList = QuranService().fetchSurahs();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/quran_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7),
                BlendMode.colorBurn
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 60,),
              Center(child: Image.asset('assets/images/logo1.png')),
              SizedBox(height: 10,),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    buildContainers(
                        image: 'assets/images/azkar.png',
                        text: 'أذكار',
                        onTap: (){navigateTo(context,Azkar());}
                    ),
                    SizedBox(width: 10,),
                    buildContainers(
                        image: 'assets/images/pray.png',
                        text: 'تعليم الصلاة',
                        onTap: (){}
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text('سور القرءان الكريم',
                style: TextStyle(
                    color: white,
                    fontFamily: 'Janna',
                    fontSize: 20
                ),
              ),
              SizedBox(height: 10,),
              FutureBuilder<List<dynamic>>(
                future: surahList,
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  else if(snapshot.hasData) {
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          var surah = snapshot.data?[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: gold,width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/numberOfAyah.png'),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text('${surah['number']}',
                                        style: TextStyle(
                                            color: white
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${surah['name']} (${surah['englishName']})',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: 'Janna',
                                            fontSize: 18
                                        ),
                                      ),
                                      Text('عدد الآيات: ${surah['numberOfAyahs']}',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: 'Janna',
                                            fontSize: 18
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text('${surah['revelationType']=='Meccan'?'مكية':'مدنية'}',
                                    style: TextStyle(
                                        color: white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder:(context,index)=>SizedBox(height: 10,),
                        itemCount: snapshot.data!.length
                    );
                  }
                  else{
                    return Center(child: Text("لا يوجد بيانات لعرضها",
                      style: TextStyle(
                        fontFamily: 'Janaa',
                        fontSize: 24,
                        color: white
                      ),
                    ));
                  }
                },
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
