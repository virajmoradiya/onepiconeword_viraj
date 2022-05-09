import 'package:flutter/material.dart';
import 'package:onepiconeword_viraj/playpage.dart';

import 'different_widget.dart';

void main() {
  runApp(MaterialApp(
    home: homepage(),
  ));
}

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    double twidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            child: Center(
                child: Text(
              "One Pic One Word",
              style: TextStyle(color: Colors.white, fontSize: 40),
            )),
            width: twidth,
            height: 100,
            decoration: BoxDecoration(color: Colors.black),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return playpage();
                },
              ));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              child: Center(
                  child: Text(
                "Start",
                style: TextStyle(color: Colors.white, fontSize: 35),
              )),
              width: twidth * 0.7,
              height: 80,
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return widgets();
                },
              ));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              child: Center(
                  child: Text(
                "Widgets",
                style: TextStyle(color: Colors.white, fontSize: 35),
              )),
              width: twidth * 0.7,
              height: 80,
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
          Hero(
              tag: "hero",
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: AssetImage("images/almond.webp"))),
              ))
        ]),
      ),
    );
  }
}
