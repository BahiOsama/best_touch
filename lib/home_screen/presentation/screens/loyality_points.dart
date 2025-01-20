import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';

class LoyaltyPoints extends StatefulWidget {
  const LoyaltyPoints({super.key});

  @override
  State<LoyaltyPoints> createState() => _LoyaltyPointsState();
}

class _LoyaltyPointsState extends State<LoyaltyPoints> {
  int buttonPressCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Loyalty Points".tr()),
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
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) => Column(
                  children: [
                    20.verticalSpace,
                    Text(
                      'Complete 4 washes of the same type and get the fifth one free'
                          .tr(),
                    ),
                    20.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black12.withOpacity(.070)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            subtitle: Text('Small Car - Interior Wash'.tr()),
                            title: Text(
                              'Premium Car Wash'.tr(),
                              style: AppStyles.semiBold16,
                            ),
                            leading: Image.asset(
                              AppImages.smallPhotoForHomeScreenn,
                            ),
                          ),
                          20.verticalSpace,
                          Row(
                            children: [
                              Image.asset(AppImages.gift2),
                              Text("You Have 4 More Prizes For This Car Wash"
                                  .tr()),
                            ],
                          ),
                          20.verticalSpace,
                          Row(
                            children: [
                              SizedBox(
                                height: 33,
                                child: Image.asset(
                                  AppImages.gift3,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Container(
                                  width: 330,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.secondColor.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        width: buttonPressCount == 1
                                            ? 66
                                            : buttonPressCount == 2
                                                ? 132
                                                : buttonPressCount == 3
                                                    ? 198
                                                    : buttonPressCount == 4
                                                        ? 264
                                                        : buttonPressCount == 5
                                                            ? 330
                                                            : 0,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          5.verticalSpace,
                          Text(
                            "$buttonPressCount / 5",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                          15.verticalSpace,
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (buttonPressCount < 5) {
                                  buttonPressCount++;
                                }
                              });
                            },
                            child: const Text("Press"),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}
