import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kk_conferences/api/firebase_clerk_api.dart';
import 'package:kk_conferences/api/web_api/razorpay_payment.dart';
import 'package:kk_conferences/global/const_funcitons.dart';
import 'package:kk_conferences/model/razorpay/razorpay_pqayment_list.dart';

class AccountProvider extends ChangeNotifier {
  bool ispayment = true;
  List<PaymentItem> items = [];
  PaymentModel model;
   String title="Revenue";
   String amount="Loading...";
  updatePayments(DateTime picked) async {
    print(picked.toString());
    model = await RazorPayPaymentApi().getPaymentTimestamp(picked);

    if (ispayment == true) {
      setPayments();
    } else if (ispayment == false) {
      setRefunds();
    }


  }

  setPayments() {
    title="Payments";
    ispayment = true;
    double amt=0;
    items=[];
    if (model != null)
      model.items.forEach((element) {
        if (element.status == "captured" || element.status == "authorized" ) {items.add(element);
        amt+=element.amount;
        }
      });

    amount=amt.toString();
    notifyListeners();
  }

  setRefunds() {
    ispayment = false;
    double amt=0;
    items=[];
    title="Refunds";
    if (model != null)
      model.items.forEach((element) {
        if (element.status == "refunded") {
          items.add(element);
          amt+=element.amount;
        }});

  amount=amt.toString();
    notifyListeners();
  }
}
