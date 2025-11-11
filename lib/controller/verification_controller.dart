import 'package:flutter/material.dart';

class VerificationController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();

  final ValueNotifier<bool> isVerifying = ValueNotifier(false);
  final ValueNotifier<bool> isResending = ValueNotifier(false);

  void dispose() {
    pinController.dispose();
    isVerifying.dispose();
    isResending.dispose();
  }

  Future<void> verifyPin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isVerifying.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isVerifying.value = false;

    // Example success navigation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification successful')),
    );
    pinController.clear();
  }

  Future<void> resendCode(BuildContext context) async {
    isResending.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isResending.value = false;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('New code sent!')),
    );
  }
}
