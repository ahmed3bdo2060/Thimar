import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/design/app_image.dart';
import 'bloc.dart';



class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  final cubit = GetIt.I<CategoriesBloc>();
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if(state is CategoriesFailedState){
          return Center(
            child: Column(
              children: [
                Text(state.msg),
                SizedBox(height: 14.h,),
                IconButton(onPressed: () {
                  cubit.add(CategoriesEvent());
                }, icon: Icon(Icons.refresh))
              ],
            ),
          );
        }
        else if(state is CategoriesSuccessfulState){
        return SizedBox(
          height: 128.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("الاقسام",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                    )),
                SizedBox(height: 24.h,),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => Column(
                        children: [
                          Expanded(
                            child: AppImage(state.list[index].image,
                                fit: BoxFit.cover,
                                width: 70.w,
                                hieght: 70.h),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Text(state.list[index].name, style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp
                          ))
                        ],
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 24.w),
                      scrollDirection: Axis.horizontal,
                      itemCount:state.list.length),
                )
              ],
            ),
          ),
        );
      }else{
            return _ShimerLoading();
          }
        }
        ,);
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
      child: SizedBox(
    height: 128.h,
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("الاقسام",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp
          )),
    SizedBox(height: 24.h,),
    Expanded(
    child: ListView.separated(
    itemBuilder: (context, index) => Column(
    children: [
    Expanded(
    child: Container(
      width: 80.w,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8.r)
      ),
    )
    ),
    SizedBox(
    width: 16.w,
    ),
    SizedBox(height: 10.h,),
    Container(
      width: 60.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.r)
      ),
    )
    ],
    ),
    separatorBuilder: (context, index) => SizedBox(width: 24.w),
    scrollDirection: Axis.horizontal,
    itemCount:4),
    )
    ],
    ),
    ),
      ));

  }
}

