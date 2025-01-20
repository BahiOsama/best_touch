import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_project/helper/app_images.dart';
import 'package:second_project/helper/app_padding.dart';
import 'package:second_project/profile_screens/presentation/widgets/packagesWidget.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details".tr()),
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
            20.verticalSpace,
            PackagesWidget(
              title: 'كلين اوف',
              leadingImg: AppImages.photo2,
              subtitle: "Details of the Subscribed Package:".tr(),
              subtitle2:
                  "Super Package, Large Car, Interior Cleaning and Polishing"
                      .tr(),
              subtitle3: "Package Validity:".tr(),
              num: '12',
              dayorweekormonth: 'day',
            ),
          ],
        ),
      ),
    );
  }
}
