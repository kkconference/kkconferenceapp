
import 'package:flutter/material.dart';
import 'package:kk_conferences/Screens/BookingScreen/booking_screen.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:kk_conferences/model/carrage_model.dart';
import 'package:kk_conferences/model/confress_model.dart';
import 'package:kk_conferences/widgets/hotel_price_text.dart';
import 'package:kk_conferences/widgets/ticket_rent.dart';

import 'amenitie_item.dart';

class HotelInformationTab extends StatefulWidget {
  HotelInformationTab({
    Key key,
    @required this.room,
  }) : super(key: key);

  RoomInfo room;

  @override
  _HotelInformationTabState createState() => _HotelInformationTabState();
}

class _HotelInformationTabState extends State<HotelInformationTab> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TicketRent(
              title: 'FOR RENT',
              color: main_color,
            ),
            HotelPriceText(price: widget.room.price)
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  widget.room.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
           // Spacer(),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: InkWell(
                onTap: ()=>Navigator.pushNamed(context, BookingScreen.classname,arguments: Carrage(confressModel: widget.room)),
                child: BuyNow(
                  title: 'Book Now',
                  color: main_color,
                ),
              ),
            )
          ],
        ),
        SizedBox(height:10),
        Divider(height: 2, color: Colors.grey),
        SizedBox(height: 14),
        AnimatedContainer(
          width: 200.0,
          height: selected ? 250.0 : 100.0,
          alignment:
              selected ? Alignment.center : AlignmentDirectional.topCenter,
          duration: Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          child: Text(widget.room.description),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              selected = !selected;
            });
          },
          child: Text(
            'More info',
            style: TextStyle(color: main_color),
          ),
        ),
        Text('Amenities', style: Theme.of(context).textTheme.headline6),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 90),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.room.amenities.length,
            itemBuilder: (_, index) =>
                AmenitieItem(amenitie: widget.room.amenities[index]),
          ),
        ),
      ],
    );
  }
}
