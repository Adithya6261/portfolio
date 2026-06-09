import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailJsConfig {
  EmailJsConfig._();

  // EmailJS dashboard → Account → API Keys
  static const String publicKey = '_3Qepd3C8Ax61gq56';
  static const String privateKey = 'rPGBdCIj5De6USyIm81kZ';

  // EmailJS dashboard → Email Services & Templates.
  // 'default_service' is the auto-created Gmail service every account has,
  // so it works out of the box once you create a template. Replace
  // [templateId] with the ID from your "Email Templates" page.
  static const String serviceId = 'default_service';
  static const String templateId = 'template_contact';
}

class EmailService {
  EmailService._();

  static const String endpoint =
      'https://api.emailjs.com/api/v1.0/email/send';

  static bool get isConfigured =>
      EmailJsConfig.templateId != 'template_contact';

  static Future<EmailResult> sendContactEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    if (!isConfigured) {
      return const EmailResult(
        ok: false,
        message: 'EmailJS service/template not configured yet.',
      );
    }

    final body = jsonEncode({
      'service_id': EmailJsConfig.serviceId,
      'template_id': EmailJsConfig.templateId,
      'user_id': EmailJsConfig.publicKey,
      'accessToken': EmailJsConfig.privateKey,
      'template_params': {
        'name': name,
        'from_name': name,
        'email': email,
        'from_email': email,
        'reply_to': email,
        'subject': subject,
        'title': subject,
        'message': message,
      },
    });

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return const EmailResult(ok: true);
      }
      return EmailResult(
        ok: false,
        message: 'Send failed (${response.statusCode}).',
      );
    } catch (e) {
      return const EmailResult(ok: false, message: 'Network error.');
    }
  }
}

class EmailResult {
  final bool ok;
  final String? message;
  const EmailResult({required this.ok, this.message});
}
