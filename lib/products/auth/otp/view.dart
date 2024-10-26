import 'dart:io';
import 'package:app/core/design/app_button.dart';
import 'package:app/core/design/app_image.dart';
import 'package:app/core/design/app_input.dart';
import 'package:app/core/logic/app_theme.dart';
import 'package:app/core/logic/helper_methods.dart';
import 'package:app/core/logic/validator.dart';
import 'package:app/home/pages/home/products.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart'as mat;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../componnent/have_account_or_not.dart';
import 'bloc.dart';
final formKey = GlobalKey<FormState>();

class OTPView extends StatefulWidget {
  final String phone;
  const OTPView({super.key, required this.phone});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final bloc = GetIt.I<OTPBloc>();
  bool isTimerFinished = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: bloc.formKey,
          child: SingleChildScrollView(
            padding:  EdgeInsets.all(16.r),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[
                  AppImage("assets/images/logo (1).png",
                      width:130.w,hieght: 125.h,),
                   SizedBox(height: 16.h,),
                   Text("activateAccount".tr(),
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        color: AppTheme.primary
                      ) ),
                   SizedBox(height: 8.h,),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: "أدخل الكود المكون من 4 أرقام المرسل علي رقم الجوال", style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.grey
                    )),
                    WidgetSpan(child:Text ("+${widget.phone}",textDirection:mat.TextDirection.ltr, style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.grey
                    ))),
                    TextSpan(text: "\t"),
                    TextSpan(text: "تغيير رقم الجوال",style: TextStyle(
                      fontWeight: FontWeight.w600,fontSize: 16,color: AppTheme.primary,
                      decoration: TextDecoration.underline
                    ),recognizer: TapGestureRecognizer()..onTap=(){
                      Navigator.pop(context);
                    }),
                  ],
                  ),
                     ),
                   SizedBox(height: 16.h,),
                   PinCodeTextField(appContext:   context, keyboardType: TextInputType.number,
                       length: 4,
                       controller: bloc.codeController,pinTheme: PinTheme(
                     fieldHeight: 60.h,
                     fieldWidth: 70.w,
                     shape: PinCodeFieldShape.box,
                     borderRadius: BorderRadius.circular(16.r),
                     activeColor: AppTheme.primary,
                     inactiveColor: AppTheme.border,
                     selectedColor: AppTheme.primary
                   )),
                   SizedBox(height: 16.h,),
                  BlocBuilder(bloc: bloc,builder: (context, state) {
                      return AppButton(text: "verify".tr(),isLoading: state is OTPLoadingState,
                          onPressd: (){
                            bloc.add(SendOTPEvent(phone: widget.phone));
                            navigateTo(ProductsView());
                          });

                  },),
                  SizedBox(height: 16.h,),
                  Text("لم تستلم الكود ؟\nيمكنك إعادة إرسال الكود بعد",
                  style: TextStyle(
                    color: AppTheme.grey
                  ),
                  textAlign: TextAlign.center),
                  SizedBox(height: 16.h,),
                  if(!isTimerFinished)
                  CircularCountDownTimer(
                    width: 70.w,
                     height: 70.h,
                    duration: 10,
                    onComplete: () {
                      isTimerFinished = true;
                      setState(() {

                      });
                    },
                    textFormat: CountdownTextFormat.MM_SS,
                    isReverse: true,
                    fillColor: AppTheme.border,
                    ringColor: AppTheme.primary,
                  ),
                  SizedBox(height: 16.h,),
                  Center(
                    child: OutlinedButton(onPressed:isTimerFinished? () {
                    isTimerFinished = false;
                    setState(() {

                    });
                    }:null,style: OutlinedButton.styleFrom(
                       side: isTimerFinished?BorderSide(color: AppTheme.primary):null
                    ), child: Text("اعادة الارسال")),
                  ),
                  HaveAccountOrNot(fromRegister: true,)
                ]),
          ),
        ),
      ),
    );
  }
}
