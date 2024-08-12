import 'package:flutter/material.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/components/components.dart';
import 'package:islam/http/http_surah_request.dart';
import 'package:islam/models/surah_response.dart';
import 'package:islam/screens/azkar/azkar.dart';

class Quran extends StatefulWidget {
  const Quran({super.key});

  @override
  State<Quran> createState() => _QuranState();
}


class _QuranState extends State<Quran> {

  String removeDiacritics(String input){

    return removeDiacritics(input);
  }



  late Future<List<Surah>> futureSurahs ;
  List<Surah> _surahs = [];
  List<Surah> _filteredSurahs = [];
  var search = TextEditingController();




  @override
  void initState() {
    super.initState();
    futureSurahs = fetchSurahs();
    futureSurahs.then((surah) {
      setState(() {
        _surahs = surah;
        _filteredSurahs = surah;
      });
    });
  }

  void filter(String query){
    List<Surah> filteredSurahs = _surahs.where((surah){
      return surah.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredSurahs = filteredSurahs;
    });
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
              Colors.black.withOpacity(0.7), // The color to blend with the image.
              BlendMode.colorBurn // The blend mode you choose.
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
              defaultTextFormField(
                  controller: search,
                  validator: (value)=>value!.isEmpty?'أدخل اسم السورة': null,
                  inputType: TextInputType.text,
                  label: 'بحث بالسورة',
                  prefix: 'assets/images/quran.png',
                  context: context,
                  onChanged: filter
              ),
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
              if(_filteredSurahs.isNotEmpty)
                FutureBuilder<List<Surah>>(
                  future: futureSurahs,
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No data found'));
                    }
                    else{
                      return Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 10),
                          itemCount: _filteredSurahs.length,
                          itemBuilder: (context,index){
                            final surah = _filteredSurahs[index];
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
                                        child: Text('${surah.number}',
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
                                        Text('${surah.name}',
                                          style: TextStyle(
                                              color: white,
                                              fontFamily: 'Janna',
                                              fontSize: 18
                                          ),
                                        ),
                                        Text('${surah.englishName}',
                                          style: TextStyle(
                                              color: white,
                                              fontFamily: 'Janna',
                                              fontSize: 18
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text('${surah.revelationType=='Meccan'?'مكية':'مدنية'}',
                                      style: TextStyle(
                                          color: white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context,index)=>SizedBox(height: 10,),
                        ),
                      );
                    }
                  },
                ),
              if(_filteredSurahs.isEmpty)
                Expanded(
                  child: FutureBuilder(
                      future: futureSurahs,
                      builder: (context,snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No data found'));
                        }
                        final surahs = snapshot.data!;
                        return Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(top: 10),
                            itemCount: surahs.length,
                            itemBuilder: (context,index){
                              final surah = surahs[index];
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
                                          child: Text('${surah.number}',
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
                                          Text('${surah.name}',
                                            style: TextStyle(
                                                color: white,
                                                fontFamily: 'Janna',
                                                fontSize: 18
                                            ),
                                          ),
                                          Text('${surah.englishName}',
                                            style: TextStyle(
                                                color: white,
                                                fontFamily: 'Janna',
                                                fontSize: 18
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Text('${surah.revelationType=='Meccan'?'مكية':'مدنية'}',
                                        style: TextStyle(
                                            color: white
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context,index)=>SizedBox(height: 10,),
                          ),
                        );
                      }
                  ),
                ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
