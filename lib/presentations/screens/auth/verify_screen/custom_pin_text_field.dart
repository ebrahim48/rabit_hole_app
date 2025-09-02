import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/constants/app_colors.dart';

class CustomPinCodeTextField extends StatelessWidget {
  final TextEditingController? textEditingController;

  const CustomPinCodeTextField({super.key, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      controller: textEditingController,
      cursorColor: AppColors.textColor333333,
      textStyle: const TextStyle(color: AppColors.textColor333333),
      autoFocus: false,
      obscureText: false,
      keyboardType: TextInputType.number,

      enableActiveFill: true,

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8.r),
        fieldHeight: 52.h,
        fieldWidth: 52.w,

        // Box background
        activeFillColor: AppColors.textColorFFFFFF,
        inactiveFillColor: AppColors.textColorFFFFFF,
        selectedFillColor: AppColors.textColorFFFFFF,

        activeColor: AppColors.boxColorB59A2A,
        inactiveColor: AppColors.boxColorB59A2A,
        selectedColor: AppColors.boxColorB59A2A,
      ),

      onChanged: (value) {},
      onCompleted: (value) {
        textEditingController?.text = value;
      },
    );
  }
}
