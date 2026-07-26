import 'package:flowery/modules/auth/data/models/requestes/forget_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/reset_password_request.dart';
import 'package:flowery/modules/auth/data/models/requestes/verify_reset_password_request.dart';



sealed class ForgetPasswordEvent {}

class SendEmailEvent extends ForgetPasswordEvent {
  final ForgetPasswordRequest request;

   SendEmailEvent({
    required this.request,
  });
}

class VerifyEmailEvent extends ForgetPasswordEvent {
  final VerifyResetPasswordRequest request;

   VerifyEmailEvent({
    required this.request,
  });
}

class ResetPasswordEvent extends ForgetPasswordEvent {
  final ResetPasswordRequest request;

   ResetPasswordEvent({
    required this.request,
  });
}

class UpdateOtpEvent extends ForgetPasswordEvent {
  final String otp;

  UpdateOtpEvent({required this.otp});
}
