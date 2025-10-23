import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/config/app_route.dart';
import '../../core/utils/app_constant.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/fonts.dart';

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> onboardingData = [
    OnboardingContent(
      image: AppConstants.onboard1,
      title: AppConstants.onboardTitle1,
      description: AppConstants.onboardSubTitle,
    ),
    OnboardingContent(
      image: AppConstants.onboard2,
      title: AppConstants.onboardTitle2,
      description: AppConstants.onboardSubTitle,
    ),
    OnboardingContent(
      image: AppConstants.onboard3,
      title: AppConstants.onboardTitle3,
      description: AppConstants.onboardSubTitle,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, right: 10.w),
                child: Visibility(
                  visible: _currentPage < onboardingData.length - 1,
                  replacement: SizedBox(height: 48.h),
                  child: TextButton(
                    onPressed: _skip,
                    child: Text(
                      'Skip',
                      style: AppTextStyles.skipButton,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          onboardingData[i].image,
                          height: 300.h,
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          onboardingData[i].title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.onboardingTitle,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          onboardingData[i].description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.onboardingDescription,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      onboardingData.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 8.h,
                        width: _currentPage == index ? 24.w : 8.w,
                        margin: EdgeInsets.only(right: 5.w),
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(60, 30),
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                    ),
                    child: Text(
                      _currentPage == onboardingData.length - 1 ? 'Go' : 'Next',
                      style: AppTextStyles.primaryButton,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}