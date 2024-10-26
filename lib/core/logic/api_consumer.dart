abstract class ApiConsumer{
  Future<dynamic>get(
      String path,{
        Object? data,
        Map<String,dynamic>?queryParameters
  });
  post( String path,{
    Object? data,
    Map<String,dynamic>?queryParameters,
    bool isFormData = true
  });
  delete( String path,{
    Object? data,
    Map<String,dynamic>?queryParameters,
    bool isFormData = true
  });
  patch( String path,{
    Object? data,
    Map<String,dynamic>?queryParameters,
    bool isFormData = true
  });
}