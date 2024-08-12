import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islam/components/cache_helper.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/components/components.dart';
import 'package:islam/home/main_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../translations/locale_keys.g.dart';


class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body
  });
}



class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  Color containerBackground = gold;
  bool isSelected = true;
  bool isEnglish = true;

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onBoarding1.png',
      title: LocaleKeys.welcome_to_islami.tr(),
      body: LocaleKeys.on_boarding_1.tr(),
    ),
    BoardingModel(
        image: 'assets/images/onBoarding2.png',
        title: LocaleKeys.on_boarding_title_2.tr(),
        body:  LocaleKeys.on_boarding_2.tr(),
    ),
    BoardingModel(
        image: 'assets/images/onBoarding3.png',
        title: LocaleKeys.on_boarding_title_3.tr(),
        body:  LocaleKeys.on_boarding_3.tr(),
    ),
    BoardingModel(
        image: 'assets/images/onBoarding4.png',
        title: LocaleKeys.on_boarding_title_4.tr(),
        body:  LocaleKeys.on_boarding_4.tr(),
    ),
  ];


  var boardController = PageController();

  var _isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          MainPage(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        actions: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              onPressed: ()async{

                isEnglish? await context.setLocale(Locale('en')): await context.setLocale(Locale('ar'));
                setState(() {
                  isEnglish = !isEnglish;
                });
              },
              child: Text(isEnglish?'AR':'EN'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset('assets/images/logo1.png'),
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: boardController,
              itemBuilder: (BuildContext context, int index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              onPageChanged: (index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    _isLast = true;
                  });
                } else {
                  setState(() {
                    _isLast = false;
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      boardController.previousPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn
                      );
                    },
                  child: Text(LocaleKeys.back_button.tr(),
                    style: TextStyle(
                      color: gold,
                      fontSize: 16,
                    ),
                  )
                ),
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: gold,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 2,
                      spacing: 5
                  ),
                ),
                TextButton(
                    onPressed: () {
                      if (_isLast) {
                        submit();
                      }
                      else
                      {
                        boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                    },
                  child: Text(LocaleKeys.next_button.tr(),
                    style: TextStyle(
                      color: gold,
                      fontSize: 16,
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(child: Image.asset(model.image)),
      const SizedBox(
        height: 30,
      ),
      Text(
        model.title,
        style: const TextStyle(fontSize: 24,color: gold,fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        textAlign: TextAlign.center,
        model.body,
        style: const TextStyle(fontSize: 20,color: gold,fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}


