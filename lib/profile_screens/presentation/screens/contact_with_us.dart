import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';
import 'package:second_project/widgets/textField.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contact Us".tr()),
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
        child: ListView(
          children: [
            30.verticalSpace,
            Text(
              "Username*".tr(),
              style: AppStyles.regular14,
            ),
            3.verticalSpace,
            TextFieldWidget(
              prefixIcon: Image.asset(
                AppImages.profile,
              ),
              hintText: "Username".tr(),
            ),
            15.verticalSpace,
            Text(
              "phone number*".tr(),
              style: AppStyles.regular14,
            ),
            3.verticalSpace,
            TextFieldWidget(
              keyboardType: TextInputType.number,
              obsecureText: false,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 16, left: 12).r,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppImages.saudiFlag,
                    ),
                    SizedBox(
                      width: 8.r,
                    ),
                    const Text(
                      '+966',
                    )
                  ],
                ),
              ),
              hintText: "Enter phone number".tr(),
            ),
            15.verticalSpace,
            Text(
              "Email*".tr(),
              style: AppStyles.regular14,
            ),
            3.verticalSpace,
            TextFieldWidget(
              prefixIcon: Image.asset(
                AppImages.gmail,
                color: Colors.black26,
              ),
              hintText: "Email".tr(),
            ),
            15.verticalSpace,
            Text(
              "Your Message*".tr(),
              style: AppStyles.regular14,
            ),
            3.verticalSpace,
            TextField(
              decoration: InputDecoration(
                  hintText: "For example: I face an issue with booking...".tr(),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.secondColor))),
              maxLines: 5,
              maxLength: 25,
            ),
            25.verticalSpace,
            ConfirmOrGoBackk(text: 'Send'.tr()),
            25.verticalSpace,
            Text("For inquiries and complaints, you can contact us through:"
                .tr()),
            15.verticalSpace,
            Row(
              children: [
                Image.asset(
                  AppImages.coloredicon,
                  color: AppColors.secondColor,
                ),
                8.horizontalSpace,
                Text(
                  '+966 541200849',
                  style: AppStyles.regular12
                      .copyWith(color: AppColors.secondColor),
                ),
              ],
            ),
            7.verticalSpace,
            Row(
              children: [
                Image.asset(
                  AppImages.coloredicon2,
                  color: AppColors.secondColor,
                ),
                8.horizontalSpace,
                Text(
                  'support@besttouch.com',
                  style: AppStyles.regular12
                      .copyWith(color: AppColors.secondColor),
                ),
              ],
            ),
            7.verticalSpace,
            Row(
              children: [
                Image.asset(
                  AppImages.coloredicon3,
                  color: AppColors.secondColor,
                ),
                8.horizontalSpace,
                Text(
                  'الرياض - جدة',
                  style: AppStyles.regular12
                      .copyWith(color: AppColors.secondColor),
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(AppImages.facebook),
                Image.asset(AppImages.insta),
                Image.asset(AppImages.x),
                Image.asset(AppImages.snap),
              ],
            ),
            60.verticalSpace
          ],
        ),
      ),
    );
  }
}
