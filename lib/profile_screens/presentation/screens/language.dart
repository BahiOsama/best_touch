import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';

class LocaliziationScreenForProfile extends StatefulWidget {
  const LocaliziationScreenForProfile({super.key});

  @override
  State<LocaliziationScreenForProfile> createState() =>
      _LocaliziationScreenForProfileState();
}

class _LocaliziationScreenForProfileState
    extends State<LocaliziationScreenForProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Language".tr()),
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
      body: Column(
        children: [
          30.verticalSpace,
          InkWell(
            onTap: () {
              context.setLocale(const Locale('ar'));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20).r,
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              width: double.infinity,
              height: 48.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                      color: context.locale == const Locale('ar')
                          ? AppColors.secondColor
                          : AppColors.transperantBlack)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  context.locale == const Locale('ar')
                      ? Image.asset(AppImages.mark)
                      : Container(),
                  Text(
                    'العربية',
                    style: AppStyles.regular16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 18.r,
          ),
          InkWell(
            onTap: () {
              context.setLocale(const Locale('en'));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20).r,
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                      color: context.locale == const Locale('en')
                          ? AppColors.secondColor
                          : AppColors.transperantBlack)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'English',
                    style: AppStyles.regular16,
                  ),
                  context.locale == const Locale('en')
                      ? Image.asset(AppImages.mark)
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
