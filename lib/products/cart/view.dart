import 'package:app/products/cart/update_cart/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../core/design/app_image.dart';
import 'bloc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final bloc = GetIt.I<CartBloc>();
  final updateBloc = GetIt.I<UpdateCartBloc>();
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(items: [
            DropdownMenuItem(child: Text("EN"),value: "en",),
            DropdownMenuItem(child: Text("AR"),value: "ar",),
            DropdownMenuItem(child: Text("FR"),value: "fr",)
          ],value: selectedValue, onChanged: (value) {
            selectedValue = value;
            setState(() {});
            context.setLocale(Locale(selectedValue!));
          },icon: Icon(Icons.language),)
        ],
        title: Center(child: Text("cart").tr()),
        backgroundColor: Colors.green,
      ),
      body:BlocBuilder(bloc:bloc ,builder: (context, state) {
         if(state is CartFailedState){
           return Center(child: Text(state.msg));
         }else if(state is CartSuccessState){
           return Column(
             children: [
               Expanded(child:  Container(
                 child: ListView.separated(padding: EdgeInsets.all(16),
                     itemBuilder: (context, index) =>_Item(model: state.model.list[index]
                       ,onUpdate: () {
                         setState(() {

                         });
                       }, onDeletePressed: () {
                       state.model.list.removeAt(index);
                       setState(() {

                       });
                     }, bloc: updateBloc,) ,
                     separatorBuilder:  (context, index) =>SizedBox(height: 16.h)
                     , itemCount: state.model.list.length),
               )),
               SizedBox(height: 16.h,),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 16.h),
                 height: 300,
                 width: double.infinity,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Expanded(
                           child: TextFormField(
                             decoration: InputDecoration(
                               enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(style: BorderStyle.solid,width: 2,color: Colors.green),
                                 borderRadius: BorderRadius.circular(8.r),
                               ),
                             ),
                           ),
                         ),
                         SizedBox(width: 16.w,),
                         FilledButton(onPressed: () {

                         }, child: Text("تطبيق"),
                           style:FilledButton.styleFrom(
                             backgroundColor: Colors.green,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             fixedSize: Size(120.w, 60.h)
                           ) ,),
                       ],
                     ),SizedBox(height: 8.h,),
                     Align(
                       alignment: AlignmentDirectional.center,
                       child: Text("جميع الاسعار تشمل قيمة الضريبة المضافة ${state.model.vat}%",
                         style: TextStyle(
                             color: Colors.green,
                             fontSize: 16.sp,
                             fontWeight: FontWeight.bold
                         ),),
                     ),
                     SizedBox(height: 8.h,),
                     Container(
                       padding: EdgeInsets.all(8),

                       decoration: BoxDecoration(
                           color: Colors.green.withOpacity(.2),
                         borderRadius:  BorderRadius.circular(8.r)
                       ),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("اجمالى سعر المنتجات قبل الخصم",style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 16.sp,
                                 color: Colors.green
                               )),
                               Text("${state.model.totalBeforeDiscount}ر.س",style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16.sp,
                                 color: Colors.green
                               ))
                             ],
                           ),
                           SizedBox(height: 8.h,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("اجمالى الخصم",style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16.sp,
                                   color: Colors.green
                               )),
                               Text("${state.model.totalDiscountCart}ر.س",style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16.sp,
                                   color: Colors.green
                               ))
                             ],
                           ),Divider(
                             color: Colors.white,
                             thickness: 3,
                           ),
                           SizedBox(height: 4.h,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("اجمالى سعر المنتجات بعد الخصم",style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16.sp,
                                   color: Colors.green
                               )),
                               Text("${state.model.totalAfterDiscount}ر.س",style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16.sp,
                                   color: Colors.green
                               ))
                             ],
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 8.h,),
                     FilledButton(onPressed: () {

                     }, child: Text("الانتقال لاتمام الطلب"),
                       style: FilledButton.styleFrom(
                         backgroundColor: Colors.green
                       ),)
                   ],
                 ),
               ),
             ],
           );
         }else {
           return Center(child: CircularProgressIndicator(),);
         }
      },) ,
    );
  }
}class _Item extends StatefulWidget {
  final ProductModel model;
  final VoidCallback onDeletePressed,onUpdate;
  final UpdateCartBloc bloc;
  const _Item({super.key, required this.model, required this.onDeletePressed, required this.onUpdate, required this.bloc});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      ClipRRect(borderRadius: BorderRadius.circular(16.r),
        child: AppImage(
          widget.model.image,
          fit: BoxFit.cover,
          width: 70.w,
          hieght: 70.w,),
      ),
        SizedBox(width: 16.w,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.model.title,
              style: TextStyle(
                color: Colors.green,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold
              )),
              SizedBox(height: 8.h,),
              Row(children: [
                Text("${widget.model.priceBeforeDiscount}ر.س",
                    style:  TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.lineThrough
                    )),
                SizedBox(width: 16.w,),
                Text("${widget.model.price}ر.س",
                  style:TextStyle(
                    color: Colors.green
                  ) ,)
              ],),
              SizedBox(height: 8.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Colors.green.withOpacity(.25)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocListener(
                      bloc: widget.bloc,
                       listener: (context, state) {

                       },
                      child: BlocListener(
                        bloc: widget.bloc,
                        listener: (context, state) {
                         if(state is UpdateCartItemSuccessState&&state.id==widget.model.id&&state.isAdd==true){
                           widget.model.plus();
                           setState(() {});
                           widget.onUpdate();
                         }
                        },
                        child: GestureDetector(
                          onTap: () {
                           widget.bloc.add(UpdateCartItemEvent(id: widget.model.id,
                               amount:widget.model.amount, isAdd: true));
                          },
                          child: Container(decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r)
                          ),child: Icon(Icons.add, size: 16,)),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    Text("${widget.model.amount}",style: TextStyle(
                       color: Colors.green
                    )),
                    SizedBox(width: 8.w,),
                    BlocListener(
                      bloc: widget.bloc,
                      listener: (context, state) {
                        if(state is UpdateCartItemSuccessState&&state.id==widget.model.id&&state.isAdd==false){
                          widget.model.minus();
                          setState(() {});
                          widget.onUpdate();
                        }
                      },
                      child: GestureDetector(onTap: () {
                        widget.bloc.add(UpdateCartItemEvent(id: widget.model.id,
                            amount: widget.model.amount, isAdd: false));
                      },
                        child: Container(decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r)
                        ),child: Icon(Icons.remove,size: 16,)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        IconButton(onPressed: widget.onDeletePressed, icon: Icon(Icons.delete,color: Colors.red,))
      ],
    );
  }
}

