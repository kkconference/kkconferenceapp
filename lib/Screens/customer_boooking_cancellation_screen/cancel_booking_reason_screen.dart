import 'package:flutter/material.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/model/carrage_model.dart';
import 'package:kk_conferences/providers/my_booking_provider.dart';
import 'package:kk_conferences/utils/m_progress_indicator.dart';
import 'package:kk_conferences/widgets/drawer.dart';
import 'package:kk_conferences/widgets/gradient_button.dart';
import 'package:kk_conferences/widgets/multiTextInput.dart';
import 'package:provider/provider.dart';
import 'package:kk_conferences/utils.dart';

class CancelBookingReason extends StatefulWidget {
  static const classname = "/CancelBookingReason";

  const CancelBookingReason({Key key}) : super(key: key);

  @override
  _CancelBookingReasonState createState() => _CancelBookingReasonState();
}

class _CancelBookingReasonState extends State<CancelBookingReason> {
  TextEditingController cancel_reason = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyBookingProvider>(context);
    Carrage carrage = ModalRoute.of(context).settings.arguments;
    BookingModel model;
    if (carrage.cancellation_read_only == true) {
      cancel_reason.text = carrage.bookingModel.cancellationDescription;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cancellation Reason"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Please Write Reason below for cancellation.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(25.0),
              child: MultiLineTextInput(
                  m_hintText: "",
                  m_helperText: "",
                  m_labelText: "Write here",
                  controller: cancel_reason)),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.3),
              child: (() {
                print(carrage.cancellation_read_only);
                if (carrage.cancellation_read_only == false)
                  return GradientButton(
                    onpress: () {
                      if (cancel_reason.text.isEmpty) {
                        "Please give reason for cancellation."
                            .showSnackbar(context);
                      }
                      print(carrage.bookingModel.bookingId);
                      carrage.bookingModel.cancellationDescription =
                          cancel_reason.text;
                      provider.performCancelBooking(carrage.bookingModel);
                      "Cancellation request Submitted".showSnackbar(context);
                      Navigator.pop(context);
                    },
                    text: "Submit",
                  );
              }()))
        ],
      ),
    );
  }
}
