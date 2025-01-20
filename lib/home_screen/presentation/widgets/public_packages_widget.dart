import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class PublicPackagesWidget extends StatelessWidget {
  const PublicPackagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black12)),
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 12,
          right: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '50 ر.س',
              style: AppStyles.medium14,
            ),
            Text(
              '+15 ر.س Free'.tr(),
              style: AppStyles.medium14
                  .copyWith(color: AppColors.transperantBlack),
            ),
            5.verticalSpace,
            ConfirmOrGoBackk(
              text: 'Buy'.tr(),
              width: 135,
              height: 36,
            )
          ],
        ),
      ),
    );
  }
}
