import 'package:flutter/material.dart';
import 'package:kk_conferences/Screens/HomeDetail/room/room_item.dart';
import 'package:kk_conferences/model/confress_model.dart';
import 'package:kk_conferences/model/room_images.dart';


class HotelRoomTab extends StatelessWidget {
  final List<RoomImages> rooms;

  const HotelRoomTab({
    Key key,
    this.rooms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) => RoomItem(room: rooms[index]),
    );
  }
}
