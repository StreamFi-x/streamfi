import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:streamfi/core/themes/color_scheme.dart';
import 'package:streamfi/core/constants/assets.dart';

class VerificationSuccessDialog extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onGoToDashboard;

  const VerificationSuccessDialog({
    Key? key,
    required this.onContinue,
    required this.onGoToDashboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isTablet ? 0 : 16.w),
      child: Container(
        width: isTablet ? 460 : 293.w,
        decoration: BoxDecoration(
          color: AppColors.dialogBackground,
          borderRadius: BorderRadius.circular(isTablet ? 24 : 16.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 32 : 16.w,
          vertical: isTablet ? 32 : 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            SvgPicture.asset(
              AppAssets.checkIcon,
              width: isTablet ? 80 : 48.w,
              height: isTablet ? 80 : 48.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFF9147FF),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: isTablet ? 32 : 16.h),
            
            // Success Title
            Text(
              'Verification Successful!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: isTablet ? 28 : 20.sp,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            SizedBox(height: isTablet ? 20 : 12.h),
            
            // Success Message
            Text(
              isTablet 
                ? 'Your account has been successfully verified. Welcome to StreamFi'
                : 'Your account has been\nsuccessfully verified. Welcome to\nStreamFi',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.descriptionText,
                fontSize: isTablet ? 18 : 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            SizedBox(height: isTablet ? 40 : 24.h),
            
            // Continue Button
            SizedBox(
              width: double.infinity,
              height: isTablet ? 56 : 48.h,
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9147FF),
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: isTablet ? 20 : 12.h),
            
            // Go to Dashboard Button
            SizedBox(
              width: double.infinity,
              height: isTablet ? 56 : 48.h,
              child: ElevatedButton(
                onPressed: onGoToDashboard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF383838),
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 