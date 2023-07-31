import 'dart:collection';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chpr6/Report.dart';

import 'func.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dart_ipify/dart_ipify.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

TextEditingController textController = TextEditingController();
final CarouselController _controller = CarouselController();
var output2 = {};
var output3 = {};

class _HomeState extends State<Home> {
  bool loading = false;
  String url = '';
  String url2 = '';
  var data;
  var data2;
  var name = '';
  var id = '';

  bool isLoading = false;

  Future<void> loadDataAndNavigate() async {
    setState(() => isLoading = true);

    set_data() async {
      final ipv4 = await Ipify.ipv4();
      url = 'https://433a-45-127-138-70.ngrok.io/api?query=' +
          textController.text.toString() +
          '&ip=' +
          ipv4.toString();

      data = await get_data(url);

      var decoded = jsonDecode(data);
      if (name == '') {
        name = decoded['name'];
      } else {
        print('all ok');
      }

      if (name == 'United States') {
        output2 = {
          'amazon': {
            'price': decoded['output']['amazon']['price'].toString(),
            'title': decoded['output']['amazon']['title'],
            'image_url': decoded['output']['amazon']['thumbnail_url'],
          }
        };
      } else {
        output2 = {
          'amazon': {
            'title': decoded['output']['amazon']['title'],
            'image_url': decoded['output']['amazon']['thumbnail_url'],
            'price': decoded['output']['amazon']['price'].toString(),
            'url': decoded['output']['amazon']['url'],
            'ratings': decoded['output']['amazon']['rating'],
          },
          'flipkart': {
            'title': decoded['output']['flipkart']['product'],
            'url': decoded['output']['flipkart']['link'],
            'ratings': decoded['output']['flipkart']['ratings'],
            'price': decoded['output']['flipkart']['price'],
            'image': decoded['output']['flipkart']['image'],
          },
          'JioMart': {
            'title': decoded['output']['JioMart']['Title'],
            'url': decoded['output']['JioMart']['Url'],
            //'ratings': decoded['output']['flipkart']['ratings'],
            'price': decoded['output']['JioMart']['Price'],
            'image': decoded['output']['JioMart']['Image'],
          },
        };
      }
      String output3 = '';
      print('XXXXXXXX');
      print(decoded['output']['amazon']['thumbnail_url']);
      print('XXXXXXXXX');
      print(output2);
      print(' ');
      print(decoded);
      return output2;
    }

    output2 = await set_data();
    //output3 = jsonDecode(output2);
    isLoading = false;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Item(output: output2),
      ),
    );
  }

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
                var uri = await Uri.parse('https://github.com/Ar998-max/CHPR');
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
            width: 8,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Report(),
                  ),
                );
              },
              child: const Text(
                'Found A Bug?',
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 255, 255, 255)),
              )),
          const SizedBox(
            width: 4,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: isLoading
            ? LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white, size: 65)
            : Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'FIND THE CHEAPEST PRODUCT AVAILABLE',
                            textStyle: TextStyle(
                              fontSize: g * 0.03,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Horizon',
                              color: Color.fromARGB(255, 255, 255, 255),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.0, 3.0),
                                  blurRadius: 3,
                                  color: Color.fromARGB(104, 0, 0, 0),
                                ),
                              ],
                            ),
                            speed: const Duration(milliseconds: 120),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
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
                              hintText: 'Search Now',
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
                      const SizedBox(height: 60),
                      Container(
                        height: 55,
                        width: 220,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(235, 28, 58, 26),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: TextButton(
                            // sets the output variable
                            onPressed: () async => loadDataAndNavigate(),
                            child: const Text(
                              'Search Now',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ]),
              ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({required var output});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromARGB(235, 146, 255, 127),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
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
                var uri = await Uri.parse('https://github.com/Ar998-max/CHPR');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(Uri.parse(uri.toString()),
                      mode: LaunchMode.externalApplication);
                } else {
                  print('no');
                  // can't launch url
                }
              },
              child: Text(
                'Github',
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 255, 255, 255)),
              )),
          SizedBox(
            width: 8,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Report(),
                  ),
                );
              },
              child: Text(
                'Found A Bug?',
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 255, 255, 255)),
              )),
          SizedBox(
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
              child: Text(
                'X',
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 255, 255, 255)),
              ))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 50),
              Text(
                "HERE'S WHAT WE GOT",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 255, 255, 255),
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 3.0),
                      blurRadius: 3,
                      color: Color.fromARGB(104, 0, 0, 0),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 30),
          CarouselSlider(
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.8,
                  height: MediaQuery.of(context).size.height / 1.4),
              items: [
                InkWell(
                  child: Container(
                    height: 410,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(235, 28, 58, 26),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Stack(children: [
                      Positioned(
                        bottom: 190.0,
                        right: 0.0,
                        left: 0.0,
                        child: Container(
                            height: 210,
                            width: 730,
                            child: Image.network(
                                output2['flipkart']['image'].toString())),
                      ),
                      Positioned(
                        bottom: 95.0,
                        right: 0.0,
                        left: 10.0,
                        child: Text(output2['flipkart']['title'].toString(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                      ),
                      Positioned(
                        bottom: 145.0,
                        right: 0.0,
                        left: 10.0,
                        child: Text(output2['flipkart']['price'].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                      ),
                      Positioned(
                        bottom: 60.0,
                        right: 0.0,
                        left: 10.0,
                        child: Row(
                          children: [
                            Text(output2['flipkart']['ratings'].toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                )),
                            Icon(Icons.star, color: Colors.white)
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 15.0,
                          right: 0.0,
                          left: 240.0,
                          child: Text('Flipkart',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )))
                    ]),
                  ),
                  onTap: () async {
                    print(output2['flipkart']['url']);
                    String ur = 'https://' + output2['flipkart']['url'];
                    var uri = await Uri.parse(ur);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(Uri.parse(uri.toString()),
                          mode: LaunchMode.externalApplication);
                    } else {
                      print('no');
                      // can't launch url
                    }
                  },
                ),
                InkWell(
                  child: Container(
                    height: 410,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(235, 28, 58, 26),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Stack(children: [
                      Positioned(
                        bottom: 180.0,
                        right: 0.0,
                        left: 0.0,
                        child: Container(
                            height: 210,
                            width: 730,
                            child: Image.network(
                                output2['amazon']['image_url'].toString())),
                      ),
                      Positioned(
                        bottom: 75.0,
                        right: 0.0,
                        left: 10.0,
                        child: Container(
                          child: Text(output2['amazon']['title'].toString(),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )),
                        ),
                      ),
                      Positioned(
                        bottom: 145.0,
                        right: 0.0,
                        left: 10.0,
                        child: Text(output2['amazon']['price'].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                      ),
                      Positioned(
                        bottom: 40.0,
                        right: 0.0,
                        left: 10.0,
                        child: Row(
                          children: [
                            Text(output2['amazon']['ratings'].toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                )),
                            Icon(Icons.star, color: Colors.white)
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 15.0,
                          right: 0.0,
                          left: 240.0,
                          child: Text('Amazon',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )))
                    ]),
                  ),
                  onTap: () async {
                    print(output2['flipkart']['url'].toString());
                    String ur = output2['amazon']['url'].toString();
                    var uri = await Uri.parse(ur);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(Uri.parse(uri.toString()),
                          mode: LaunchMode.externalApplication);
                    } else {
                      print('no');
                      // can't launch url
                    }
                  },
                ),
                InkWell(
                  child: Container(
                    height: 410,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(235, 28, 58, 26),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Stack(children: [
                      Positioned(
                        bottom: 180.0,
                        right: 0.0,
                        left: 0.0,
                        child: Container(
                            height: 210,
                            width: 730,
                            child: Image.network(
                                output2['JioMart']['image'].toString())),
                      ),
                      Positioned(
                        bottom: 75.0,
                        right: 0.0,
                        left: 10.0,
                        child: Container(
                          child: Text(output2['JioMart']['title'].toString(),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )),
                        ),
                      ),
                      Positioned(
                        bottom: 145.0,
                        right: 0.0,
                        left: 10.0,
                        child: Text(output2['JioMart']['price'].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                      ),
                      Positioned(
                          bottom: 15.0,
                          right: 0.0,
                          left: 240.0,
                          child: Text('JioMart',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )))
                    ]),
                  ),
                  onTap: () async {
                    String ur = output2['JioMart']['url'].toString();
                    var uri = await Uri.parse(ur);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(Uri.parse(uri.toString()),
                          mode: LaunchMode.externalApplication);
                    } else {
                      print('no');
                      // can't launch url
                    }
                  },
                ),
              ]),
        ]),
      ),
    );
    throw UnimplementedError();
  }
}
