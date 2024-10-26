import 'package:app/core/logic/helper_methods.dart';
import 'package:app/products/cart/view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../products/category/view.dart';
import '../../../products/product/view.dart';
import '../../../products/slider/view.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: () => navigateTo(CartView()),
              icon: Icon(Icons.shopping_cart_rounded,
            color: Colors.white,))],
          backgroundColor: Color(0xff16A124),
          centerTitle:true,
          title: Text("منتجاتنا",style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700
          )),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              SliderSection(),
              SizedBox(height: 16.h,),
              CategorySection(),
              SizedBox(height: 16.h,),
              ProductSection()
            ],
          ),
        ),
      ),
    );
  }
}
