import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  String? qr;
  bool cameraState = false;
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cameraState
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: QrCamera(
                onError: (context, error) {
                  return Text(
                    error.toString(),
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  );
                },
                qrCodeCallback: (code) {
                  setState(() {
                    qr = code;
                    sendMessage();
                  });
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 10.0, right: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                iconSize: 35.0,
                                color: Colors.white,
                                tooltip: "Cancel",
                                onPressed: () {},
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                iconSize: 35.0,
                                onPressed: () {
                                  setState(() {
                                    cameraState = !cameraState;
                                  });
                                },
                                icon: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              "You have to CLICK to camera button to SCAN QR CODE",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 130.0),
                      child: Column(
                        children: [
                          Text(
                            "Scan Qr Code",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            "Scan the booking QR code from",
                            style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "your confirmation email",
                            style: TextStyle(
                              fontSize: 23.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.crop_free,
                              size: 300.0,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 250.0),
                      height: MediaQuery.of(context).size.height / 14,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TabBar(
                        indicatorPadding: EdgeInsets.all(8.0),
                        indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0)),
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                        labelStyle: TextStyle(fontSize: 22.0),
                        controller: tabController,
                        tabs: [
                          Tab(text: "Scan code"),
                          Tab(text: "Enter code"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              cameraState = !cameraState;
                            });
                          },
                          icon: Icon(
                            Icons.camera,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  sendMessage() async {
    if (Platform.isAndroid) {
      var url = "http://google.com";
      await launch(url);
    }
  }
}
