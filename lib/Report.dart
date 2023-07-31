import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chpr6/Home.dart';

import 'func.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Report extends StatefulWidget {
  const Report();

  @override
  _ReportState createState() => _ReportState();
}

TextEditingController textController = TextEditingController();
TextEditingController textController1 = TextEditingController();

class _ReportState extends State<Report> {
  bool vis = false;
  @override
  Widget build(BuildContext context) {
    var g = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
        backgroundColor: const Color.fromARGB(235, 146, 255, 127),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'CHPR6',
            style: TextStyle(
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 3.0),
                  blurRadius: 3,
                  color: Color.fromARGB(104, 0, 0, 0),
                ),
              ],
              fontSize: 25,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  var uri =
                      await Uri.parse('https://github.com/Ar998-max/CHPR');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(Uri.parse(uri.toString()),
                        mode: LaunchMode.externalApplication);
                  } else {
                    print('no');
                    // can't launch url
                  }
                },
                child: const Text(
                  'Github',
                  style: TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 255, 255, 255)),
                )),
            const SizedBox(
              width: 4,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
                child: const Text(
                  'X',
                  style: TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 255, 255, 255)),
                ))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
            child: Column(
          children: [
            Text(
              'REPORT BUG',
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 1100,
              child: TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(235, 28, 58, 26),
                      width: 1.5,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(235, 28, 58, 26),
                      width: 1.5,
                    )),
                    hintText: 'What product did you search for?(If any)',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20)),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
                controller: textController,
                maxLines: 1,
              ),
            ),
            SizedBox(height: 100),
            SizedBox(
              width: 1100,
              child: TextField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(235, 28, 58, 26),
                      width: 1.5,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(235, 28, 58, 26),
                      width: 1.5,
                    )),
                    hintText: 'What problem did you face?',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20)),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
                controller: textController1,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 60),
            Container(
              height: 55,
              width: 220,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(235, 28, 58, 26),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: TextButton(
                  // sets the output variable
                  onPressed: () async {
                    var ur = 'http://192.168.0.105:10000/api?query=' +
                        textController.text.toString() +
                        '&pro=' +
                        textController1.text.toString();
                    var sen = await get_data(ur);
                    print(jsonDecode(sen));
                    setState(() {
                      vis = true;
                      Timer(Duration(seconds: 5), () {
                        textController.clear();
                        textController1.clear();
                        setState(() {
                          vis = false;
                        });
                      });
                    });
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
            Visibility(
              visible: vis,
              child: Text(
                'Thanks for reporting, we will do our best to fix it.',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            )
          ],
        )));
  }
}
