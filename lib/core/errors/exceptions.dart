import 'package:dio/dio.dart';

import 'error_model.dart';

class ServerException implements Exception{
  final ErrorsModel errorsModel;

  ServerException({required this.errorsModel});
}
void handleDioExceptions(DioException e){
  switch(e.type){
    case DioExceptionType.connectionTimeout:
      throw ServerException(errorsModel:ErrorsModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch(e.response!.statusCode){
        case 400:
          throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
        case 401:
          throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
        case 403:
          throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
        case 404:
          throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
        case 409:
          throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
        case 422:
          throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
        case 504:
          throw ServerException(errorsModel: ErrorsModel.fromJson(e.response!.data));
      }
  // TODO: Handle this case.
  }
}