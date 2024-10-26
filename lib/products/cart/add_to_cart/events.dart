part of 'bloc.dart';
class AddToCartEvents{}
class GetAddToCartEvent extends AddToCartEvents{
  final num id;
  int amount;

  GetAddToCartEvent({required this.id,this.amount=1});
}
