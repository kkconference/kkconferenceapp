

import 'package:kk_conferences/model/confress_model.dart';

import 'booking_model.dart';

class Carrage{

  RoomInfo confressModel;
  BookingModel bookingModel;
  bool cancellation_read_only=false;


  Carrage({this.confressModel, this.bookingModel,this.cancellation_read_only=false});
}