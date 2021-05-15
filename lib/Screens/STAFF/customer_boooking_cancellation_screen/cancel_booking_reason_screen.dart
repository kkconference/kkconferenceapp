

import 'package:flutter/material.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/providers/my_booking_provider.dart';
import 'package:kk_conferences/utils/m_progress_indicator.dart';
import 'package:kk_conferences/widgets/drawer.dart';
import 'package:kk_conferences/widgets/gradient_button.dart';
import 'package:kk_conferences/widgets/multiTextInput.dart';
import 'package:provider/provider.dart';

class CancelBookingReason extends StatefulWidget {
  static const classname="/CancelBookingReason";

  const CancelBookingReason({Key key}) : super(key: key);

  @override
  _CancelBookingReasonState createState() => _CancelBookingReasonState();
}

class _CancelBookingReasonState extends State<CancelBookingReason> {
  TextEditingController cancel_reason=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final provider =Provider.of<MyBookingProvider>(context);
    BookingModel model=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Cancellation Reason"),),
      drawer: CommonDrawer(),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Please Write Reason below for cancellation.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: MultiLineTextInput(m_hintText:"", m_helperText:"", m_labelText:"Write here", controller: cancel_reason)
          ),
          Padding(
             padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.3),
              child: GradientButton(onpress: (){
                MProgressIndicator.show(context);
                print(model.bookingId);
                model.cancellationDescription=cancel_reason.text;
                provider.performCancelBooking(model);
              },text: "Submit",))
        ],
      ),
    );
  }
}
