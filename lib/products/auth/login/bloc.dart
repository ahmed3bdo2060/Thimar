import 'dart:async';
import 'dart:io';
import 'package:app/core/logic/helper_methods.dart';
import 'package:app/home/pages/home/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/logic/dio_helper.dart';
part 'events.dart';
part 'states.dart';
class LoginBloc extends Bloc<LoginEvents,LoginStates>{
  final DioHelper _dio;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBloc(this._dio) : super(LoginStates()){
    on<SendLoginEvent>(_send);
  }

  Future<void> _send(SendLoginEvent event, Emitter<LoginStates> emit)async {
    try {

      if(formKey.currentState!.validate()){
        emit(LoginLoadingState());
        final response = await _dio.send("login", data: {
          "phone": phoneController.text,
          "password": passwordController.text,
          "device_token": "test",
          "type": Platform.operatingSystem,
          "user_type": "client",
        });
        if(response.isSuccess){
          emit(LoginSuccessfulState());
          navigateTo(ProductsView(),keepHistory: false);
        }else{
          showMessage(response.msg!);
          emit(LoginFailedState());
        }
      }
      }on LoginException catch(error){
      showMessage(error.message);
      emit(LoginFailedState());
    }on NetworkException catch(_){
      showMessage("Check your connection");
      emit(LoginFailedState());
    }

  }

}