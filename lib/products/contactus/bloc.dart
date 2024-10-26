import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/logic/dio_helper.dart';
part 'events.dart';
part 'states.dart';

class ContactUsBloc extends Bloc<ContactUsEvents,ContactUsStates>{
  ContactUsBloc(this._dio):super(ContactUsStates()){
    on<SendContactUsEvent>(_sendData);
  }
  final DioHelper _dio;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();


  Future<void> _sendData(SendContactUsEvent event, Emitter<ContactUsStates> emit) async {
    final response = await _dio.send("contact",data: {
      "fullname":nameController,
      "phone":phoneController,
      "title":titleController,
      "content":contentController
    });
    if(response.isSuccess){
      emit(ContactUsSuccessStates(msg: response.msg!));
    }else{
      emit(ContactUsFaildStates(msg:response.msg!));
    }
  }
}