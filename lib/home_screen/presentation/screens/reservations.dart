import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class Reservations extends StatefulWidget {
  const Reservations({super.key});

  @override
  State<Reservations> createState() => _ReservationsState();
}

bool isCurrentSelected = true;

class _ReservationsState extends State<Reservations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bookings".tr()),
        leading: Padding(
          padding: AppPadding.appbarpadding,
        ),
      ),
      body: Padding(
        padding: AppPadding.homepadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConfirmOrGoBackk(
                  onTap: () {
                    setState(() {
                      isCurrentSelected = true;
                    });
                  },
                  text: 'Current'.tr(),
                  backgroundColor: isCurrentSelected
                      ? AppColors.secondColor
                      : AppColors.secondColor.withOpacity(.13),
                  textColor: isCurrentSelected
                      ? AppColors.whiteColor
                      : AppColors.transperantBlack,
                  width: 185.r,
                  height: 45.r,
                ),
                ConfirmOrGoBackk(
                  onTap: () {
                    setState(() {
                      isCurrentSelected = false;
                    });
                  },
                  backgroundColor: isCurrentSelected
                      ? AppColors.secondColor.withOpacity(.13)
                      : AppColors.secondColor,
                  textColor: isCurrentSelected
                      ? AppColors.transperantBlack
                      : AppColors.whiteColor,
                  text: 'Previous'.tr(),
                  width: 185.r,
                  height: 45.r,
                ),
              ],
            ),
            25.verticalSpace,
            SizedBox(
                height: 600,
                child: isCurrentSelected
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8.r,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) => Card(
                          elevation: 4,
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              right: 12,
                            ).r,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                    AppImages.car,
                                  ),
                                  title: Text(
                                    'Small Car - Interior Wash'.tr(),
                                    style: AppStyles.semiBold14,
                                  ),
                                  subtitle: Text(
                                    'Premium Car Wash'.tr(),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total'.tr(),
                                      ),
                                      Text(
                                        '120 ر.س',
                                        style: AppStyles.medium16,
                                      ),
                                    ],
                                  ),
                                ),
                                ConfirmOrGoBackk(
                                  backgroundColor: AppColors.whiteColor,
                                  textColor: AppColors.secondColor,
                                  borderColor: AppColors.secondColor,
                                  text: 'Show the code to the worker'.tr(),
                                  width: 300,
                                ),
                                8.verticalSpace
                              ],
                            ),
                          ),
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8.r,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) => Card(
                          elevation: 4,
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              right: 12,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                    AppImages.car,
                                  ),
                                  title: Text(
                                    'Small Car - Interior Wash'.tr(),
                                    style: AppStyles.semiBold14,
                                  ),
                                  subtitle: Text(
                                    'Premium Car Wash'.tr(),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total'.tr(),
                                      ),
                                      Text(
                                        '120 ر.س',
                                        style: AppStyles.medium16,
                                      ),
                                    ],
                                  ),
                                ),
                                ConfirmOrGoBackk(
                                  backgroundColor:
                                      AppColors.secondColor.withOpacity(.1),
                                  textColor: AppColors.secondColor,
                                  text: 'Rate the Order'.tr(),
                                  width: 300.r,
                                ),
                                8.verticalSpace
                              ],
                            ),
                          ),
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
