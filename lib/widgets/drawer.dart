import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kk_conferences/Screens/STAFF/account_screen.dart';
import 'package:kk_conferences/Screens/STAFF/customer_refund_screen/customer_cancellation_request_list.dart';
import 'package:kk_conferences/Screens/STAFF/room_price/room_price.dart';
import 'package:kk_conferences/Screens/SignInScreen/signin.dart';
import 'package:kk_conferences/Screens/SignUp/admin/signup_admin.dart';
import 'package:kk_conferences/Screens/customer_cancellation_screen/customer_cancellation_screen.dart';
import 'package:kk_conferences/Screens/my_bookings/my_bookings.dart';
import 'package:kk_conferences/api/FirbaseApi.dart';
import 'package:kk_conferences/global/Global.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:kk_conferences/utils/preference.dart';
import 'package:kk_conferences/widgets/active_booking_items.dart';
class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: main_color,
      alignment: Alignment.center,
      child: child,
    );
  }
}
class CommonDrawer extends StatefulWidget {
  String username;
  String email;

  CommonDrawer({this.username = "Not Defined", this.email = "not define"});

  @override
  _CommonDrawerState createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CustomAppBar(),
      body: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(widget.username),
            accountEmail: Text(widget.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                widget.username.characters.first,
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          if (Global.activeUser == CUSTOMER)
          ListTile(
            onTap: () async {
              Navigator.pushNamed(context, MyBookings.classname);
            },
            title: Text("All Bookings"),
            trailing: Icon(Icons.arrow_forward),
          ),

 /*       ListTile(
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()));
            },
            title: Text("All Bookings"),
            trailing: Icon(Icons.arrow_forward),
          ),*/


          if (Global.activeUser == CUSTOMER)
            ListTile(
              title: Text("Cancel Bookings"),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.pushNamed(
                    context, CustomerCancellationApplication.classname);

              },
            ),
          if (Global.activeUser == ADMIN)
            ListTile(
              title: Text("Cancellation Request"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(
                    context, CustomerCancellationRequest.classname);
              },
            ),
          if (Global.activeUser == ADMIN)
            ListTile(
              title: Text("Create New Staff Member"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, SignUpAdminScreen.classname);
              },
            ),
          if (Global.activeUser == ADMIN)
            ListTile(
              title: Text("Change room price"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, RoomPrice.classname);
              },
            ),
          if (Global.activeUser == ADMIN)
            ListTile(
              title: Text("Accounts"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, Account.classname);
              },
            ),

          ListTile(
            onTap: () async {
              Global.activeCustomer = null;
              Global.activeStaff = null;
              Preference.remove(login_credentials);
              Preference.remove(activeUser_pref);
              Navigator.pushNamed(context, SignInPage.classname);
            },
            title: Text("LogOut"),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
