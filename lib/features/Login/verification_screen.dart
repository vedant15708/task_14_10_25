import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/verification_controller.dart';
import '../../core/utils/app_constant.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/fonts.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final VerificationController controller = VerificationController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.h,
      textStyle: AppTextStyles.onboardingTitle.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 24.sp,
        color: AppColors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        shape: BoxShape.circle,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary, width: 2.w),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.primary.withOpacity(0.1),
        border: Border.all(color: AppColors.primary),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24.h),

                /// Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: AppColors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: Text(
                          'Verification Code',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.onboardingTitle.copyWith(
                            color: AppColors.primary,
                            fontSize: 26.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 48.w),
                    ],
                  ),
                ),

                SizedBox(height: 60.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    AppConstants.verificationSubTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.verificationcodedescription,
                  ),
                ),

                SizedBox(height: 40.h),
                Form(
                  key: controller.formKey,
                  child: Pinput(
                    length: 4,
                    controller: controller.pinController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    separatorBuilder: (index) => SizedBox(width: 14.w),
                    validator: (s) => s == '1234' ? null : 'Incorrect Code',
                  ),
                ),

                SizedBox(height: 55.h),

                Center(
                  child: SizedBox(
                    width: 297.w,
                    height: 52.h,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: controller.isVerifying,
                      builder: (context, verifying, _) {
                        return ElevatedButton(
                          onPressed: verifying
                              ? null
                              : () async {
                            await controller.verifyPin(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            elevation: 0,
                          ),
                          child: verifying
                              ? SizedBox(
                            height: 24.h,
                            width: 24.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            'Verify',
                            style: AppTextStyles.primaryButton.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                ValueListenableBuilder<bool>(
                  valueListenable: controller.isResending,
                  builder: (context, resending, _) {
                    return TextButton(
                      onPressed: resending
                          ? null
                          : () async {
                        await controller.resendCode(context);
                      },
                      child: resending
                          ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                          : Text(
                        'Resend Code',
                        style: AppTextStyles.verificationcodedescription.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.5,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 60.h),

                Image.asset(
                  AppConstants.logo,
                  height: 120.h,
                  fit: BoxFit.contain,
                  color: Colors.white.withOpacity(0.4),
                  colorBlendMode: BlendMode.dstATop,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
