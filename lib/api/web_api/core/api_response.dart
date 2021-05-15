import 'package:flutter/material.dart';

/// Basic API Response from server
class APIResponse<T> {
  final int status;
  final String message;
  final T result;
  final T completeResponse;

  APIResponse({@required this.status, @required this.message, this.result,this.completeResponse});
}
