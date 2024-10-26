import 'dart:async';
import 'dart:io';
import 'package:app/core/logic/helper_methods.dart';
import 'package:app/products/auth/login/view.dart';
import 'package:app/home/pages/home/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/dio_helper.dart';
part 'events.dart';
part 'states.dart';
class OTPBloc extends Bloc<OTPEvents,OTPStates>{
  final DioHelper _dio;
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  OTPBloc(this._dio) : super(OTPStates()){
    on<SendOTPEvent>(_send);
  }

  Future<void> _send(SendOTPEvent event, Emitter<OTPStates> emit)async {
    try {

      if(formKey.currentState!.validate()){
        emit(OTPLoadingState());
        final response = await _dio.send("verify", data: {
          "phone": event.phone,
          "code":codeController.text,
          "device_token": "test",
          "type": Platform.operatingSystem,
        });
        if(response.isSuccess){
          showMessage(response.msg!.isEmpty?"تم تفعيل الحساب":response.msg!,messageType: MessageType.Success);
          navigateTo(ProductLoginView(),keepHistory: false);
          emit(OTPSuccessfulState());
        }else{
          showMessage(response.msg!);
          emit(OTPFailedState());
        }
      }
    }on NetworkException catch(_){
      showMessage("Check your connection");
      emit(OTPFailedState());
    }

  }

}