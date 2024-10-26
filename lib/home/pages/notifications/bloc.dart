
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
part 'model.dart';
part 'events.dart';
part 'state.dart';
class GetNotificationsBloc extends Bloc<GetNotificationsEvents,GetNotificationsStates>{
  final DioHelper _dio;
  GetNotificationsBloc(this._dio):super(GetNotificationsLoadingState()){
    on<GetNotificationsEvents>(_getData);
  }


  Future<void> _getData(GetNotificationsEvents event, Emitter<GetNotificationsStates> emit) async{
    final response = await _dio.get("notifications");
    final model  = NotificationsData.fromJson(response.data["data"]);
    if(response.isSuccess){
      emit(GetNotificationsSuccessState(list: model.list));
      // emit(GetNotificationsSuccessState(list: _fakeList));
    }else{
      emit(GetNotificationsFailedState(msg: response.msg!));
    }
  }
}