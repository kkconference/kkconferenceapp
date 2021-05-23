import 'package:flutter/material.dart';
import 'package:kk_conferences/model/confress_model.dart';
import 'package:kk_conferences/providers/staff/room_price_provider.dart';
import 'package:kk_conferences/widgets/drawer.dart';
import 'package:kk_conferences/widgets/gradient_button.dart';
import 'package:kk_conferences/widgets/multiTextInput.dart';
import 'package:provider/provider.dart';

class RoomPrice extends StatefulWidget {
  static const classname = "/RoomPrice";

  const RoomPrice({Key key}) : super(key: key);

  @override
  _RoomPriceState createState() => _RoomPriceState();
}

class _RoomPriceState extends State<RoomPrice> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoomPriceProvider>(context);
    provider.context=context;
    return Scaffold(
      appBar: AppBar(title: Text("Room Prices"),),
      drawer: Drawer(
        child: CommonDrawer(),
      ),
      body: Consumer<RoomPriceProvider>(builder: (context, value, child) {
        return ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MultiLineTextInput(
                controller: value.room1controller,
                m_labelText: "Conference Room 1",
                m_helperText: "Conference room 1 price display and update here",
                type: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MultiLineTextInput(
                controller: value.room2controller,
                m_labelText: "Conference Room 2",
                m_helperText: "Conference room 2 price display and update here",
                type: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: GradientButton(
                  onpress: () {
                    provider.updateRoomPrice();
                  },
                  text: "Press to update",
                ))
          ],
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RoomPriceProvider>(context, listen: false);
    provider.getFirstRoomPrice();
    provider.getSecondRoomPrice();
  }
}
