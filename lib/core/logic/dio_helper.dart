import 'package:dio/dio.dart';
import 'package:quick_log/quick_log.dart';
import 'cash_helper.dart';

class NetworkException implements Exception{}
class LoginException implements Exception{
  final String message;

  LoginException(this.message);
}
class DioHelper{
  DioHelper(){
    _dio.interceptors.add(AppInterceptor());
  }

   final _dio = Dio(BaseOptions(baseUrl: "https://thimar.amr.aait-d.com/api/",
       headers: {
     "Accept":"application/json",
   }));
 Future<CustomResponse> get(String path,
       {Map<String, dynamic>? queryParameters}) async {

     try {
       if(path.isEmpty){
         await Future.delayed(Duration(seconds: 2));
         return CustomResponse(isSuccess: true);
       }else{
         final response = await _dio.get(
           path,
           queryParameters: queryParameters,
         );

         return CustomResponse(
           isSuccess: true,
           data: response.data,
           msg: response.data["message"],
         );
       }

     } on DioException catch (ex) {
       return _handleException(ex);
     }
   }

  //  Future<CustomResponse> get (String path)async {
  //   try {
  //     final response = await _dio.get(path);
  //     return CustomResponse(isSuccess:true,data: response.data);
  //   }
  //   on DioException catch(ex){
  //     return _handleException(ex);
  //   }
  // }

   Future <CustomResponse> send(String path,{Map<String,dynamic>? data})async {
    try {
      if(path.isEmpty){
        await Future.delayed(Duration(seconds: 2));
        return CustomResponse(isSuccess: true);
      }else{
        final response = await _dio.post(path,data: data);
        return CustomResponse(isSuccess:true,data: response.data,msg: response.data["message"]);
      }

    }
    on DioException catch(ex){
      return _handleException(ex);
    }
  }
  CustomResponse _handleException(DioException ex) {
     return CustomResponse(
       isSuccess: false,
       msg: ex.response?.data["message"],
     );
   }
  //  CustomResponse handleExeption(DioException ex){
  //   print(ex.response?.data);
  //   String? msg = ex.response?.data["message"];
  //   return CustomResponse(isSuccess: false,message: msg ?? ex.type.name);
  //
  // }
}
class CustomResponse {
  final bool isSuccess;
  final data;
  String? msg;

  CustomResponse({required this.isSuccess, this.data, this.msg}){
    msg = msg??data?["message"]??"Failed Try Agin Later";
  }
}
class AppInterceptor extends Interceptor{

  final log = Logger('');
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    log.fine("OnRequest");
    log.info("(${options.method})${options.baseUrl}${options.path}");
    log.fine("Data");
    log.fine(options.data);
    log.fine("QuaryParameters");
    log.fine(options.queryParameters);
    options.headers.addAll({"Authorization":"Bearer ${CashHelper.token}"});
    log.fine("*"*30);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    log.error("OnError");
    log.error(err.response?.data??err.message);
    log.error("*"*30);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    log.fine("OnResponse");
    log.fine(response.data);
    log.fine("*"*30);
  }
}