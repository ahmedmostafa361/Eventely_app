import 'package:flutter/material.dart';

import '../../utlis/app_colors .dart';

class SelectorRow extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final List<Widget> children;

  const SelectorRow({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.darkBlueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Container(
          width: width * 0.3,
          height: height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.darkBlueColor, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: children,
          ),
        ),
      ],
    );
  }
}

class CircleOptionButton extends StatelessWidget {
  final Widget widget;
  final bool isActive;

  // final String image;
  final VoidCallback onTap;
  final Color? colorFilter;

  CircleOptionButton({
    super.key,
    required this.widget,
    required this.isActive,
    // required this.image,
    required this.onTap,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.002),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
            radius: 18,
            backgroundColor: isActive
                ? AppColors.darkBlueColor
                : AppColors.transparentColor,
            child: widget
          // Image.asset(image, fit: BoxFit.fill, color: colorFilter),
        ),
      ),
    );
  }
}
