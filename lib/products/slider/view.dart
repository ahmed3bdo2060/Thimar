import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/design/app_image.dart';
import 'bloc.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  final cubit = GetIt.I<SliderBloc>();
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if(state is SliderLoadingState){
          return _ShimerLoading();
        }else{
          return cubit.response.isSuccess?Container(
            height: 232.h,
            child: Column(
                children: [ Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r)
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 16.h),
                    child: BlocBuilder(
                      bloc: cubit,
                      builder: (context, state) => PageView.builder(itemBuilder: (context, index) => AppImage(cubit.model.list[index].image,fit: BoxFit.cover,width: double.infinity),
                          scrollDirection: Axis.horizontal,itemCount: cubit.model.list.length,
                          onPageChanged:(value) => cubit.onchange(value),controller: cubit.pageController),
                    ),),
                ),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) =>
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: index!=4?8:0),
                          child: CircleAvatar(radius: 6.r,
                            backgroundColor: Color(0xff16A124).withOpacity(index==cubit.currentIndex?1:.10),),
                        )),
                  )
                ]),
          ): Center(
            child: Column(
              children: [
                Text(cubit.response.msg!),
                SizedBox(height: 14.h,),
                IconButton(onPressed: () {
                  cubit.response.isSuccess;
                  cubit.add(SliderEvent());
                }, icon: Icon(Icons.refresh))
              ],
            ),
          );
        }
      },);
  }
}
class _ShimerLoading extends StatelessWidget {
  const _ShimerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.green.withOpacity(.2),
      highlightColor: Colors.white,
      period: Duration(seconds: 2),
      child: Container(
        height: 232.h,
        child: Column(
            children: [ Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r)
                ),
                margin: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 16.h),
                child: PageView.builder(itemBuilder: (context, index) => AppImage("",fit: BoxFit.cover,width: double.infinity.w),
                    scrollDirection: Axis.horizontal,itemCount: 4,
                ),),
            ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) =>
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: index!=4?8:0),
                      child: CircleAvatar(radius: 6.r,
                        backgroundColor: Colors.grey,),
                    )),
              )
            ]),
      ),
    );
  }
}
