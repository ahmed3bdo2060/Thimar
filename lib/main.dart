import 'package:app/core/logic/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/logic/bloc-observer.dart';
import 'core/logic/cash_helper.dart';
import 'core/logic/helper_methods.dart';
import 'home/pages/view.dart';
import 'products/auth/login/view.dart';
import 'products/auth/otp/view.dart';
import 'products/auth/register/view.dart';
import 'home/pages/home/products.dart';
import 'service_locator.dart';

Future <void> main()async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefss =await SharedPreferences.getInstance();
  await CashHelper.init();
  await EasyLocalization.ensureInitialized();
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: "assets/translation",

      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      fallbackLocale: Locale("ar"),
      startLocale: Locale("ar"),
      child: ScreenUtilInit(
        designSize: Size(375,812),
        child:  ProductRegisterView(),
            // phone: "0125459687984"),
        builder: (context, child) => MaterialApp(
            navigatorKey: navigatorKey,
            theme: AppTheme.light,
            debugShowCheckedModeBanner: false,
            title: "Thimar",
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home:child
        ),
      ),
    );
  }
}
