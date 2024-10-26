import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
part 'states.dart';
part 'events.dart';
part 'model.dart';

class CartBloc extends Bloc<CartEvents,CartStates>{
  final DioHelper _dio;
  CartBloc(this._dio):super(CartLoadingState()){
    on<GetCartEvent>(getDatat);
  }


  Future<void> getDatat(GetCartEvent event, Emitter<CartStates> emit)async
  {
    final response = await _dio.get("client/cart");
    if(response.isSuccess){
      final model = CartData.fromJson(response.data);
      emit(CartSuccessState(model: model));
    }else{
      emit(CartFailedState(msg: response.msg!));
    }

  }
}