
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:islam/components/colors.dart';
import 'package:just_audio/just_audio.dart';
class RadioDetails extends StatefulWidget {
  final String name;
  final String url;
  const RadioDetails({super.key, required this.name, required this.url,});

  @override
  State<RadioDetails> createState() => _RadioDetailsState();
}

class _RadioDetailsState extends State<RadioDetails> {

  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playPauseAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await audioPlayer.setUrl(widget.url);
      await audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    }
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
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Iconsax.arrow_right,color: white,),
          ),
          title: Text('الراديو',
            style: TextStyle(
              fontFamily: 'Janna',
              fontSize: 20,
              color: white
            ),
          ),
        ),
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset('assets/images/logo1.png'),
                  Text(widget.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 24,
                      fontFamily: 'Janna'
                    ),
                  ),
                  SizedBox(height: 20,),
                  Image.asset('assets/images/onBoarding4.png'),
                  SizedBox(height: 20,),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: gold,
                    child: IconButton(
                      onPressed: (){playPauseAudio();},
                      icon: Icon(isPlaying?Iconsax.pause:Iconsax.play,color: black,size: 50,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
