
import 'package:flutter/material.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/screens/bottom_nav_bat_screens/bearish.dart';
import 'package:islam/screens/bottom_nav_bat_screens/hadith.dart';
import 'package:islam/screens/bottom_nav_bat_screens/praying_time.dart';
import 'package:islam/screens/bottom_nav_bat_screens/quran.dart';
import 'package:islam/screens/bottom_nav_bat_screens/radio.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> bottomScreens = [
    Quran(),
    Hadith(),
    Bearish(),
    RadioScreen(),
    PrayingTime(),
  ];
  int currentIndex = 0;
  List<String> titles = ['Chat','Groups','Contacts','Setting'];
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          backgroundColor: gold,
          elevation: 0.0,
          selectedIndex: currentIndex,

          onDestinationSelected: (value) {
            setState(() {
              currentIndex = value;
              pageController.jumpToPage(value);
            });
          },
          destinations: [
            NavigationDestination(icon: ImageIcon(AssetImage('assets/images/quran.png')), label: 'القرءان',),
            NavigationDestination(icon: ImageIcon(AssetImage('assets/images/hadith.png')), label: 'الحديث'),
            NavigationDestination(icon: ImageIcon(AssetImage('assets/images/bearish.png')), label: 'المسبحة'),
            NavigationDestination(icon: ImageIcon(AssetImage('assets/images/radio.png')), label: 'الإذاعة'),
            NavigationDestination(icon: ImageIcon(AssetImage('assets/images/time.png')), label: 'التوقيت'),
          ],
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (value){
            setState(() {
              currentIndex = value;
            });
          },
          children: const [
            Quran(),
            Hadith(),
            Bearish(),
            RadioScreen(),
            PrayingTime(),
          ],
        ),
      ),
    );
  }
}
