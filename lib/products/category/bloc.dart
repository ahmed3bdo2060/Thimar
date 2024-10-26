import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/errors/exceptions.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/end_point.dart';
part 'states.dart';
part 'model.dart';
part 'events.dart';
class CategoriesBloc extends Bloc<CategoriesEvents,CategoriesStates>{
  // late List<CategoryModel> list;
  // late CustomResponse response;
  CategoriesBloc(this._dio) : super(CategoriesLoadingState()){
    on<CategoriesEvent>(_getData);
  }
  final DioHelper _dio;

  Future<void> _getData(CategoriesEvent event, Emitter<CategoriesStates> emit)async {
    try {
      emit(CategoriesLoadingState());
      final response = await _dio.get(EndPoint.categories);
      final list = CategoryData.fromJson(response.data).list;
      emit(CategoriesSuccessfulState(list: list));
    }on ServerException catch(e){
      emit(CategoriesFailedState(msg: e.errorsModel.errorMessage));
    }
  }
}