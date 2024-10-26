
import 'package:app/home/pages/notifications/bloc.dart';
import 'package:app/products/cart/add_to_cart/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/logic/dio_consumer.dart';
import 'core/logic/dio_helper.dart';
import 'products/auth/login/bloc.dart';
import 'products/auth/otp/bloc.dart';
import 'products/auth/register/bloc.dart';
import 'products/cart/bloc.dart';
import 'products/cart/update_cart/bloc.dart';
import 'products/category/bloc.dart';
import 'products/contactus/bloc.dart';
import 'products/product/bloc.dart';
import 'products/slider/bloc.dart';

void initServiceLocator(){
  final container = GetIt.instance;
  container.registerSingleton(DioHelper());
  container.registerFactory(() => SliderBloc(container<DioHelper>())..add(SliderEvent())..add(SliderTimerEvent()));
  container.registerFactory(() => LoginBloc(container<DioHelper>()));
  container.registerFactory(() => AddToCartBloc(GetIt.instance<DioHelper>()));
  container.registerFactory(() => OTPBloc(container<DioHelper>()));
  container.registerFactory(() => RegisterBloc(container<DioHelper>()));
  container.registerFactory(() => CategoriesBloc(container<DioHelper>())..add(CategoriesEvent()));
  container.registerFactory(() => ProductBloc(container<DioHelper>())..add(ProductEvent()));
  container.registerFactory(() => ContactUsBloc(container<DioHelper>()));
  container.registerFactory(() => UpdateCartBloc(container<DioHelper>()));
  container.registerFactory(() => CartBloc(container<DioHelper>())..add(GetCartEvent()));
  container.registerFactory(() => GetNotificationsBloc(container<DioHelper>())..add(GetNotificationsEvent()));
}