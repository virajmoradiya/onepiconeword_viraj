import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class playpage extends StatefulWidget {
  @override
  State<playpage> createState() => _playpageState();
}

class _playpageState extends State<playpage> {
  List someImages = [];
  List bottomlist = [];
  List bottomlistgetrange = [];
  List checkbottomlist = [];
  List abcdlist = [];
  String abcd = "";
  List levellistname = [];
  String levelname = "";
  String levelpic = "";
  int a = 0;
  List toplist = [];
  List levelblanklist = [];
  int cnt = 0;
  int pos = 0;
  bool winn = false;
  String winmsg = "";
  bool color = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initImages();
  }

  Future initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.webp'))
        .toList();

    setState(() {
      someImages = imagePaths;
    });

    someImages.shuffle();
    print(someImages);

    levelpic = someImages[1];

    levelname = levelpic.split("/")[1].split("\.")[0]; //antenna

    levellistname = levelname.split(""); //[a, n, t, e, n, n, a]
    setState(() {
      levelblanklist = List.filled(levellistname.length, "");
    });
    print("==level list====$levellistname");

    toplist = List.filled(levellistname.length, "");

    abcd = "qwertyuiopasdfghjklzxcvbnm";
    abcdlist = abcd.split("");
    abcdlist.shuffle();

    setState(() {
      bottomlist = abcdlist.getRange(0, 10 - levellistname.length).toList();
    });

    print("==bbb=====$bottomlist");

    bottomlist.addAll(levellistname);
    bottomlist.shuffle();
    checkbottomlist = List.filled(bottomlist.length, "");
    print("=======$bottomlist");
    print("b====${bottomlistgetrange}");
    print(bottomlist[1]);
  }

  @override
  Widget build(BuildContext context) {
    double twidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: twidth,
            height: 50,
            decoration: BoxDecoration(color: Colors.amber),
          ),
          Container(
            height: 300,
            width: twidth,
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Column(children: [
              Container(
                child: Image(image: AssetImage("design/game_top.png")),
              ),
              SizedBox(
                height: 20,
              ),
              InteractiveViewer(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("$levelpic"), fit: BoxFit.fill),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: levelblanklist.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (levelblanklist[index].toString().isNotEmpty) {
                            pos = checkbottomlist
                                .indexOf("${levelblanklist[index]}");
                            bottomlist[pos] = levelblanklist[index];
                            levelblanklist[index] = "";
                            checkbottomlist[pos] = "";
                            cnt--;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(color ? 0xFFFA0000 : 0xFFFFFFFF)),
                        child: Center(
                            child: Text(
                                "${levelblanklist[index].toString().toUpperCase()}",
                                style: TextStyle(fontSize: 30))),
                        margin: EdgeInsets.only(
                            left: 3, right: 3, top: 18, bottom: 18),
                        height: 20,
                        width: 50,
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
          Container(
            color: Colors.black,
            child: Row(
              children: [
                Container(
                  child: GridView.builder(
                    // shrinkWrap: true,
                    itemCount: bottomlist.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (bottomlist[index].toString().isNotEmpty) {
                              speak(bottomlist[index].toString());
                              checkbottomlist[index] = bottomlist[index];
                              for (int i = 0; i < levelblanklist.length; i++) {
                                if (levelblanklist[i] == "") {
                                  levelblanklist[i] = bottomlist[index];
                                  bottomlist[index] = "";
                                  cnt++;
                                  win();
                                  break;
                                }
                              }
                              // levelblanklist[cnt] = bottomlist[index];
                              // checkbottomlist[index] = bottomlist[index];
                              // bottomlist[index] = "";
                              // cnt++;
                              // win();
                              print("level blank list $levelblanklist");
                              print("levellistname $levellistname");
                              print("win msg = $winmsg");
                            }
                          });
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                                "${bottomlist[index].toString().toUpperCase()}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30)),
                          ),
                          margin: EdgeInsets.all(10),
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      );
                    },
                  ),
                  height: 140,
                  width: twidth * 0.84,
                  decoration: BoxDecoration(color: Colors.black),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        flutterTts0.speak("$levelname");
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 5, right: 3, top: 12, bottom: 18),
                        height: twidth * 0.12,
                        width: twidth * 0.12,
                        color: Colors.white,
                        child: Icon(Icons.lightbulb, size: 30),
                      ),
                    ),
                    Tooltip(message: "To Remove Extra Word",
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            bottomlistgetrange = abcdlist
                                .getRange(0, 10 - levellistname.length)
                                .toList();
                            for (int i = 0; i < bottomlistgetrange.length; i++) {
                              int place =
                                  bottomlist.indexOf(bottomlistgetrange[i]);
                              bottomlist[place] = "";
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 5, right: 3, top: 0, bottom: 18),
                          height: twidth * 0.12,
                          width: twidth * 0.12,
                          color: Colors.white,
                          child: Icon(Icons.close, size: 30),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          // Container(child: Row()),
          Container(
            height: 50,
            width: twidth,
            child:
                Center(child: Text("$winmsg", style: TextStyle(fontSize: 50))),
            margin: EdgeInsets.all(10),
          ),
          // InkWell(
          //   onTap: () {
          //     Navigator.pushReplacement(context, MaterialPageRoute(
          //       builder: (context) {
          //         return playpage();
          //       },
          //     ));
          //   },
          //   child: Container(
          //     height: 80,
          //     width: twidth * 0.6,
          //     child: color
          //         ? Container(
          //             decoration: BoxDecoration(
          //                 color: Colors.blue,
          //                 borderRadius: BorderRadius.circular(10)),
          //             child: Center(
          //                 child: Text("Restart",
          //                     style: TextStyle(
          //                         fontSize: 50, color: Colors.white))),
          //             height: 80,
          //             width: twidth * 0.6,
          //             margin: EdgeInsets.all(10),
          //           )
          //         : null,
          //   ),
          // ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return playpage();
                },
              ));
            },
            child: Chip(
              label: Text("Restart",
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              backgroundColor: Colors.blueAccent,
              avatar: Icon(Icons.restart_alt, color: Colors.white, size: 30),
            ),
          )
        ],
      )),
    );
  }

  void win() {
    if (listEquals(levelblanklist, levellistname)) {
      setState(() {
        winn = true;
        winmsg = "win";
        color = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Congratulations..You Win")));
        // Future.delayed(
        //   Duration(seconds: 2),
        //   () {
        //     Navigator.pushReplacement(context, MaterialPageRoute(
        //       builder: (context) {
        //         return playpage();
        //       },
        //     ));
        //   },
        // );
        String winspeak = "${levelname}";
        flutterTts0.speak("${winspeak}");
      });
    }
  }

  // FlutterTts flutterTts = FlutterTts();
  FlutterTts flutterTts0 = FlutterTts();

  void speak(String string) {
    flutterTts0.speak("${string}");
  }
// play() async {
//   var result = await flutterTts0.speak("I am a flutter developer");
//   if (result == 1) setState(() => ttsState = TtsState.playing);
// }
}
