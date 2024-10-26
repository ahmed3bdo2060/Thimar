import 'dart:io';
import 'package:app/core/logic/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../../core/design/app_button.dart';
import '../../../core/design/app_image.dart';
import '../../../core/design/app_input.dart';
import '../../../core/logic/validator.dart';
import '../componnent/have_account_or_not.dart';
import 'bloc.dart';
final formKey = GlobalKey<FormState>();

class ProductRegisterView extends StatefulWidget {
  const ProductRegisterView({super.key});

  @override
  State<ProductRegisterView> createState() => _ProductRegisterViewState();
}

class _ProductRegisterViewState extends State<ProductRegisterView> {
  final bloc = GetIt.I<RegisterBloc>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: bloc.formKey,
          child: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[
                  AppImage("assets/images/logo (1).png",
                      width:130.w,hieght: 125.h,),
                   SizedBox(height: 8.h,),
                   Text("WelcomeAgain".tr(),
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        color: AppTheme.primary
                      ) ),
                   SizedBox(height: 8.h,),
                  Text("youCanRegisterNow".tr(),
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.grey
                      )),
                   SizedBox(height: 8.h,),
                  AppInput(
                    controller: bloc.userNameController,
                    label: "userName".tr(),
                    hint: "userName".tr(),
                    prefixIcon: "assets/images/user_name.png",
                    inputType: InputType.normal,
                  ),
                  SizedBox(height: 12.h,),
                  AppInput(
                    controller: bloc.phoneController,
                    validate: InputValidator.phone,
                    keyboardType: TextInputType.phone,
                    label: "PhoneNumber".tr(),
                    hint: "PhoneNumber".tr(),
                    prefixIcon: "assets/images/phone.png",
                    inputType: InputType.phone,
                  ),
                   SizedBox(height: 8.h,),
                  AppInput(
                    controller: bloc.cityController,
                    label: "city".tr(),
                    hint: "city".tr(),
                    prefixIcon: "assets/images/city.png",
                    inputType: InputType.normal,
                  ),
                  SizedBox(height: 8.h,),
                  AppInput(
                    controller: bloc.passwordController,
                    validate: InputValidator.password,
                    prefixIcon: "assets/images/password.png",
                    label: "Password".tr(),
                    hint: "Password".tr(),
                    inputType: InputType.password,
                  ),
                  SizedBox(height: 8.h,),
                  AppInput(
                    controller: bloc.confirmPasswordController,
                    validate: InputValidator.password,
                    prefixIcon: "assets/images/password.png",
                    label: "confirmPassword".tr(),
                    hint: "confirmPassword".tr(),
                    inputType: InputType.password,
                  ),
                   SizedBox(height: 16.h,),
                  BlocBuilder(bloc: bloc,builder: (context, state) {
                      return AppButton(text: "Register".tr(),isLoading: state is RegisterLoadingState,
                          onPressd: (){
                            bloc.add(SendRegisterEvent());
                          });

                  },),
                  HaveAccountOrNot(fromRegister: true,)
                ]),
          ),
        ),
      ),
    );
  }
}
