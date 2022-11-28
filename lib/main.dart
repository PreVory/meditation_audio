import 'package:flutter/material.dart';
import 'models/models.dart';
import 'constants/consts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const OneHundredDaysApp());
}

class OneHundredDaysApp extends StatelessWidget {
  const OneHundredDaysApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Item> items = [
    Item(
        name: "forest",
        imagePath: "assets/images/forest.jpeg",
        audiPath: "assets/audio/forest.mp3"),
    Item(
        name: "night",
        imagePath: "assets/images/night.jpeg",
        audiPath: "assets/audio/night.mp3"),
    Item(
        name: "ocean",
        imagePath: "assets/images/ocean.jpeg",
        audiPath: "assets/audio/ocean.mp3"),
    Item(
        name: "waterfall",
        imagePath: "assets/images/waterfall.jpeg",
        audiPath: "assets/audio/waterfall.mp3"),
    Item(
        name: "wind",
        imagePath: "assets/images/wind.jpeg",
        audiPath: "assets/audio/wind.mp3"),
  ];

  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;

  int? playingIndex;


  void processedAudioState (int index, Item item) async {
    if (playingIndex == index && isPlaying) {
      audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    }
    else {
      playingIndex = index;
      await audioPlayer.setAsset(item.audiPath);
      await audioPlayer.setLoopMode(LoopMode.one);
      audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  String getAudioPosition(){
    return audioPlayer.position.inSeconds.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Item item = items.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () async {
                      processedAudioState(index, item);
                    },
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(item.imagePath),
                          )),
                      child: ListTile(
                          title: Text(item.name, style: kMainTextStyle,),
                          leading: IconButton(
                            icon: playingIndex == index && isPlaying ? FaIcon(FontAwesomeIcons.pause) : FaIcon(FontAwesomeIcons.play),
                            onPressed: () => processedAudioState(index, item),
                          )),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(onPressed: () {
                setState(() {

                });

                
              }, child: Text(getAudioPosition())),
            )],
          ),
        )),
      ),
    );
  }

}
