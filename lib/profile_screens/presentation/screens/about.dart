import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/profile_screens/presentation/screens/common_questations.dart';
import 'package:second_project/profile_screens/presentation/screens/privacy.dart';
import 'package:second_project/profile_screens/presentation/screens/who_are_we.dart';
import 'package:second_project/profile_screens/presentation/widgets/about_app_widget.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("About the App".tr()),
        leading: Padding(
          padding: AppPadding.appbarpadding,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              AppImages.rightArrow,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: AppPadding.homepadding,
        child: Column(
          children: [
            30.verticalSpace,
            AboutAppWidget(
              leadingImg: AppImages.aboutus,
              text: "Who We Are",
              onTap: () {
                Navigator.of(context)
                    .push(AnimationRoute(page: const WhoAreWe()));
              },
            ),
            15.verticalSpace,
            AboutAppWidget(
              onTap: () {
                Navigator.of(context)
                    .push(AnimationRoute(page: const Privacy()));
              },
              leadingImg: AppImages.privacypolice,
              text: "Privacy Policy",
            ),
            15.verticalSpace,
            AboutAppWidget(
              text: "FAQs",
              leadingImg: AppImages.faqs,
              onTap: () {
                Navigator.of(context)
                    .push(AnimationRoute(page: const CommonQuestations()));
              },
            )
          ],
        ),
      ),
    );
  }
}
