import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kk_conferences/api/web_api/core/api_response.dart';
import 'package:kk_conferences/api/web_api/core/dio_instance.dart';
import 'package:kk_conferences/api/web_api/core/api_routes.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/model/razorpay/razorpay_error_model.dart';
import 'package:kk_conferences/model/razorpay/razorpay_payment.dart';
import 'package:kk_conferences/model/razorpay/razorpay_pqayment_list.dart';
import 'package:kk_conferences/utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPaymentApi {
  Dio dio = ApiBase.instance();

  getPaymentDetails(BookingModel model) async {
    Response response = await dio.get("/payments/${model.paymentId}",
        options: Options(
          headers: <String, String>{'authorization': ApiBase.auth},
        ));

    return RazorPayPaymentModel.fromJson(response.data);
  }

  capturePayment(BookingModel model) async {
    RazorPayPaymentModel paymentModel = await getPaymentDetails(model);

    var params = {
      "amount": paymentModel.amount,
      "currency": paymentModel.currency
    };
    Response response;
    try {
      response = await dio.post("/payments/${model.paymentId}/capture",
          options:
              Options(headers: <String, String>{'authorization': ApiBase.auth}),
          data: jsonEncode(params));
    } catch (e) {}

    return paymentModel;
  }

  Future<PaymentModel> getPaymentTimestamp(DateTime picked) async {
    Response response = await dio.get("/payments",
        queryParameters: {
          "from": "${Timestamp.fromDate(DateTime(picked.year, picked.month, picked.day, 0, 0, 0)).seconds}",
          "to":
              "${Timestamp.fromDate(DateTime(picked.year, picked.month, picked.day, 23, 59, 0)).seconds}"
        },
        options: Options(
          headers: <String, String>{'authorization': ApiBase.auth},
        ));

    return PaymentModel.fromJson(response.data);
  }
}
