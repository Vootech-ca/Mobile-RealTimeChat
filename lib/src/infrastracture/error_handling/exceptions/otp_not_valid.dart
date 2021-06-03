import 'app_exception.dart';

class OTPNotValidException implements AppException {
  String message;

  OTPNotValidException({this.message}) {
    if (message == null || message.isEmpty) {
      message = "OTP code is not valid.";
    }
  }

  @override
  String toString() => message;
}
