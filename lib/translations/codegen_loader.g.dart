// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "welcome_to_islami": "مرحبا بكم في اسلامي",
  "on_boarding_1": "نحن متحمسون جدًا لوجودك في مجتمعنا.",
  "on_boarding_2": "قراءة القرآن وربك الأكرم.",
  "on_boarding_3": "سبح اسم ربك الأعلى .",
  "on_boarding_4": "يمكنك الاستماع إلى إذاعة القرآن الكريم من خلال التطبيق مجانا وبسهولة",
  "on_boarding_title_2": "قرءاة القرءان",
  "on_boarding_title_3": "سبحة",
  "on_boarding_title_4": "إذاعة القرءان الكريم",
  "back_button": "الخلف",
  "next_button": "التالي"
};
static const Map<String,dynamic> en = {
  "welcome_to_islami": "Welcome to Islami",
  "on_boarding_1": "We are very excited to have you in\n our community.",
  "on_boarding_2": "Reading, and your Lord is the \nmost generous.",
  "on_boarding_3": "Praise the name of your Lord, the\n most high.",
  "on_boarding_4": "You can listen to the Holy Quran\n Radio through the Application for\n free and easily",
  "on_boarding_title_2": "Reading The Quran",
  "on_boarding_title_3": "Bearish",
  "on_boarding_title_4": "Holy Quran Radio",
  "back_button": "Back\n",
  "next_button": "Next"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
