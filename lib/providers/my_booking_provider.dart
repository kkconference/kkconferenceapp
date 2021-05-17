import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kk_conferences/Screens/customer_boooking_cancellation_screen/cancel_booking_reason_screen.dart';
import 'package:kk_conferences/api/FirbaseApi.dart';
import 'package:kk_conferences/api/firebase_clerk_api.dart';
import 'package:kk_conferences/global/Global.dart';
import 'package:kk_conferences/global/const_funcitons.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/model/carrage_model.dart';
import 'package:kk_conferences/utils/dialog.dart';
import 'package:kk_conferences/utils/m_progress_indicator.dart';

class MyBookingProvider extends ChangeNotifier {
  List<BookingModel> mybookings;
  dynamic currunt_state = appstate.default_state;
  BuildContext context;

  loadMyBookings() async {
    currunt_state = appstate.loading;
    QuerySnapshot snapshot;
    notifyListeners();
    mybookings = [];

    try {
      snapshot = await FireBaseCustomersApi().getMyBookings(Global.activeCustomer);
    } catch (e) {
      appstate.crash;
    }

    for (QueryDocumentSnapshot item in snapshot.docs) {
      BookingModel model = BookingModel.fromJson(item.data());
      mybookings.add(model);
      /*   item.data().forEach((key, value) {
        print(value);
      });*/
    }
    currunt_state = appstate.loading_complete;
    notifyListeners();
  }

  void showDialogCancelBooking(int index) {
    DialogUtil(
            context: context,
            title: "Confirmation Cancel",
            message: "Do you really like to cancel it take 7 days to refund",
            buttonOktext: "Yes do it",
            btnOkOnPress: () {
              Navigator.of(context).pushNamed(CancelBookingReason.classname,arguments: Carrage(bookingModel: mybookings[index]),);
              //performCancelBooking(mybookings[index]);
              
              
              
            },btnCancelOnPress: (){})
        .showWarningDialog();
  }

  performCancelBooking(BookingModel model) async {
    model.applyCancelDate=getFirebaseFormatDate(DateTime.now());
    model.iscancel=false;
    FirebaseMemberApi().addCancelBooking(model);
   QuerySnapshot snapshot=await FirebaseMemberApi().deleteCancelBookingEntry(model);
    snapshot.docs[0].reference.delete();

    MProgressIndicator.hide();
    loadMyBookings();
  }

}
