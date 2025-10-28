import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../core/utils/app_constant.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }


  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      print('Form is valid! Phone: ${_phoneController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging in...')),
      );

    } else {
      print('Form is invalid!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textFieldInputStyle = TextStyle(
      fontSize: 16.sp,
      color: AppColors.black,
      fontWeight: FontWeight.normal,
    );

    final TextStyle textFieldHintStyle = TextStyle(
      fontSize: 16.sp,
      color: AppColors.textGrey,
      fontWeight: FontWeight.normal,
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaPadding = MediaQuery.of(context).padding;
    final minViewHeight =
        screenHeight - safeAreaPadding.top - safeAreaPadding.bottom;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: minViewHeight,
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      AppConstants.logo,
                      height: 300.h,
                      width: 300.w,
                    ),
                    SizedBox(height: 16.h),


                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: textFieldInputStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10), // Limits input to 10 chars
                      ],

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length != 10) {
                          return 'Phone number must be 10 digits';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: textFieldHintStyle,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 10.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '+1',

                              ),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),

                    ElevatedButton(
                      onPressed: _submitLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.loginbutton,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: AppTextStyles.primaryButton,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}