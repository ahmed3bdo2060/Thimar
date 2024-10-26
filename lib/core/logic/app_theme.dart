import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';

class AppTheme{
  static const primary = Color(0xff4C8613);
  static const grey = Color(0xff707070);
  static const border = Color(0xffF3F3F3);
  static ThemeData get light=> ThemeData(fontFamily: "Tajwal",
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle:  TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp
            )
        )
    ),
    switchTheme: SwitchThemeData(
       trackColor: MaterialStateProperty.resolveWith((states) {
         if(!states.contains(MaterialState.selected)){
           return Color(0xffC0C0C0);
         }else{
           return primary;
         }
       })
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700
      )
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
            textStyle:  TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            fixedSize:  Size.fromHeight(60.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)
            ),disabledBackgroundColor: primary.withOpacity(.25)
        )
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: grey,fontSize: 16.sp
      ),
        labelStyle: TextStyle(
            color: grey,fontSize: 16.sp
        ),
        floatingLabelStyle: TextStyle(
          fontSize: 18.sp,
          color: primary,
          fontWeight: FontWeight.w700
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: border
          )
        ),border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(
            color: border
        )
    )
    ),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: const MaterialColor(
            0xff4C8613,
            {
              50:primary,
              100:primary,
              200:primary,
              300:primary,
              400:primary,
              500:primary,
              600:primary,
              700:primary,
              800:primary,
              900:primary,
            }
        ),
        backgroundColor: Colors.white
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:  primary,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.3),
      type: BottomNavigationBarType.fixed
    )
  );
}