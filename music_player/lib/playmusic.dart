import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player/music.dart';
import 'package:audioplayers/audioplayers.dart';

class Play_Music extends StatefulWidget {
  const Play_Music({super.key});

  @override
  State<Play_Music> createState() => _Play_MusicState();
}

class _Play_MusicState extends State<Play_Music> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/music.jpg",
            ),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.5),
                  const Color(0xff31314f).withOpacity(1),
                  const Color(0xff31314f).withOpacity(1),
                ]),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "All-Sura",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Yousuf Bin Al Azhiri",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: (() {
                                Navigator.pop(context, "Home_Page");
                              }),
                              child: const Icon(
                                Icons.list,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Slider(
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            value: position.inSeconds.toDouble(),
                            onChanged: (value) async {
                              final position = Duration(seconds: value.toInt());
                              await audioPlayer.seek(position);
                              await audioPlayer.resume();
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatTime(position),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Text(
                                  formatTime(duration - position),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.repeat,
                            color: Colors.white,
                            size: 31,
                          ),
                          const Icon(
                            CupertinoIcons.backward_end_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                          CircleAvatar(
                            radius: 35,
                            child: IconButton(
                              onPressed: () async {
                                if (isPlaying) {
                                  await audioPlayer.pause();
                                } else {
                                  await audioPlayer
                                      .play(AssetSource("Sura.m4a"));
                                }
                              },
                              icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow),
                              iconSize: 50,
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.forward_end_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                          const Icon(
                            CupertinoIcons.shuffle,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  final hours = twoDigits(duration.inHours);
  final minute = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [
    if (duration.inHours > 0) hours,
    minute,
    seconds,
  ].join(":");
}
