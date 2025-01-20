import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/helper/app_styles.dart';
import 'package:second_project/widgets/confirmOrGoBackWidget.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Wallet".tr()),
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
        child: Column(
          children: [
            30.verticalSpace,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black12),
                      left: BorderSide(color: Colors.black12),
                      right: BorderSide(color: Colors.black12),
                      top: BorderSide(color: Colors.black12)),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available Balance".tr(),
                    style: AppStyles.medium14,
                  ),
                  Text(
                    '150 ر.س',
                    style: AppStyles.medium18,
                  ),
                ],
              ),
            ),
            30.verticalSpace,
            ConfirmOrGoBackk(
              onTap: () {},
              text: "Buy Balance".tr(),
            ),
          ],
        ),
      ),
    );
  }
}
