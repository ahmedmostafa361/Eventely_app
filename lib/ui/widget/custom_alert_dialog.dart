import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? middleText;
  final String? buttonText;
  final bool showButton;
  final Widget? contentCustomWidget;
  final VoidCallback? onButtonPressed;
  final TextStyle? middleTextStyle;
  final TextStyle? titleTextStyle;
  final Color? buttonColor;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.middleText,
    this.buttonText,
    this.showButton = true,
    this.contentCustomWidget,
    this.onButtonPressed,
    this.middleTextStyle,
    this.titleTextStyle,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // We leave the built-in title null to avoid forced top-padding
      title: null,
      contentPadding: const EdgeInsets.all(24), // Even padding all around
      content: Column(
        mainAxisSize: MainAxisSize.min, // Dialog shrinks to fit content
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Centered Title
          if (title != null && title!.isNotEmpty) ...[
            Text(
              title!,
              style: titleTextStyle ??
                  theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],

          // 2. Centered Custom Widget (Loading Indicator)
          if (contentCustomWidget != null) ...[
            Center(child: contentCustomWidget),
            const SizedBox(height: 20),
          ],

          // 3. Centered Middle Text
          if (middleText != null)
            Text(
              middleText!,
              style: middleTextStyle ?? theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),

          // 4. Centered Button (Moved inside content for better alignment control)
          if (showButton) ...[
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onButtonPressed?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  buttonText ?? 'Close',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}