import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:islam/components/colors.dart';
import 'package:video_player/video_player.dart';

class SunnahLive extends StatefulWidget {
  const SunnahLive({super.key});

  @override
  State<SunnahLive> createState() => _SunnahLiveState();
}

class _SunnahLiveState extends State<SunnahLive> {

  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse('https://win.holol.com/live/sunnah/playlist.m3u8'));
    initializeVideoPlayerFuture = controller.initialize();
    controller.setLooping(true);  // Set looping if needed
    controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: gold,
        onPressed: (){
          setState(() {
            if(controller.value.isPlaying)
            {
              controller.pause();
            }
            else{
              controller.play();
            }
          });
        },
        child: Icon(controller.value.isPlaying?Iconsax.pause:Iconsax.play),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('بث مباشر السنة النبوية',
              style: TextStyle(
                  fontFamily: 'Janna',
                  fontSize: 28,
                  color: white
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: FutureBuilder<void>(
                future: initializeVideoPlayerFuture,
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done)
                  {
                    return AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
