import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.text, required this.onPressd,  this.isLoading=false});
final String text;
final bool isLoading;
final VoidCallback onPressd;
  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return FilledButton.icon(onPressed:null,
        icon:SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(strokeWidth: 2,)),
        label: Text(text),
      );
    }
    return FilledButton(onPressed: onPressd,
      child: Text(text,
        selectionColor: Colors.white,
    ),
    ) ;
  }
}
