import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/app_theme_provider .dart';
import '../../utlis/app_assets .dart';
import '../../utlis/app_colors .dart';
import '../../utlis/app_routes .dart';
import '../../utlis/app_text .dart';

class IntroScreen extends StatelessWidget {


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
    var themeProvider = Provider.of<AppThemeProvider>(context);

    List<PageViewModel> getPages() {
      return [
        pagesOfIntro(context: context,
            themeProvider: themeProvider,
            img2: AppAssets.onBoard2,
            text: AppLocalizations.of(context)!.pg2t1,
            text2: AppLocalizations.of(context)!.pg2t2,
            width: width,
            height: height),
        pagesOfIntro(context: context,
            themeProvider: themeProvider,
            img2: AppAssets.onBoard3,
            text: AppLocalizations.of(context)!.pg3t1,
            text2: AppLocalizations.of(context)!.pg3t2,
            width: width,
            height: height),
        pagesOfIntro(context: context,
            themeProvider: themeProvider,
            img2: AppAssets.onBoard4,
            text: AppLocalizations.of(context)!.pg4t1,
            text2: AppLocalizations.of(context)!.pg4t2,
            width: width,
            height: height),
      ];
    }
    return Scaffold(
      body: Container(
        child: IntroductionScreen(
          globalHeader: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image: AssetImage(AppAssets.logo),),
          ),
          globalBackgroundColor: themeProvider.isDarkMode()
              ? AppColors.bgDark
              : AppColors.bgLight,
          pages: getPages(),
          showSkipButton: false,
          showBackButton: true,
          back: Image(image: AssetImage(AppAssets.arrowLeft)),
          // skip: Text('Skip', style: TextStyle(color: AppColors.darkBlueColor,)),
          next: Image(image: AssetImage(AppAssets.arrowRight)),
          // Text('Next', style: TextStyle(color: AppColors.darkBlueColor,)),
          done: Text('Done', style: TextStyle(color: AppColors.darkBlueColor,)),
          dotsDecorator: DotsDecorator(
            activeColor: AppColors.darkBlueColor,
            color: themeProvider.isDarkMode() ? AppColors.whiteColor : AppColors
                .blackColor,
          ),
          onDone: () {
            Navigator.of(context).pushReplacementNamed(
                AppRoutes.profileTabScreen);
          },
        ),
      ),
    );

  }

  PageViewModel pagesOfIntro(
      {required String img2, required BuildContext context, required String text, String text2 = '', required double height, required double width, required AppThemeProvider themeProvider}) {
    return PageViewModel(
      decoration: PageDecoration(boxDecoration: BoxDecoration(
          color: themeProvider.isDarkMode() ? AppColors.bgDark : AppColors
              .bgLight)),
      bodyWidget: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image: AssetImage(img2),
              height: height * 0.429,
              width: double.infinity,),
            SizedBox(height: height * 0.03),
            Text(text, style: AppTextStyle.bold20DarkBlue,
              textAlign: TextAlign.start,),
            SizedBox(height: height * 0.03,),
            Text(
              text2, style: Theme
                .of(context)
                .textTheme
                .bodyMedium, textAlign: TextAlign.start,)
          ],
        ),
      ),
      titleWidget: SizedBox.shrink(),
    );
  }

}