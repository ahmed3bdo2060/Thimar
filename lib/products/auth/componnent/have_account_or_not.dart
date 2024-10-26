import 'package:app/core/logic/helper_methods.dart';
import 'package:app/products/auth/login/view.dart';
import 'package:app/products/auth/register/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HaveAccountOrNot extends StatelessWidget {
  final bool fromRegister;
  const HaveAccountOrNot({super.key,this.fromRegister=false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(fromRegister?"haveAnAccount".tr():"don’tHaveAnAccount".tr(),
              style: TextStyle(
                  color:  Theme.of(context).primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold
              ),
            ),
            TextButton(onPressed: (){
              if(fromRegister){
                navigateTo(ProductLoginView());
              }else{
                navigateTo(ProductRegisterView());
              }
            }, child:  Text(fromRegister?"logIn".tr():"signUp".tr(),
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold
              ),
            ))
          ],
        )
      ],
    );
  }
}
