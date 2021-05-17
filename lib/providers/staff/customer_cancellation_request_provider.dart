import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kk_conferences/api/FirbaseApi.dart';
import 'package:kk_conferences/api/firebase_clerk_api.dart';
import 'package:kk_conferences/api/web_api/razorpay_payment.dart';
import 'package:kk_conferences/api/web_api/razorpay_refund.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/model/razorpay/razorpay_payment.dart';
import 'package:kk_conferences/utils/dialog.dart';

class CustomerCancellationRequestProvider extends ChangeNotifier {
  static CustomerCancellationRequestProvider _instance;

  List<BookingModel> list_of_bookings = [];

  BuildContext context;

  CustomerCancellationRequestProvider._private();

  factory CustomerCancellationRequestProvider.instance() {
    _instance ??= CustomerCancellationRequestProvider._private();
    return _instance;
  }

  loadCancellationRequestions() async {
    list_of_bookings = [];
    QuerySnapshot snapshot =
        await FirebaseMemberApi().getCancellationRequests();
    for (DocumentSnapshot dsnap in snapshot.docs) {
      list_of_bookings.add(BookingModel.fromJson(dsnap.data()));
      print(BookingModel.fromJson(dsnap.data()).roomname);
    }
    notifyListeners();
  }

  Future<void> denybooking(BookingModel e) async {
   QuerySnapshot snapshot=await FirebaseMemberApi().getCancellationBookingid(e);
    snapshot.docs.first.reference.delete();
    FireBaseCustomersApi().addBookingEntery(model: e);
  await DialogUtil(
       context: context, title: "Booking Denied Successful", buttonOktext: "Ok")
       .showSuccessDialog();
   loadCancellationRequestions();
  }

  void onapprovecancellation(BookingModel e) async {
    RazorPayPaymentModel model;
    try {
      model = await RazorPayPaymentApi().capturePayment(e);
    } catch (e) {}

    Response response = await RazorPayRefundApi().performRefund(model);
    if (response.statusCode == 200) {
    QuerySnapshot snapshot=  await FirebaseMemberApi().getBookingEntry(e);
    snapshot.docs[0].reference.delete();
    await FirebaseMemberApi().addRefundEntry(e);
    
      DialogUtil(
          context: context, title: "Refund Successful", buttonOktext: "Ok")
          .showSuccessDialog();


    }
    loadCancellationRequestions();

  }
}
