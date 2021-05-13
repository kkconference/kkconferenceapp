


import 'package:flutter/material.dart';
import 'package:kk_conferences/widgets/drawer.dart';

class CancelBookingScreen extends StatefulWidget {
  static const classname="/CancelBookingScreen";
  const CancelBookingScreen({Key key}) : super(key: key);
  @override
  _CancelBookingScreenState createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(child: CommonDrawer(),),
      body: ListView(children: [



      ],),
    );
  }
}
