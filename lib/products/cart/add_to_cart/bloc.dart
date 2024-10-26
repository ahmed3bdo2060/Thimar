import 'dart:async';

import 'package:app/core/logic/helper_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';

class AddToCartBloc extends Bloc<AddToCartEvents,AddToCartStates>{
  final DioHelper _dio;
  AddToCartBloc(this._dio):super(AddToCartStates()){
    on<GetAddToCartEvent>(_sendData);
  }
  Future<void> _sendData(GetAddToCartEvent event, Emitter<AddToCartStates> emit)async {
    emit(AddToCartLoadingState(id: event.id));
  final response = await _dio.send("client/cart",data: {
  "product_id":event.id,
  "amount":event.amount
  }
  );
  if(response.isSuccess){
    showMessage(response.msg!,messageType: MessageType.Success);
    emit(AddToCartSuccessState(msg: response.msg!));
  }else{
    showMessage(response.msg!);
  emit(AddToCartFailedState(msg: response.msg!));
  }

  }

}