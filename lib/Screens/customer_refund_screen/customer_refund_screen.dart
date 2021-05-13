
import 'package:flutter/material.dart';
import 'package:kk_conferences/global/Global.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/widgets/drawer.dart';

class CustomerRefund extends StatefulWidget {
  const CustomerRefund({Key key}) : super(key: key);

  @override
  _CustomerRefundState createState() => _CustomerRefundState();
}

class _CustomerRefundState extends State<CustomerRefund> {
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
