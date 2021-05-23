import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kk_conferences/api/firebase_clerk_api.dart';
import 'package:kk_conferences/model/confress_model.dart';
import 'package:kk_conferences/utils.dart';

class RoomPriceProvider extends ChangeNotifier {
  RoomInfo roomInfo1;
  RoomInfo roomInfo2;
  TextEditingController room1controller = new TextEditingController();
  TextEditingController room2controller = new TextEditingController();
  QuerySnapshot snapshot1;
  QuerySnapshot snapshot2;

  BuildContext context;

  getFirstRoomPrice() async {
    snapshot1 = await FirebaseMemberApi()
        .getRoomInfo("680380e8-c759-4b7a-9a20-a5bf4bb1079b");
    roomInfo1 = RoomInfo.fromJson(snapshot1.docs.first.data());
    room1controller.text = roomInfo1.price.toString();
    notifyListeners();
  }

  getSecondRoomPrice() async {
    snapshot2 = await FirebaseMemberApi()
        .getRoomInfo("1c12c8cb-ac0a-48c5-8991-c1ed87a71fbf");
    roomInfo2 = RoomInfo.fromJson(snapshot2.docs.first.data());
    room2controller.text = roomInfo2.price.toString();
    notifyListeners();
  }

  void updateRoomPrice() {
    try {
      roomInfo1.price = int.parse(room1controller.text);
      roomInfo2.price = int.parse(room2controller.text);
    } catch (e) {
      "Error price must be numerical".showSnackbar(context);
    }

    snapshot1.docs.first.reference.update(roomInfo1.toJson());
    snapshot2.docs.first.reference.update(roomInfo2.toJson());
    "Price Update Successful".showSnackbar(context);
  }
}
