import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/constants/app_colors.dart';

class CustomPinCodeTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;

  const CustomPinCodeTextField({super.key, this.textEditingController, this.onChanged});

  @override
  State<CustomPinCodeTextField> createState() => _CustomPinCodeTextFieldState();
}

class _CustomPinCodeTextFieldState extends State<CustomPinCodeTextField> {
  late TextEditingController _internalController;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create a new one
    _internalController = widget.textEditingController ?? TextEditingController();
  }

  @override
  void dispose() {
    _isDisposed = true;
    // Don't dispose the external controller, only dispose if it's internal
    if (widget.textEditingController == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      controller: _internalController,
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

      onChanged: (value) {
        // Sync the internal controller value to the external controller if provided
        if (widget.textEditingController != null && !_isDisposed && mounted) {
          try {
            widget.textEditingController!.text = value;
          } catch (e) {
            // Controller might be disposed, ignore
          }
        }
        // Call the onChanged callback if provided
        if (widget.onChanged != null && !_isDisposed && mounted) {
          try {
            widget.onChanged!(value);
          } catch (e) {
            // Widget might be disposed, ignore
          }
        }
      },
      onCompleted: (value) {
        // Only update if not disposed
        if (!_isDisposed && mounted && widget.textEditingController != null) {
          try {
            widget.textEditingController!.text = value;
          } catch (e) {
            // Controller might be disposed, ignore
          }
        }
        // Call the onChanged callback if provided (since onCompleted is also a change)
        if (widget.onChanged != null && !_isDisposed && mounted) {
          try {
            widget.onChanged!(value);
          } catch (e) {
            // Widget might be disposed, ignore
          }
        }
      },
    );
  }
}
