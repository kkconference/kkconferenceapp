

import 'package:flutter/material.dart';
import 'package:kk_conferences/widgets/drawer.dart';
import 'package:kk_conferences/widgets/gradient_button.dart';
import 'package:kk_conferences/widgets/multiTextInput.dart';

class RoomPrice extends StatefulWidget {
  static const classname="/RoomPrice";
  const RoomPrice({Key key}) : super(key: key);

  @override
  _RoomPriceState createState() => _RoomPriceState();
}

class _RoomPriceState extends State<RoomPrice> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(child: CommonDrawer(),),
      body: ListView(children: [

        SizedBox(height: 50,),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: MultiLineTextInput(m_labelText: "Conference Room 1",m_helperText: "Conference room 1 price display and update here",type: TextInputType.number,),
        ),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: MultiLineTextInput(m_labelText: "Conference Room 2",m_helperText: "Conference room 2 price display and update here",type: TextInputType.number,),
        ),

        GradientButton(onpress: (){},text: "Press to update",)


      ],),

    );
  }
}
