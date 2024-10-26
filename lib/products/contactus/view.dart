import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/design/app_button.dart';
import '../../core/design/app_input.dart';
import '../../core/logic/helper_methods.dart';
import 'bloc.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final bloc = GetIt.I<ContactUsBloc>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppInput(
                  controller: bloc.nameController,
                  label: "الاسم"
                ) ,
                SizedBox(height: 16,),
                AppInput(
                  controller: bloc.phoneController,
                  label: "رقم الموبايل"
                ),SizedBox(height: 16,),
                AppInput(
                  controller: bloc.titleController,
                  label: "العنوان "
                ),SizedBox(height: 16,),
                AppInput(
                  controller: bloc.contentController,
                  isMultiLines: true,
                  label: "الموضوع"
                ),SizedBox(height: 16,),
                BlocConsumer(
                  listener: (context, state) {
                    if(state is ContactUsSuccessStates){
                      showMessage(state.msg);
                    }else if(state is ContactUsFaildStates){
                      showMessage(state.msg);
                    }
                  },
                  bloc: bloc,
                  builder: (context, state) {
                    if(state is ContactUsLoadingStates){
                      return Center(child: CircularProgressIndicator());
                    }else{
                      return AppButton(text: "ارسال",
                        onPressd: (){
                        bloc.add(SendContactUsEvent());
                      } ,);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
