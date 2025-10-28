import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_constant.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/fonts.dart';
import '../Login/verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<String?> _errorText = ValueNotifier(null);

  @override
  void dispose() {
    _phoneController.dispose();
    _isLoading.dispose();
    _errorText.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    final value = _phoneController.text.trim();
    if (value.isEmpty) {
      _errorText.value = 'Please enter your phone number';
      return;
    }
    if (value.length != 10) {
      _errorText.value = 'Phone number must be 10 digits';
      return;
    }

    _errorText.value = null;
    _isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    _isLoading.value = false;
    _phoneController.clear();

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const VerificationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 39.w,
            right: 39.w,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              SizedBox(height: 151.h),

              /// Logo
              Image.asset(
                AppConstants.logo,
                height: 220.h,
                width: 220.w,
              ),

              SizedBox(height: 24.h),

              /// Phone Number Field
              ValueListenableBuilder<String?>(
                valueListenable: _errorText,
                builder: (context, errorText, _) {
                  return SizedBox(
                    width: 297.w,
                    height: 75.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 46.h,
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.black,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onChanged: (value) {
                              if (value.length == 10) {
                                _errorText.value = null;
                              } else if (value.isEmpty) {
                                _errorText.value =
                                'Please enter your phone number';
                              } else {
                                _errorText.value =
                                'Phone number must be 10 digits';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.textGrey,
                              ),
                              prefixIcon: Padding(
                                padding:
                                EdgeInsets.only(left: 15.w, right: 10.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('+91'),
                                    SizedBox(width: 10.w),
                                    Container(
                                      width: 1.w,
                                      height: 24.h,
                                      color: AppColors.lightGrey,
                                    ),
                                  ],
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.textFieldBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 16.w),
                            ),
                          ),
                        ),
                        if (errorText != null)
                          Padding(
                            padding: EdgeInsets.only(left: 12.w, top: 4.h),
                            child: Text(
                              errorText,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),

              /// Login Button
              ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (context, isLoading, _) {
                  return SizedBox(
                    width: 297.w,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.loginbutton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                          : Text(
                        'Login',
                        style: AppTextStyles.primaryButton.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

