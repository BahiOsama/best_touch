import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/home_screen/presentation/screens/loyality_points.dart';
import 'package:second_project/home_screen/presentation/screens/packages.dart';

class LoyalityAndPackagesWidget extends StatelessWidget {
  const LoyalityAndPackagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(AnimationRoute(page: const LoyaltyPoints()));
          },
          child: Card(
            elevation: 4,
            color: Colors.white,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 12, right: 12, left: 6, bottom: 11)
                      .r,
              width: 170.r,
              height: 120.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  const Radius.circular(8).r,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loyalty Points'.tr(),
                        style: AppStyles.medium18,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        AppImages.pointsally,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        10.horizontalSpace,
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              AnimationRoute(
                page: const Packages(),
              ),
            );
          },
          child: Card(
            elevation: 4,
            color: Colors.white,
            child: Container(
              padding:
                  const EdgeInsets.only(top: 12, right: 12, left: 6, bottom: 2)
                      .r,
              width: 170,
              height: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Packages'.tr(),
                        style: AppStyles.medium18,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        AppImages.paaackages,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
