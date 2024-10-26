part of'bloc.dart';
class OTPEvents{}
class SendOTPEvent extends OTPEvents{
  final String phone;

  SendOTPEvent({required this.phone});
}
