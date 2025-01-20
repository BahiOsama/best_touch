import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_colors.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/helper/page_route_fadeTransition.dart';
import 'package:second_project/helper/web_view.dart';
import 'package:second_project/home_screen/presentation/screens/normal_wash.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class Payment extends StatefulWidget {
  const Payment(
      {super.key, required this.init, required this.add, required this.all});
  final double init, add, all;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late int currentOption = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Payment".tr()),
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
            Text(
              'Choose a suitable payment method'.tr(),
              style: AppStyles.medium18,
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                              vertical: 36, horizontal: 60)
                          .r,
                      child: Center(
                        child: Column(
                          children: [
                            7.verticalSpace,
                            Image.asset(
                              AppImages.gift,
                            ),
                            5.verticalSpace,
                            Text(
                              'Reward'.tr(),
                              style: AppStyles.medium16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                              vertical: 35, horizontal: 40)
                          .r,
                      child: Center(
                        child: Column(
                          children: [
                            7.verticalSpace,
                            Image.asset(
                              AppImages.rial,
                            ),
                            5.verticalSpace,
                            Text(
                              'Monthly Package'.tr(),
                              style: AppStyles.medium16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            GestureDetector(
              onTap: () {
                setState(() {
                  currentOption = 0;
                });
              },
              child: Card(
                elevation: 4,
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color:
                        currentOption == 0 ? Colors.green : Colors.transparent,
                  )),
                  padding: const EdgeInsets.only(
                    top: 18,
                    right: 24,
                    left: 12,
                    bottom: 18,
                  ).r,
                  child: Row(
                    children: [
                      Image.asset(AppImages.wallet),
                      10.horizontalSpace,
                      Text(
                        'Wallet'.tr(),
                      ),
                      const Spacer(),
                      const Text('40 ر.س'),
                    ],
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            GestureDetector(
              onTap: () {
                setState(() {
                  currentOption = 1;
                });
              },
              child: Card(
                elevation: 4,
                color: Colors.white,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12).r,
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.3.r,
                        child: Radio(
                          value: 1,
                          groupValue: currentOption,
                          onChanged: (value) {
                            setState(() {
                              currentOption = value!;
                            });
                          },
                        ),
                      ),
                      Image.asset(AppImages.cash),
                      10.horizontalSpace,
                      Text(
                        'Cash on Delivery'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            GestureDetector(
              onTap: () {
                setState(() {
                  currentOption = 2;
                });
              },
              child: Card(
                elevation: 4,
                color: Colors.white,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12).r,
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Radio(
                          value: 2,
                          groupValue: currentOption,
                          onChanged: (value) {
                            setState(() {
                              currentOption = value!;
                            });
                          },
                        ),
                      ),
                      10.horizontalSpace,
                      Text(
                        'Electronic Payment'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12))),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price'.tr(),
                  ),
                  Text(
                    '${widget.init} ر.س',
                    style: AppStyles.medium14,
                  ),
                ],
              ),
            ),
            if (additionalServicesSelected.contains(true))
              Padding(
                padding: const EdgeInsets.only(top: 6.0).r,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add-ons'.tr(),
                        ),
                        Text(
                          '${widget.add} ر.س',
                          style: AppStyles.medium14,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0).r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total'.tr(),
                          ),
                          Text(
                            '${widget.all} ر.س',
                            style: AppStyles.medium14
                                .copyWith(color: AppColors.secondColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            20.verticalSpace,
            ConfirmOrGoBackk(
              text: 'Pay'.tr(),
              onTap: () {
                Navigator.of(context).push(
                  AnimationRoute(
                    page: const WebViewPaymentScreen(
                        url:
                            'https://demo.MyFatoorah.com/KWT/ie/050723525499173563-e0e254d1'),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
