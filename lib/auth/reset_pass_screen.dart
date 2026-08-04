import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../l10n/app_localizations.dart';
import '../otp_notification_service/otp_service.dart';
import '../ui/widget/custom_elevated_button .dart';
import '../utlis/app_assets .dart';
import '../utlis/app_colors .dart';
import '../utlis/app_text .dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

enum _Step { enterEmail, enterOtp }

class _ResetPassScreenState extends State<ResetPassScreen> {
  _Step step = _Step.enterEmail;
  bool isLoading = false;

  final emailController = TextEditingController();
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      _showMessage('Please enter a valid email');
      return;
    }

    setState(() => isLoading = true);

    final otp = OtpService.generateOtp();

    await FirebaseFirestore.instance
        .collection('password_reset_otps')
        .doc(email)
        .set({
          'otp': otp,
          'expiresAt': DateTime.now().add(const Duration(minutes: 5)),
        });

    final sent = await OtpService.sendOtpEmail(toEmail: email, otp: otp);

    setState(() => isLoading = false);

    if (sent) {
      pinController.clear();
      setState(() => step = _Step.enterOtp);
    } else {
      _showMessage('Failed to send code. Please try again.');
    }
  }

  Future<void> _verifyCode() async {
    final email = emailController.text.trim();
    final enteredCode = pinController.text;

    if (enteredCode.length < 6) {
      _showMessage('Please enter the full code');
      return;
    }

    setState(() => isLoading = true);

    final doc = await FirebaseFirestore.instance
        .collection('password_reset_otps')
        .doc(email)
        .get();

    if (!doc.exists) {
      setState(() => isLoading = false);
      _showMessage('No code found, please request a new one');
      return;
    }

    final data = doc.data()!;
    final expiresAt = (data['expiresAt'] as Timestamp).toDate();
    final storedOtp = data['otp'] as String;

    if (DateTime.now().isAfter(expiresAt)) {
      setState(() => isLoading = false);
      _showMessage('Code expired, please request a new one');
      pinController.clear();
      return;
    }

    if (storedOtp != enteredCode) {
      setState(() => isLoading = false);
      _showMessage('Incorrect code');
      pinController.clear();
      focusNode.requestFocus(); // ready to retype immediately
      return;
    }

    await FirebaseFirestore.instance
        .collection('password_reset_otps')
        .doc(email)
        .delete();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() => isLoading = false);
      _showMessage('Verified! Check your email for the password reset link.');
      if (mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);
      _showMessage(e.message ?? 'Something went wrong');
    } catch (e) {
      setState(() => isLoading = false);
      _showMessage('Unexpected error: $e');
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: width * 0.13,
      height: width * 0.13,
      textStyle: AppTextStyle.normal20DarkBlue,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.darkBlueColor),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.darkBlueColor, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.darkBlueColor.withOpacity(0.1),
        border: Border.all(color: AppColors.darkBlueColor),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.darkBlueColor),
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.reset_password,
          style: AppTextStyle.normal20DarkBlue,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(image: AssetImage(AppAssets.resetImage)),
              SizedBox(height: height * 0.02),

              if (step == _Step.enterEmail) ...[
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  onPressed: isLoading ? () {} : _sendCode,
                  text: isLoading ? '...' : 'Send Code',
                ),
              ],

              if (step == _Step.enterOtp) ...[
                Text('Enter the code sent to ${emailController.text}'),
                SizedBox(height: height * 0.02),

                Center(
                  child: Pinput(
                    length: 6,
                    controller: pinController,
                    focusNode: focusNode,
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    showCursor: true,
                    onCompleted: (pin) {
                      focusNode.unfocus();
                      _verifyCode();
                    },
                  ),
                ),

                SizedBox(height: height * 0.01),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            pinController.clear();
                            _sendCode();
                          },
                    child: const Text('Resend code'),
                  ),
                ),
                SizedBox(height: height * 0.01),
                CustomElevatedButton(
                  onPressed: isLoading
                      ? () {}
                      : () {
                          focusNode.unfocus();
                          _verifyCode();
                        },
                  text: isLoading
                      ? '...'
                      : AppLocalizations.of(context)!.reset_password,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}