part of'bloc.dart';
class ContactUsStates{}
class ContactUsLoadingStates extends ContactUsStates{}
class ContactUsSuccessStates extends ContactUsStates{
  final String msg;

  ContactUsSuccessStates({required this.msg});
}
class ContactUsFaildStates extends ContactUsStates{
  final String msg;

  ContactUsFaildStates({required this.msg});
}