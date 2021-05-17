

import 'package:dio/dio.dart';
import 'package:kk_conferences/api/web_api/core/api_response.dart';
import 'package:kk_conferences/api/web_api/core/dio_instance.dart';
import 'package:kk_conferences/api/web_api/core/api_routes.dart';
import 'package:kk_conferences/model/booking_model.dart';
import 'package:kk_conferences/model/razorpay/razorpay_payment.dart';
import 'package:kk_conferences/utils.dart';
class RazorPayRefundApi{
  Dio dio = ApiBase.instance();

  Future<Response>performRefund(RazorPayPaymentModel model) async {
    Response response = await dio.post("/payments/${model.id}/refund",
        options:
        Options(headers: <String, String>{'authorization': ApiBase.auth},));
    return response;
  }


}
