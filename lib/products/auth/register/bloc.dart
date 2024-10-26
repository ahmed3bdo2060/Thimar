import 'dart:async';
import 'dart:io';
import 'package:app/core/logic/dio_helper.dart';
import 'package:app/core/logic/helper_methods.dart';
import 'package:app/products/auth/otp/view.dart';
import 'package:app/home/pages/home/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'events.dart';
part 'states.dart';
class RegisterBloc extends Bloc<RegisterEvents,RegisterStates>{
  final DioHelper _dio;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameController = TextEditingController();
  final cityController = TextEditingController(text: "المنوفية");

  RegisterBloc(this._dio) : super(RegisterStates()){
    on<SendRegisterEvent>(_send);
  }

  Future<void> _send(SendRegisterEvent event, Emitter<RegisterStates> emit)async {
    try {

      if(formKey.currentState!.validate()){
        emit(RegisterLoadingState());
        final response = await _dio.send("client_register", data: {
          "fullname": userNameController.text,
          "phone": phoneController.text,
          "password": passwordController.text,
          "password_confirmation": confirmPasswordController.text,
          "city_id":5,
          "country_id":1,

        });
        if(response.isSuccess){
          showMessage(response.msg!,messageType: MessageType.Success);
          navigateTo(OTPView(phone: phoneController.text));
          emit(RegisterSuccessfulState());
        }else{
          showMessage(response.msg!);
          emit(RegisterFailedState());
        }
      }
      }on LoginException catch(error){
      showMessage(error.message);
      emit(RegisterFailedState());
    }on NetworkException catch(_){
      showMessage("Check your connection");
      emit(RegisterFailedState());
    }

  }

}