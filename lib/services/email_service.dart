import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class EmailJsConfig {
  EmailJsConfig._();

  // EmailJS dashboard → Account → API Keys
  static const String publicKey = '_3Qepd3C8Ax61gq56';

  // EmailJS dashboard → Email Services & Templates.
  static const String serviceId = 'service_p2g66t7';

  // "Contact Us" template — goes to the portfolio owner.
  static const String contactTemplateId = 'template_y4cc6le';

  // "Auto-Reply" template — goes back to the form submitter.
  static const String autoReplyTemplateId = 'template_fkwovn7';
}

class EmailService {
  EmailService._();

  static const String endpoint =
      'https://api.emailjs.com/api/v1.0/email/send';

  static Future<EmailResult> sendContactEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final params = {
      'name': name,
      'from_name': name,
      'email': email,
      'from_email': email,
      'to_email': email,
      'reply_to': email,
      'subject': subject,
      'title': subject,
      'message': message,
    };

    final contactResult = await sendTemplate(
      EmailJsConfig.contactTemplateId,
      params,
    );
    if (!contactResult.ok) return contactResult;

    // Fire-and-forget the auto-reply — failure here shouldn't block success,
    // but log it so we can see why if the submitter never receives it.
    unawaited(
      sendTemplate(EmailJsConfig.autoReplyTemplateId, params).then((r) {
        developer.log(
          'Auto-reply send ok=${r.ok} ${r.message ?? ''}',
          name: 'EmailService',
        );
      }),
    );

    return const EmailResult(ok: true);
  }

  static Future<EmailResult> sendTemplate(
    String templateId,
    Map<String, dynamic> params,
  ) async {
    final body = jsonEncode({
      'service_id': EmailJsConfig.serviceId,
      'template_id': templateId,
      'user_id': EmailJsConfig.publicKey,
      'template_params': params,
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
        message: 'Send failed (${response.statusCode}): ${response.body}',
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
