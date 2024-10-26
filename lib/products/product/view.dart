import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

import '../cart/add_to_cart/bloc.dart';
import 'bloc.dart';
import 'model.dart';
part 'item_product.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key});

  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  final bloc = GetIt.I<ProductBloc>();
  final addToCartBloc = GetIt.I<AddToCartBloc>();
  Widget build(BuildContext context) {
    return BlocBuilder(bloc: bloc, builder: (context, state) {
      if (state is ProductFailedState) {
        return Center(
          child: Column(
            children: [
              Text(state.msg),
              const SizedBox(height: 14,),
              IconButton(onPressed: () {
                state.msg;
                bloc.add(ProductEvent());
              }, icon: const Icon(Icons.refresh))
            ],
          ),
        );
      } else if(state is ProductSuccessfulState) {
        return Column(
          children:[
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text("الاصناف",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp
                    )),
              ),
            ),
            SizedBox(height: 24.h,),
            GridView.builder(physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  childAspectRatio: 189 / 300
              ),
              itemCount: state.model.list.length,
              itemBuilder: (context, index) =>
                  _Item(model: state.model.list[index], addToCartBloc: addToCartBloc,),)],
        );
      }else {
        return _ShimerLoading();

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
        child: GridView.builder(physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    padding: EdgeInsets.all(16),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 16,
    crossAxisSpacing: 20,
    childAspectRatio: 189 / 300
    ),
    itemCount: 4,
    itemBuilder: (context, index) =>
    Container(
    decoration: BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.circular(9)
    ),
    )));

  }
}
