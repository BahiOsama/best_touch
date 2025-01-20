import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_styles.dart';

class MonthlyPackagesWidget extends StatelessWidget {
  const MonthlyPackagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(
            msg:
                "Please select the car wash from the list to choose the package you want"
                    .tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red.withOpacity(.1),
            textColor: const Color(
              0xff992600,
            ),
            fontSize: 16.0.r);
      },
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: Colors.black12)),
          padding: const EdgeInsets.only(
            top: 12,
            left: 12,
            bottom: 12,
            right: 12,
          ).r,
          child: Row(
            children: [
              Column(
                children: [
                  Image.asset(AppImages.rial),
                  5.verticalSpace,
                  Image.asset(AppImages.chexhbox),
                ],
              ),
              8.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Super Package'.tr(),
                    style: AppStyles.bold14,
                  ),
                  Text(
                    'Car Size: Large'.tr(),
                    style: AppStyles.medium14
                        .copyWith(color: AppColors.transperantBlack),
                  ),
                  Text(
                    'Regular Wash'.tr(),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Column(
                children: [
                  Text(
                    '150',
                    style: AppStyles.semiBold16,
                  ),
                  Text(
                    'ر.س',
                    style: AppStyles.semiBold16,
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
