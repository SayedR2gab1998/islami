import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:islam/components/colors.dart';
import 'package:islam/screens/tab_bar_screens/quran_live.dart';
import 'package:islam/screens/tab_bar_screens/sunnah_live.dart';

class LiveTv extends StatefulWidget {
  const LiveTv({super.key});

  @override
  State<LiveTv> createState() => _LiveTvState();
}

class _LiveTvState extends State<LiveTv> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController
    _tabController = TabController(length: 2, vsync: this);

    // Optionally listen to tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        print("Tab is changing to ${_tabController.index}");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: Text('بث مباشر',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Janna',
            color: white,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: gold,
          indicatorWeight: 5,
          tabs: [
            Tab(icon: Icon(Iconsax.video_octagon,), text: 'القرءان',),
            Tab(icon: Icon(Iconsax.video_octagon), text: 'السنة'),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          QuranLive(),
          SunnahLive(),
        ],
      )
    );
  }
}
