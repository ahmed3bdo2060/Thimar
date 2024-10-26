part of 'bloc.dart';
class CartStates{}
class CartLoadingState extends CartStates{}
class CartFailedState extends CartStates{
  final String msg;

  CartFailedState({required this.msg});
}
class CartSuccessState extends CartStates{
  final CartData model;

  CartSuccessState({required this.model});
}
