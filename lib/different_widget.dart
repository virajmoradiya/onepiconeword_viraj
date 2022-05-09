import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';

class widgets extends StatefulWidget {
  @override
  State<widgets> createState() => _widgetsState();
}

class _widgetsState extends State<widgets> {
  int count = 0;
  CroppedFile? croppedFile;
  String crop = "";
  StreamController<String> controll = StreamController<String>();
  AudioPlayer audioPlayer = AudioPlayer();
  Uint8List? byteData;
  int? result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // audioplayerr();
  }

  // audioplayerr(){
  //   playLocal() async {
  //     byteData = "audio/popup.wav" as Uint8List?;
  //     result = await audioPlayer.playBytes(byteData!);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          color: Colors.white,
          child: Column(
            children: [
              CheckboxListTile(
                  value: status,
                  onChanged: (value) {
                    setState(() {
                      if (status == true) {
                        status = false;
                      } else {
                        status = true;
                      }
                    });
                  },
                  title: Text("Wow"),
                  activeColor: Colors.blueAccent,
                  checkColor: Colors.white),
              Container(
                height: 300,
                width: 100,
                child: ListWheelScrollView(itemExtent: 100, children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    color: Colors.black,
                  ),
                ]),
              ),
              InkWell(
                onTap: () {
                  count++;
                  controll.sink.add(list[count]);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: StreamBuilder(
                      stream: controll.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "${snapshot.data.toString()}",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          );
                        } else {
                          return Text(
                            "0",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          );
                        }
                      }),
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
                  )),
              InkWell(
                onTap: () async {
                  setState(() async {
                    final ImagePicker picker = ImagePicker();

                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    // final crop = cropKey.currentState;
                    // final crop = Crop.of(context);
                    // final scale = crop!.scale;
                    // final area = crop.area;


                      croppedFile = await ImageCropper().cropImage(
                        sourcePath: image!.path,
                        uiSettings: [
                          AndroidUiSettings(
                              toolbarTitle: 'Cropper',
                              toolbarColor: Colors.deepOrange,
                              toolbarWidgetColor: Colors.white,
                              initAspectRatio: CropAspectRatioPreset.original,
                              lockAspectRatio: false),
                        ],
                      );
                    crop = croppedFile!.path;
                      print(croppedFile.runtimeType);
                  });
                },
                child: Container(
                  child: Text(
                    "Pic Image",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.black),
                ),
              ),
              Container(height: 100,width: 100,child: CircleAvatar(minRadius: 30,backgroundImage: FileImage(File(crop)),),)
            ],
          ),// cro

              // srt = cro.path
        )),
      ),
    );
  }

  bool status = false;
  List<String> list = ["1", "2", "3", "4", "5", "6"];
  final cropKey = GlobalKey<CropState>();
}
