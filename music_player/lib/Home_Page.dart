import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player/favourite.dart';
import 'package:music_player/music.dart';
import 'package:music_player/playlist.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              const Color(0xff303151).withOpacity(0.9),
              const Color(0xff303151).withOpacity(0.2),
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.sort_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  //Appbar
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Hellow Sir \n Do You want hear sir?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Search",
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),
                  ),
                  const TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.orange,
                      labelStyle: TextStyle(fontSize: 23),
                      indicator: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 3, color: Colors.white))),
                      tabs: [
                        Text("Music"),
                        Text("Playlist"),
                        Text("Favourite"),
                      ]),
                  const Flexible(
                    flex: 1,
                    child: TabBarView(children: [
                      Music(),
                      Playlist(),
                      Favourite(),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
