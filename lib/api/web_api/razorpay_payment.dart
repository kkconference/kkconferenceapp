

import 'package:dio/dio.dart';
import 'package:kk_conferences/api/web_api/core/api_response.dart';
import 'package:kk_conferences/api/web_api/core/dio_instance.dart';
import 'package:kk_conferences/api/web_api/core/api_routes.dart';
import 'package:kk_conferences/model/razorpay/razorpay_payment.dart';
import 'package:kk_conferences/utils.dart';
class RazorPayPayment{

  static Dio _dio = ApiBase.getDio();
  getPaymentDetails()async{
   APIResponse response=  await  ApiBase.baseFunction(()=>_dio.get(ApiRoutes.payment_details));

   print("user email is ${RazorPayPaymentModel.fromJson(response.completeResponse).email}");
  }

}
