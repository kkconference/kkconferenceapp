
import 'package:flutter/material.dart';
import 'package:kk_conferences/global/Global.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/widgets/drawer.dart';

class CustomerCancellationRequest extends StatefulWidget {
  static const classname="/CustomerCancellationRequest";
  const CustomerCancellationRequest({Key key}) : super(key: key);

  @override
  _CustomerCancellationRequestState createState() => _CustomerCancellationRequestState();
}

class _CustomerCancellationRequestState extends State<CustomerCancellationRequest> {
  List<BookingModel> bookings=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(

      ),

      appBar: AppBar(),
      drawer: Drawer(
        child: CommonDrawer(
          username: Global.activeStaff.name,
          email: Global.activeStaff.email,
        ),
      ),
    );
  }
}
