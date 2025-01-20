import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_styles.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  'اليوم'.tr(),
                  style: AppStyles.semiBold16,
                ),
                5.verticalSpace,
                Image.asset(AppImages.smallPhotoForHomeScreenn),
              ],
            ),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 26,
                ),
                Text(
                  'Premium Car Wash'.tr(),
                ),
                Text('Your car wash has started now'.tr()),
                7.verticalSpace,
                Row(
                  children: [
                    Image.asset(
                      AppImages.timeCircl,
                      color: AppColors.transperantBlack,
                    ),
                    5.horizontalSpace,
                    Text(
                      '4 minutes ago'.tr(),
                      style: AppStyles.medium14
                          .copyWith(color: AppColors.transperantBlack),
                    ),
                  ],
                ),
              ],
            ),
            44.horizontalSpace,
            Column(
              children: [
                Container(
                  height: 32,
                ),
                TextButton(
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)))),
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.secondColor,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Pay'.tr(),
                    style: AppStyles.medium14
                        .copyWith(color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        25.verticalSpace,
        Row(
          children: List.generate(
            24,
            (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.r),
                  child: Container(
                    height: 1.r,
                    color: AppColors.mainColor,
                  ),
                ),
              );
            },
          ),
        ),
        15.verticalSpace,
      ],
    );
  }
}
