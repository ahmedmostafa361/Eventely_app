import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:flutter/material.dart';

import '../../../utlis/app_text .dart';

class CustomDropdown<T> extends StatelessWidget {
  final String title;
  final T? initialValue;
  final List<DropdownMenuEntry<T>> entries;
  final void Function(T?) onSelected;

  const CustomDropdown({
    super.key,
    required this.title,
    required this.initialValue,
    required this.entries,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        SizedBox(height: height * 0.02),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.darkBlueColor, width: 2),
          ),
          child: DropdownMenu<T>(
            initialSelection: initialValue,
            onSelected: onSelected,
            dropdownMenuEntries: entries,
            width: double.infinity,
            textStyle: AppTextStyle.bold20DarkBlue,
            menuStyle: MenuStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.white),
              elevation: const WidgetStatePropertyAll(4),
              surfaceTintColor: const WidgetStatePropertyAll(
                Colors.transparent,
              ),
              shadowColor: const WidgetStatePropertyAll(Colors.black54),
              fixedSize: WidgetStatePropertyAll(
                Size.fromWidth(
                  MediaQuery.of(context).size.width - (width * 0.06),
                ),
              ),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.02,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
