import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  static const classname = "/TermsAndConditions";

  const TermsAndConditions({Key key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  TextStyle style = TextStyle(fontSize: 15);
  TextStyle numberstyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  double boxheight = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            _getRow("1", "Booking once made will not be transferred."),
            SizedBox(
              height: boxheight,
            ),
            _getRow("2",
                "Management will not be responsible for malfunctioning or non-functioning of projector, TV set, sudden failure of power supply, malfunctioning of air conditional units etc. "),
            SizedBox(
              height: boxheight,
            ),
            _getRow("3",
                "The time slot for which booking is done shall be the only time for which conference room shall be available. In case of extension, same will be granted subject to availability of the selected conference room and on payment of additional charges for extended hours. "),
            SizedBox(
              height: boxheight,
            ),
            _getRow("4",
                "The fraction of hours will be counted as hours and payment bas to be made accordingly. "),
            SizedBox(
              height: boxheight,
            ),
            _getRow("5",
                "Management reserve right to refuse booking without assigning any reason. "),
            SizedBox(
              height: boxheight,
            ),
            _getRow("6",
                "Carrying or consumption of alcohol, contraband substance and non-veg. are strictly prohibited in the conference premises. "),
            SizedBox(
              height: boxheight,
            ),
            _getRow("7",
                "The booking once made can be cancelled subject to payment of cancellation charges as follows:"),
            SizedBox(
              height: boxheight,
            ),
            _getSubtitleRow("",
                "(a)	Cancellation of booking on or before 48 hours of the commencement of the booking hours, cancellation charges shall be 20% of booking charges or Rs. 1000 whichever is more,"),
            SizedBox(
              height: boxheight,
            ),
            _getSubtitleRow("",
                "(b)	Cancellation of booking between 24 to 48 hours of the commencement of the booking hours, cancellation charges shall be 50% of booking charges or Rs. 1500 whichever is more, and"),
            SizedBox(
              height: boxheight,
            ),
            _getSubtitleRow("",
                "(c)	Upon cancellation between 0-24 hours of the commencement of the booking hours, no refund will be made and entire booking amount for selected time slot for conference booked shall be payable.  "),
            SizedBox(
              height: boxheight,
            ),
            _getRow("8",
                "Once the cancellation is done for particular time, fresh charges shall be payable for same time slot for booking as if fresh booking."),
            SizedBox(
              height: boxheight,
            ),
            _getRow("9",
                "	Once the cancellation is done for particular time, fresh charges shall be payable for same time slot for booking as if fresh booking."),
            SizedBox(
              height: boxheight,
            ),
            _getRow("10",
                "Management will not be responsible for misplace or missing of any belongings or valuables. "),
            SizedBox(
              height: boxheight,
            ),
            _getRow("11",
                "The snacks, tea, coffee, lunch, etc shall be arranged by office boy from outside on advance order placed with him and subjected to availability and upon payment of additional charges. The Management will not be responsible for quality, quantity, taste or charges of food so ordered."),
            SizedBox(
              height: boxheight,
            ),
            _getRow("12",
                "Papers, books, briefs etc must be removed immediately upon completion of conference."),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  _getRow(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$number. ",
          style: numberstyle,
        ),
        Container(
            width: MediaQuery.of(context).size.width * .86,
            child: Text(
              "$text",
              style: style,
              maxLines: 20,
            )),
      ],
    );
  }

  _getSubtitleRow(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$number ",
          style: numberstyle,
        ),
        SizedBox(
          width: 30,
        ),
        Container(
            width: MediaQuery.of(context).size.width * .80,
            child: Text(
              "$text",
              overflow: TextOverflow.clip,
              style: style,
              maxLines: 20,
            )),
      ],
    );
  }
}
