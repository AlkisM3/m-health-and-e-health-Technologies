import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'package:skin_lab/globals.dart' as globals;
import 'package:skin_lab/leitourgies.dart';
import 'package:skin_lab/share.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:skin_lab/camera.dart' as camera;

// ignore: camel_case_types
class Home extends StatefulWidget {
  const Home({key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

// ignore: camel_case_types
class _Home extends State<Home> {
  bool _showPreview = false;
  // String _image = "assets/icons/1.jpg";
  List items = List.generate(1, (index) => "$index ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Image Uploaded to Server",
            style: Theme.of(context).textTheme.headline3),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
          child: Stack(children: [
        GridView.builder(
          itemCount: globals.imagearray.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onDoubleTap: () {
                globals.chooseimage = globals.imagearray[index];
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ShareData()));
              },
              onLongPress: () {
                setState(() {
                  _showPreview = true;
                  Image.file(File(globals.imagearray[index]));
                  globals.image = globals.imagearray[index];
                });
              },
              onLongPressEnd: (details) {
                setState(() {
                  _showPreview = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.file(File(globals.imagearray[index])),
                ),
              ),
            );
          },
        ),
        if (_showPreview) ...[
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Center(
                child: Column(children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 400,
                  maxWidth: 400,
                ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(File(globals.image)),
                ),
              ),
            ])),
          )
        ]
      ])),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Leitourgies()));
          },
          child: const Icon(
            Icons.navigate_before_outlined,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 0, 255, 0)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
