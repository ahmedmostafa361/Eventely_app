import 'package:flutter/material.dart';

import '../../utlis/app_text .dart';

class EventTimeRow extends StatelessWidget {
  const EventTimeRow({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.icon,
    required this.onPressed,
  });

  final String firstText;
  final String secondText;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 26, color: Theme.of(context).iconTheme.color),
            SizedBox(width: width * 0.025),
            Text(firstText, style: Theme.of(context).textTheme.headlineMedium),
            Spacer(),
            TextButton(
              onPressed: onPressed,
              child: Text(secondText, style: AppTextStyle.normal16DarkBlue),
            ),
          ],
        ),
      ],
    );
  }
}
