import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_styles.dart';

class PackagesWidget extends StatelessWidget {
  const PackagesWidget({
    super.key,
    required this.title,
    required this.leadingImg,
    this.onTap,
    required this.subtitle,
    required this.subtitle2,
    this.subtitle3,
    this.dayorweekormonth,
    this.num,
  });
  final String title, leadingImg, subtitle, subtitle2;
  final String? subtitle3, dayorweekormonth, num;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.whiteColor,
        elevation: .7,
        child: Container(
          padding: const EdgeInsets.all(12).r,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(leadingImg),
              SizedBox(
                width: 12.r,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.tr(),
                    style: AppStyles.medium16,
                  ),
                  Text(
                    subtitle.tr(),
                    style: AppStyles.medium12,
                  ),
                  Text(
                    subtitle2.tr(),
                    style: AppStyles.medium12,
                  ),
                  Row(
                    children: [
                      Text(
                        subtitle3 ?? ''.tr(),
                        style: AppStyles.medium12
                            .copyWith(color: AppColors.secondColor),
                      ),
                      4.horizontalSpace,
                      Text(
                        num ?? '',
                        style: AppStyles.medium12
                            .copyWith(color: AppColors.secondColor),
                      ),
                      4.horizontalSpace,
                      Text(
                        dayorweekormonth ?? ''.tr(),
                        style: AppStyles.medium12
                            .copyWith(color: AppColors.secondColor),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
