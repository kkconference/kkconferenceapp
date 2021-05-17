import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_response.dart';

const base_url = "https://api.razorpay.com/v1";


abstract class Status {
// [Description("true")]
  static const Success = 200,

// [Description("false")]
      Failed = 400,
      EmptyModel = 202,
      Unauthorized = 401,
      Duplicate = 409,
      VerifyEmail = 5001;
}


class ApiBase {
  static  Dio dio;
  static String auth = 'Basic '+base64Encode(utf8.encode('${appmode==test?razor_id_test:razor_id}:${appmode==test?razor_secret_test:razor_secret}'));
  static Dio instance(){
    if(dio==null){
      dio=getDio();
    }
    return dio;
  }


   static Dio getDio() {


    dio = Dio(BaseOptions(
      baseUrl: base_url,
      connectTimeout: 30000,
      receiveTimeout: 30000,

    ))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
     dio.options.headers["Authentication"]=auth;
    return dio;
  }

  static Future<APIResponse> baseFunction(ResponseCallback callback) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Response resp = await callback();
        return APIResponse(
            completeResponse:resp.data,
            status: resp.statusCode,
            result: resp.statusMessage,
            message: "");

      } else
        return APIResponse(
            message: "Something went wrong", status: Status.Failed, result: {});
    } on SocketException {
      return APIResponse(
          message: "Check your internet connection",
          status: Status.Failed,
          result: {},

      );
    } on DioError catch (error) {
      print("in dio error");
      print(error);
      print(error.response?.data);
      return APIResponse(
          completeResponse:error.response?.data ,
          message: (error.response?.data ?? {})['message']?.toString() ??
              error.message,
          result: (error.response?.data ?? {})['result'] ?? {},
          status: error.response?.statusCode ?? Status.Failed);


    } catch (error) {
      print(error);
      // rethrow;

      return APIResponse(
          message: "Something went wrong", status: Status.Failed, result: {});
    }
  }


}
typedef Future<Response> ResponseCallback();