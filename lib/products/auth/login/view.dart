import 'dart:io';
import 'package:app/core/design/app_button.dart';
import 'package:app/core/design/app_image.dart';
import 'package:app/core/design/app_input.dart';
import 'package:app/core/logic/app_theme.dart';
import 'package:app/core/logic/helper_methods.dart';
import 'package:app/core/logic/validator.dart';
import 'package:app/home/pages/home/products.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../componnent/have_account_or_not.dart';
import 'bloc.dart';
final formKey = GlobalKey<FormState>();

class ProductLoginView extends StatefulWidget {
  const ProductLoginView({super.key});

  @override
  State<ProductLoginView> createState() => _ProductLoginViewState();
}

class _ProductLoginViewState extends State<ProductLoginView> {
  final bloc = GetIt.I<LoginBloc>();
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
                   Text("WelcomeAgain".tr(),
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        color: AppTheme.primary
                      ) ),
                   SizedBox(height: 8.h,),
                  Text("youCanSignInNow".tr(),
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.grey
                      )),
                   SizedBox(height: 24.h,),
                  AppInput(
                    controller: bloc.phoneController,
                    validate: InputValidator.phone,
                    keyboardType: TextInputType.phone,
                    label: "PhoneNumber".tr(),
                    hint: "PhoneNumber".tr(),
                    prefixIcon: "assets/images/phone.png",
                    inputType: InputType.phone,
                  ),
                   SizedBox(height: 16.h,),
                  AppInput(
                    controller: bloc.passwordController,
                    validate: InputValidator.password,
                    prefixIcon: "assets/images/password.png",
                    label: "Password".tr(),
                    hint: "Password".tr(),
                    inputType: InputType.password,
                  ),
                   SizedBox(height: 15.h,),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(onPressed: (){
                    }, child:
                    Text("ForgetPassword".tr(),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp
                      ),
                    )),
                  ),
                   SizedBox(height: 16.h,),
                  BlocBuilder(bloc: bloc,builder: (context, state) {
                      return AppButton(text: "logIn".tr(),isLoading: state is LoginLoadingState,
                          onPressd: (){
                            bloc.add(SendLoginEvent());
                            navigateTo(ProductsView());
                          });

                  },),
                  HaveAccountOrNot()
                ]),
          ),
        ),
      ),
    );
  }
}
