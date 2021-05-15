import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kk_conferences/Screens/HomeScreen/home_screen.dart';
import 'package:kk_conferences/Screens/STAFF/AdminBookingScreen/day_wise_booking.dart';
import 'package:kk_conferences/api/FirbaseApi.dart';
import 'package:kk_conferences/api/firebase_clerk_api.dart';
import 'package:kk_conferences/global/Global.dart';
import 'package:kk_conferences/global/const_funcitons.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:kk_conferences/model/customer.dart';
import 'package:kk_conferences/model/staff_model.dart';
import 'package:kk_conferences/utils/m_progress_indicator.dart';
import 'package:kk_conferences/utils/preference.dart';
import 'package:kk_conferences/utils/validation.dart';
import 'package:kk_conferences/widgets/sign_up_user_radio_button.dart';

class SignInProvider extends ChangeNotifier {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  GlobalKey<ScaffoldState> scaffoldkey;
  Function() onsuccessNavigateHome;
  BuildContext context;
  String defautUser = CUSTOMER;

  void performSignIn() async {
    if (checkButtonEnable() == true) {
      disableButton();
      print("action started");
    } else {
      return;
    }

    if (emailController.text.isEmpty) {
      scaffoldkey.currentState
          .showSnackBar(new SnackBar(content: Text("Email is Undefined")));
      return;
    }
    if (passwordController.text.isEmpty) {
      scaffoldkey.currentState
          .showSnackBar(new SnackBar(content: Text("Password is Undefined")));
      return;
    }

    if (Validation().isEmailValid(emailController.text) == false) {
      scaffoldkey.currentState
          .showSnackBar(new SnackBar(content: Text("Email format Incorrect")));
      return;
    }
    MProgressIndicator.show(context);
    if (defautUser == CUSTOMER) {
      signInCustomer();
    }

    if (defautUser == CLERK) {
      signInClerk();
    }

    if (defautUser == ADMIN) {
      signInClerk();
    }
  }

  signInCustomer() async {

    try {
      Customer customer = Customer(
          email: emailController.text, password: passwordController.text);

      CustomerResult result = await FireBaseCustomersApi().signIn(customer);
      if (result.status == 1) {
        // on sucess

        showMessage(scaffoldkey, result.msg);
        Global.activeCustomer = result.customer;
        Global.activeUser = CUSTOMER;
        Preference.setString(login_credentials, jsonEncode(result.customer));
        Preference.setString(activeUser_pref, CUSTOMER);
        print("name of active customer is ${Global.activeCustomer.email}");
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.classname, (route) => false);
      } else if (result.status == 0) {
        // on failed
        showMessage(scaffoldkey, result.msg);
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

    }
    MProgressIndicator.hide();
  }

  signInClerk() async {
    StaffModel staffModel = StaffModel(
        email: emailController.text, password: passwordController.text);

    StaffResult result = await FirebaseMemberApi().signIn(staffModel);
    if (result.status == 1) {
      // on sucess

      showMessage(scaffoldkey, result.msg);
      Global.activeStaff = result.staffModel;
      Global.activeUser = CLERK;
      Preference.setString(staff_credentials, jsonEncode(result.staffModel));
      Preference.setString(activeUser_pref, CLERK);
      print("name of active staffmember is ${Global.activeStaff.email}");
      Navigator.of(context)
          .pushNamedAndRemoveUntil(DayWiseBookings.classname, (route) => false);
    } else if (result.status == 0) {
      // on failed
      showMessage(scaffoldkey, result.msg);
    }
    MProgressIndicator.hide();
  }
}
