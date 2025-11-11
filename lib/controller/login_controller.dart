import 'package:flutter/material.dart';
import '../features/Login/verification_screen.dart';


class LoginController {
  final phoneController = TextEditingController();
  final isLoading = ValueNotifier<bool>(false);

  Future<void> submitLogin(BuildContext context) async {
    final phone = phoneController.text.trim();

    if (phone.isEmpty || phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit phone number')),
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VerificationScreen()),
    );
  }

  void dispose() {
    phoneController.dispose();
    isLoading.dispose();
  }
}
