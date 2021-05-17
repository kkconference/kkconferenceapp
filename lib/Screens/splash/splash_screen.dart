import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kk_conferences/Screens/STAFF/AdminBookingScreen/day_wise_booking.dart';
import 'package:kk_conferences/Screens/SignInScreen/signin.dart';
import 'package:kk_conferences/Screens/splash/splash_helper.dart';
import 'package:kk_conferences/api/firebase_clerk_api.dart';
import 'package:kk_conferences/api/web_api/razorpay_payment.dart';
import 'package:kk_conferences/global/Global.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:kk_conferences/model/customer.dart';
import 'package:kk_conferences/model/staff_model.dart';
import 'package:kk_conferences/utils/preference.dart';

import '../SignUp/signup_user.dart';
import '../HomeScreen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const classname="/SplashScreen";
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';


  @override
  void initState() {
   /* _registerOnFirebase();
     getMessage();
*/

    super.initState();
    Timer(Duration(seconds: 3), () {
      performNavigate();
    });
  }


 /* _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => log(token));
  }
  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('received message');
          setState(() => _message = message["notification"]["body"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["body"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["body"]);
    });
  }

*/

  performNavigate() async {
  //  await RazorPayPayment().getPaymentDetails();

     await SplashHelper().initRoomInfo(context);


    Global.activeUser=await Preference.getString(activeUser_pref);

    if(Global.activeUser == null){
      print("user not logged in yet");
      Navigator.pushReplacementNamed(context, SignInPage.classname);
    }else{

      if(Global.activeUser==CUSTOMER){
        performCustomerNavigate();
      }else if(Global.activeUser==CLERK){
        performStaffNavigate();
      }else if(Global.activeUser==ADMIN){
        performStaffNavigate();
      }

    }


    //FireBaseApi().checkUserExist(Customer(email: "abc@gmail.com"));
  }


  performCustomerNavigate(){

    if(Preference.getString(login_credentials) == null){
      print("user not logged in yet");
      Navigator.pushReplacementNamed(context, SignInPage.classname);
    }else{
      Global.activeCustomer=Customer.fromJson(jsonDecode(Preference.getString(login_credentials)));
      Navigator.of(context).pushNamedAndRemoveUntil(HomePage.classname, (route) => false);
      print("name of active customer is ${Global.activeCustomer.email}");
    }

  }

  performStaffNavigate() async{
   String staff_data= await Preference.getString(staff_credentials);
    if( staff_data == null){
      print("user not logged in yet");
      Navigator.pushReplacementNamed(context, SignInPage.classname);
    }else{
      Global.activeStaff=StaffModel.fromJson(jsonDecode(Preference.getString(staff_credentials)));
      Navigator.of(context).pushNamedAndRemoveUntil(DayWiseBookings.classname, (route) => false);
      print("name of active staff is ${Global.activeStaff.email}");
    }

  }



  @override
  Widget build(BuildContext context) {
    return Container(
      //    color: main_color,
        color: Colors.white,
        child: Image.asset('assets/logo.png'));
  }
}
