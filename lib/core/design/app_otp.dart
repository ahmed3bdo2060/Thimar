import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppOtp extends StatelessWidget {
  const AppOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      keyboardType: TextInputType.number,
      cursorColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.transparent,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          fieldHeight: 60,
          fieldWidth: 60,
          borderRadius: BorderRadius.circular(8),
          activeColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).primaryColor.withOpacity(.29)
      ),
    );
  }
}
