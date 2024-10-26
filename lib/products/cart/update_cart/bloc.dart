import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';


part 'states.dart';

part 'events.dart';

class UpdateCartBloc extends Bloc<UpdateCartItemEvent, UpdateCartItemStates> {
  final DioHelper _dio;

  UpdateCartBloc(this._dio) :super(UpdateCartItemStates()) {
    on<UpdateCartItemEvent>(_sendData);
  }

  Future<void> _sendData(UpdateCartItemEvent event,
      Emitter<UpdateCartItemStates> emit)
  async
  {
    emit(UpdateCartItemLoadingState());
    final response =await _dio.send("client/cart/${event.id}",data:{
    "amount":"${event.isAdd?event.amount+1:event.amount-1}",
      "_method":"PUT"
    });
    if(response.isSuccess){
      showMessage("تم الاضافة بنجاح");
      emit(UpdateCartItemSuccessState(id: event.id, isAdd: event.isAdd));
    }else{
      emit(UpdateCartItemFailedState(msg: response.msg!));
    }
}}