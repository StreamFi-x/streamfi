import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:streamfi/core/constants/app_texts.dart';
import 'package:streamfi/core/themes/color_scheme.dart';
import 'package:streamfi/core/shared/dialogs/verification_success_dialog.dart';

class EmailVerificationDialog extends StatefulWidget {
  final String email;
  final Function(String) onVerify;
  final VoidCallback onResend;

  const EmailVerificationDialog({
    Key? key,
    required this.email,
    required this.onVerify,
    required this.onResend,
  }) : super(key: key);

  @override
  State<EmailVerificationDialog> createState() => _EmailVerificationDialogState();
}

class _EmailVerificationDialogState extends State<EmailVerificationDialog> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isTablet ? 0 : 16.w),
      child: Container(
        width: isTablet ? 406 : 293.w,
        decoration: BoxDecoration(
          color: AppColors.dialogBackground,
          borderRadius: BorderRadius.circular(isTablet ? 24 : 24.r),
        ),
        padding: EdgeInsets.all(isTablet ? 24 : 20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              isTablet ? AppTexts.verificationTitle : AppTexts.verificationTitleMobile,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: isTablet ? 24 : 24.sp,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            SizedBox(height: isTablet ? 24 : 10.h),
            
            // Instruction text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: AppColors.instructionTextGrey,
                  fontSize: isTablet ? 16 : 16.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: 0,
                ),
                children: [
                  TextSpan(text: AppTexts.verificationInstruction),
                  TextSpan(
                    text: widget.email,
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      fontSize: isTablet ? 16 : 16.sp,
                    ),
                  ),
                  TextSpan(text: AppTexts.verificationValidity),
                ],
              ),
            ),
            SizedBox(height: isTablet ? 24 : 32.h),
            
            // Pin Fields Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 8 : 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => _buildPinField(index),
                ),
              ),
            ),
            SizedBox(height: isTablet ? 24 : 40.h),
            
            // Verify button
            SizedBox(
              width: double.infinity,
              height: isTablet ? 50 : 50.h,
              child: ElevatedButton(
                onPressed: _verifyCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.verifyButtonPurple,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isTablet ? 8 : 8.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  AppTexts.verifyButton,
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: isTablet ? 24 : 16.h),
            
            // Resend code text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTexts.resendText,
                  style: TextStyle(
                    color: AppColors.instructionTextGrey,
                    fontSize: isTablet ? 14 : 14.sp,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onResend,
                  child: Text(
                    AppTexts.resendButton,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: isTablet ? 14 : 14.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.white,
                      decorationThickness: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinField(int index) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    
    return Container(
      width: isTablet ? 40 : 32.w,
      height: isTablet ? 40 : 32.w,
      decoration: BoxDecoration(
        color: AppColors.pinBoxBackground,
        borderRadius: BorderRadius.circular(isTablet ? 8 : 8.r),
        border: Border.all(
          color: focusNodes[index].hasFocus 
              ? AppColors.pinBoxBorderPurple
              : Colors.transparent,
          width: isTablet ? 1 : 1.w,
        ),
      ),
      child: Center(
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {});
          },
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 5) {
                  focusNodes[index + 1].requestFocus();
                } else {
                  focusNodes[index].unfocus();
                  _verifyCode();
                }
              }
            },
            showCursor: false,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
              hintText: focusNodes[index].hasFocus ? '-' : '',
              hintStyle: TextStyle(
                color: AppColors.white,
                fontSize: isTablet ? 16 : 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: TextStyle(
              color: AppColors.white,
              fontSize: isTablet ? 16 : 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _verifyCode() {
    final code = controllers.map((controller) => controller.text).join();
    if (code.length == 6) {
      widget.onVerify(code);
      // Close the current dialog
      Navigator.of(context).pop();
      
      // Show the success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => VerificationSuccessDialog(
          onContinue: () {
            Navigator.of(context).pop();
          },
          onGoToDashboard: () {
            Navigator.of(context).pop();
            // TODO: Navigate to dashboard
          },
        ),
      );
    }
  }
} 