
part of '../view.dart';

class _Item extends StatefulWidget {
  final int index;
  final NotificationModel model;
  const _Item({super.key, required this.index, required this.model});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        widget.model.isRead = true;
        setState(() {

        });
      },
      child: Dismissible(
        key: ValueKey("${widget.index}"),
        onDismissed: (direction) {
          showMessage("deleted",messageType: MessageType.Success);
        },
        background: Container(
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Icon(Icons.delete,color: Colors.white),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        direction: DismissDirection.startToEnd,
        child: Container(
           padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
           width: double.infinity,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImage(widget.model.img,width: 33.w,hieght: 33.w,),
                SizedBox(width: 5.w,),
                VerticalDivider(
                  color: Colors.grey.withOpacity(.5),
                ),
                SizedBox(width: 5.w,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.model.title,style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp
                    ),),
                    SizedBox(height: 6.h,),
                    Text(widget.model.body,style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      color: Color(0xff989898)
                    ),),
                    SizedBox(height: 6.h,),
                    Text(widget.model.time,style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp
                    ),)
                  ],
                )),
                SizedBox(width: 5.w,),
                if(!widget.model.isRead)
                  CircleAvatar(
                    radius:  4.r,
                    backgroundColor: AppTheme.primary,
                  )
              ]
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.1),
              blurRadius: 10,
              offset: Offset(0, 5))
            ]
          ),
        ),
      ),
    );
  }
}
