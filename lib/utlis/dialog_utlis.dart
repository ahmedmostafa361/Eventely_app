import 'package:evently_app_flutter/ui/widget/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtlis {
  static void loadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomAlertDialog(
        button: false,
        contentCustomWidget: CircularProgressIndicator(),
        title: '',
        middleText: 'loading...',
      ),
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showDialogMessage({
    required BuildContext context,
    String? middleText,
    String? buttonText,
    String title = 'Welcome!',
    Function? pushOrPopNavigator,
    var middleTextStyle,
    var titleTextStyle,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomAlertDialog(
        button: true,
        title: title,
        middleText: middleText,
        buttonText: buttonText,
        pushOrPopNavigator: pushOrPopNavigator,
        middleTextStyle: middleTextStyle,
        titleTextStyle: titleTextStyle,
      ),
    );
  }
}
