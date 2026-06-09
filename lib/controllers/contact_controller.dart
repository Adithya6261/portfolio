import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/email_service.dart';

class ContactController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final RxBool isSubmitting = false.obs;
  final RxBool isSent = false.obs;
  final RxnString copiedField = RxnString();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? validateSubject(String? value) {
    if (value == null || value.trim().isEmpty) return 'Subject is required';
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) return 'Message is required';
    if (value.trim().length < 10) return 'Tell me a little more (10+ chars)';
    return null;
  }

  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isSubmitting.value = true;

    final result = await EmailService.sendContactEmail(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      subject: subjectController.text.trim(),
      message: messageController.text.trim(),
    );

    isSubmitting.value = false;

    if (result.ok) {
      markSent();
      return;
    }

    Get.snackbar(
      'Could not send',
      result.message ?? 'Something went wrong. Please try again later.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade700,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  void markSent() {
    isSent.value = true;
    formKey.currentState?.reset();
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
    Future.delayed(const Duration(seconds: 5), () => isSent.value = false);
  }

  Future<void> openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> copyValue(String value, String fieldKey) async {
    await Clipboard.setData(ClipboardData(text: value));
    copiedField.value = fieldKey;
    Future.delayed(const Duration(seconds: 2), () {
      if (copiedField.value == fieldKey) copiedField.value = null;
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
