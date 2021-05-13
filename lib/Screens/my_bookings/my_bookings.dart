import 'package:flutter/material.dart';
import 'package:kk_conferences/global/const_funcitons.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/providers/my_booking_provider.dart';
import 'package:kk_conferences/widgets/active_booking_items.dart';
import 'package:kk_conferences/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

class MyBookings extends StatefulWidget {
  static const classname = "/ActiveBookingItems";

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<MyBookingProvider>(context);
    provider.context=context;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings")
      ),
      body: Consumer<MyBookingProvider>(builder: (context, value, child) {
        if (value.currunt_state != appstate.loading_complete)
          return StateScreen(state:value.currunt_state);
        else if (value.currunt_state == appstate.loading_complete)
        return ListView.builder(
            itemBuilder: (context, index) {
              return getBookingWidget(value.mybookings[index],index);
            },
            itemCount: value.mybookings.length);
      }),
    );
  }

  @override
  void initState() {
    final provider = Provider.of<MyBookingProvider>(context, listen: false);
    provider.loadMyBookings();
  }

  Widget getBookingWidget(BookingModel mybooking,int index) {
    final provider = Provider.of<MyBookingProvider>(context, listen: false);

    return ActiveBookingItem(
      title: " ${mybooking.roomname}",
      amount: mybooking.amount,
      start_duration: getDateWith12HrsFormat(mybooking.bookingStartTime),
      end_duration: getDateWith12HrsFormat(mybooking.bookingEndTime),
      date_of_booking: mybooking.bookingDate,
      oncancel: () {
        provider.showDialogCancelBooking(index);// trigger to cancel
      },
      disablecancel: !(DateTime.now().difference(mybooking.bookingEndTime).inSeconds.isNegative),
    );
  }
}
