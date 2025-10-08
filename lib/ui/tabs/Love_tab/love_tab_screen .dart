import 'package:evently_app_flutter/utlis/app_colors%20.dart';
import 'package:evently_app_flutter/utlis/app_text%20.dart';
import 'package:flutter/material.dart';

class LoveTabScreen extends StatelessWidget {
  const LoveTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.02),
      child: SafeArea(
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Search for Event',
                hintStyle: AppTextStyle.bold14DarkBlue,
                prefixIcon: Icon(
                  Icons.search_outlined, color: AppColors.darkBlueColor,
                  size: 24,),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        width: 2, color: AppColors.darkBlueColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        width: 2, color: AppColors.darkBlueColor))
            ),
          ),
          SizedBox(height: height * 0.012,),
          Expanded(
            child: ListView.separated
              (
                itemBuilder: (context, index) {
                  return Container();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0.01,);
                },
                itemCount: 6
            ),
          )
        ],

        ),
      ),
    );
  }
}
