
import 'package:flutter/material.dart';
import 'package:kk_conferences/Screens/customer_boooking_cancellation_screen/cancel_booking_reason_screen.dart';
import 'package:kk_conferences/global/Global.dart';
import 'package:kk_conferences/global/const_funcitons.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/model/carrage_model.dart';
import 'package:kk_conferences/providers/staff/customer_cancellation_request_provider.dart';
import 'package:kk_conferences/utils/dialog.dart';
import 'package:kk_conferences/widgets/booking_cancel_widget.dart';
import 'package:kk_conferences/widgets/booking_requests.dart';
import 'package:kk_conferences/widgets/drawer.dart';
import 'package:provider/provider.dart';


class CustomerCancellationRequest extends StatefulWidget {
  static const classname="/CustomerCancellationRequest";
  const CustomerCancellationRequest({Key key}) : super(key: key);

  @override
  _CustomerCancellationRequestState createState() => _CustomerCancellationRequestState();
}

class _CustomerCancellationRequestState extends State<CustomerCancellationRequest> {
  List<BookingModel> bookings=[];
   CustomerCancellationRequestProvider cancellationRequest;

  @override
  void initState() {
    super.initState();
    cancellationRequest=CustomerCancellationRequestProvider.instance();
    cancellationRequest.loadCancellationRequestions();
  }

  @override
  Widget build(BuildContext context) {
    cancellationRequest.context=context;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: CommonDrawer(
          username: Global.activeStaff.name,
          email: Global.activeStaff.email,
        ),
      ),
      body:  Consumer<CustomerCancellationRequestProvider>(
        builder: (context, value,child) {
          return ListView(
            shrinkWrap: true,
            children: [
              if(cancellationRequest.list_of_bookings.isNotEmpty)
                ...cancellationRequest.list_of_bookings.map((e) => BookingCancelWidget(
                  title: "${e.roomname ?? ""}",
                  amount: e.amount ?? "",
                  start_duration:
                  getDateWith12HrsFormat(e.bookingStartTime),
                  end_duration:
                  getDateWith12HrsFormat(e.bookingEndTime),
                  date_of_booking: e.bookingDate,
                  readRequest: (){
                    Navigator.pushNamed(context,CancelBookingReason.classname,arguments: Carrage(bookingModel: e,cancellation_read_only: true) );
                  },
                  onapprove: () {
                    DialogUtil(
                      btnOkOnPress: () {
                        cancellationRequest.onapprovecancellation(e);
                      },
                      context: context,
                      message:
                      "Do you like to approve cancellation of customer ",
                      title: "Approve Cancellation?",
                    ).showWarningDialog();
                  },
                  onrightbtncalling: () {
                    cancellationRequest.denybooking(e);
                  },
                  iconright: Icons.dangerous,
                  rightbtnText: "Deny",
                  rightbtnColor: Colors.red[800],

                  disableapprove: e.bookingStatus ?? false,
                ))
            ],
          );
        }
      ),



    );
  }
}
