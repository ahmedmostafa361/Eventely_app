import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class OtpService {
  static const _serviceId = 'service_pwbuo19';
  static const _templateId = 'template_2p9bmf5';
  static const _publicKey = '5-3EgWm0PgBtdBhH1';

  static String generateOtp() {
    return (100000 + Random().nextInt(900000)).toString();
  }

  static Future<bool> sendOtpEmail({
    required String toEmail,
    required String otp,
  }) async {
    final response = await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _publicKey,
        'template_params': {'to_email': toEmail, 'otp_code': otp},
      }),
    );

    if (response.statusCode != 200) {
      print('EmailJS error: ${response.statusCode} ${response.body}');
    }
    return response.statusCode == 200;
  }
}
