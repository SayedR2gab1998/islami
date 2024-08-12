// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:islam/components/colors.dart';
// import 'package:islam/http/http_surah_request.dart';
// import 'package:islam/models/surah_response.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     futureSurahs = fetchSurahs();
//     futureSurahs.then((surahs) {
//       setState(() {
//         allSurahs = surahs;
//         filteredSurahs = surahs;
//       });
//     });
//   }
//
//   void updateSearchQuery(String query) {
//     setState(() {
//       searchQuery = query;
//       filteredSurahs = allSurahs
//           .where((surah) =>
//           surah.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           leading: IconButton(
//             onPressed: (){Navigator.pop(context);},
//             icon: Icon(Iconsax.arrow_right,color: white,),
//           ),
//           title: Text('بحث السور',
//             style: TextStyle(
//               fontSize: 24,
//               fontFamily: 'Janna',
//               color: white
//             ),
//           ),
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(50.0),
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: TextField(
//                 onChanged: updateSearchQuery,
//                 style: TextStyle(
//                   color: white
//                 ),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'بحث بالسورة',
//                   hintStyle: TextStyle(
//                     color: white
//                   )
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/quran_background.png'),
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(
//                 Colors.black.withOpacity(0.7), // The color to blend with the image.
//                 BlendMode.colorBurn // The blend mode you choose.
//               ),
//             )
//           ),
//           child: filteredSurahs.isEmpty
//               ? Center(child: Text('ابدأ البحث بالسورة',
//             style: TextStyle(fontSize: 24,fontFamily: 'Janna',color: white),
//           ),)
//               : ListView.builder(
//             itemCount: filteredSurahs.length,
//             itemBuilder: (context, index) {
//               final surah = filteredSurahs[index];
//               return Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: gold,width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
//                   child: Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/numberOfAyah.png'),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Text('${surah.number}',
//                             style: TextStyle(
//                                 color: white
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 20,),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('${surah.name}',
//                             style: TextStyle(
//                                 color: white,
//                                 fontFamily: 'Janna',
//                                 fontSize: 18
//                             ),
//                           ),
//                           Text('${surah.englishName}',
//                             style: TextStyle(
//                                 color: white,
//                                 fontFamily: 'Janna',
//                                 fontSize: 18
//                             ),
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       Text('${surah.revelationType=='Meccan'?'مكية':'مدنية'}',
//                         style: TextStyle(
//                             color: white
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
