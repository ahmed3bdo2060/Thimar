import 'package:app/core/design/app_failed.dart';
import 'package:app/core/design/app_image.dart';
import 'package:app/core/design/app_loading.dart';
import 'package:app/core/logic/app_theme.dart';
import 'package:app/core/logic/helper_methods.dart';
import 'package:app/home/pages/notifications/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
part 'componnent/item2.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final bloc = GetIt.I<GetNotificationsBloc>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
      centerTitle:  true,
      title: Text("الاشعارات",style: TextStyle(color: AppTheme.primary)),
    )
        ,body: BlocBuilder(bloc: bloc,builder: (context, state) {
          if(state is GetNotificationsFailedState){
            return AppFailed(msg: state.msg, onPress: () {

            },);
          }else if(state is GetNotificationsSuccessState){
           return ListView.separated(padding: EdgeInsets.symmetric(horizontal: 16.w),
               itemBuilder: (context, index) => _Item(index: index, model: state.list[index],),
                separatorBuilder: (context, index) => SizedBox(height: 16.sp),
                itemCount: state.list.length);
          }else{
            return AppLoading();
          }
        },)
    );
  }
}
