import 'package:evently_app_flutter/ui/widget/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtlis {
  static void loadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const CustomAlertDialog(
        showButton: false,
        // Standardized size for the loading circle
        contentCustomWidget: SizedBox(
          height: 45,
          width: 45,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
        middleText: 'Loading...',
      ),
    );
  }

  static void hideDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void showDialogMessage({
    required BuildContext context,
    String? middleText,
    String? buttonText,
    String? title = 'Welcome!',
    VoidCallback? onButtonPressed,
    TextStyle? middleTextStyle,
    TextStyle? titleTextStyle,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomAlertDialog(
        showButton: true,
        title: title,
        middleText: middleText,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed,
        middleTextStyle: middleTextStyle,
        titleTextStyle: titleTextStyle,
      ),
    );
  }
}