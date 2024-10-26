import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
part 'model.dart';
part 'states.dart';
part 'events.dart';

class SliderBloc extends Bloc<SliderEvents,SliderStates>{
  SliderBloc(this._dio):super(SliderLoadingState()){
    on<SliderEvent> (_getData);
    on<SliderTimerEvent>(_Timer);
  }
  final DioHelper _dio;
  int currentIndex=0;
  final pageController = PageController();
  late SliderData model=SliderData.fromJson(response.data);
  late CustomResponse response;
  Future<void> _getData(SliderEvent event, Emitter<SliderStates> emit)async {
    response = await _dio.get("sliders");
    if(response.isSuccess){
      model = SliderData.fromJson(response.data);
    }
    emit(SliderFailedState());
  }
  void  onchange(value){
    currentIndex = value;
    emit(SliderSuccessfulState());
  }

  Future<void> _Timer(SliderTimerEvent event, Emitter<SliderStates> emit)async {
    await Timer.periodic(Duration(seconds: 2), ( timer) {
      if(currentIndex<model.list.length-1){
        currentIndex++;
      }else{
        currentIndex=0;
      }
      pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 350), curve: Curves.easeIn);
    });
  }
}