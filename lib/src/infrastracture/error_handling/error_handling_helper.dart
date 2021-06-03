import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:vootech_realchat/src/infrastracture/error_handling/exceptions/app_exception.dart';
import 'package:vootech_realchat/src/infrastracture/error_handling/exceptions/internal_server_exception.dart';
import 'package:vootech_realchat/src/infrastracture/error_handling/exceptions/no_internet.dart';
import 'package:vootech_realchat/src/infrastracture/error_handling/exceptions/unauthorized_access.dart';
import 'package:vootech_realchat/src/models/exception_data_model.dart';

class ErrorHandlingHelper {
  static bool ensureSuccessResponse(Response response, {String defaultMsg}) {
    if (response.statusCode == 200) return true;

    if (response.statusCode == 500) {
      throw new InternalServerException();
    }

    if (response.statusCode == 302) {
      // Network is connected, but it is limited. For example when network need to recharge
      // The target resource resides temporarily under a different URI.
      throw new NoInternetException(statusCode: 302);
    }

    if (response.statusCode == 401) {
      throw new UnAuthorizedAccessException();
    }

    throw new AppException(message: defaultMsg);
  }

  static ExceptionDataModel getExceptionUIData(BuildContext context, Exception exception) {
    var result = new ExceptionDataModel(message: "Unknown error occurred. Please try again");
    if (exception is AppException) {
      result.message = exception.message;
    }

    if (exception is NoInternetException) {
      if (exception.statusCode == 302) {
        result.message = "Error communicating with server. Please check your internet connection";
      } else {
        result.message = "Error communicating with server";
      }
    }

    if (exception is SocketException) {
      if (exception.osError.errorCode == 101) {
        result.message = "Network is unreachable";
      } else {
        result.message = "Error communicating with server";
      }
    }

    if (exception is InternalServerException) {
      result.message = "Unknown error occurred in server";
    }

    return result;
  }
}
